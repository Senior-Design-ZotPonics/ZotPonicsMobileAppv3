import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'textWidget.dart';

///Currently only has hard-coded profiles
///If we were to allow users to add their own profiles or load from the database,
///this would require a bit more work

///Stores profile info
class Profile {
  String name;
  int maxTemp;
  int maxHumid;
  int lightStart;
  int lightEnd;
  int duration;
  int frequency;
  int nutrientRatio;

  Profile(this.name, this.maxTemp, this.maxHumid, this.lightStart, this.lightEnd, this.duration, this.frequency, this.nutrientRatio);
}

///Preset profiles
Profile Grass = Profile("Grass", 0, 0, 0, 0, 0, 0, 0);
Profile Cactus = Profile("Cactus", 100, 100, 100, 100, 100, 100, 100);
Profile Tomato = Profile("Tomato", 50, 50, 50, 50, 50, 50, 50);
Profile Weeds = Profile("Weeds", 42, 42, 42, 42, 42, 42, 42);

List<Profile> profiles = [Grass, Cactus, Tomato, Weeds];


///Profile selection page

class ProfilePage extends StatefulWidget {
  final String _font;

  ///Controller objects
  final maxTemp;
  final maxHumid;
  final lightStart;
  final lightEnd;
  final duration;
  final frequency;
  final nutrientRatio;

  ///Constructor
  ProfilePage(this._font, this.maxTemp, this.maxHumid, this.lightStart, this.lightEnd, this.duration, this.frequency, this.nutrientRatio);

  @override
  State<StatefulWidget> createState() => _ProfilePage(_font, maxTemp, maxHumid, lightStart, lightEnd, duration, frequency, nutrientRatio);
}


class _ProfilePage extends State<ProfilePage> {
  final String _font;
  final maxTemp;
  final maxHumid;
  final lightStart;
  final lightEnd;
  final duration;
  final frequency;
  final nutrientRatio;

  ///Constructor
  _ProfilePage(this._font, this.maxTemp, this.maxHumid, this.lightStart, this.lightEnd, this.duration, this.frequency, this.nutrientRatio);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///Off-white background
        backgroundColor: const Color(0xFFF8F8F8),
        appBar: PreferredSize(
          ///Modifies height of AppBar
            preferredSize: Size.fromHeight(60.0),
            child: AppBar(
                automaticallyImplyLeading: false, ///Removes automatically included back button
                title: Text(
                    'Profiles',
                    style: TextStyle(
                        height: 1.5,
                        fontFamily: _font,
                        fontWeight: FontWeight.w600,
                        fontSize: 36.0,
                        color: Colors.white
                    )
                ),
                actions: [
                  ///X button
                  Padding(
                      padding: EdgeInsets.only(top: 5.0, right: 2.0),
                      child: IconButton(
                          icon: Icon(Icons.close, color: Colors.white),
                          iconSize: 35.0,
                          splashColor: Colors.transparent,
                          ///Go to previous page
                          onPressed: () => Navigator.of(context).pop(false) ///Profile not loaded
                      )
                  )
                ]
            )
        ),
        ///Profile list view
        body: Container(
          child: ListView.builder(
            itemCount: profiles.length,
            itemBuilder: (context, int i) {
              return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ListTile(
                        dense: true,
                        title: TextWidget(profiles[i].name, _font, Colors.black, FontWeight.w300, 20.0),
                        onTap: () {
                          ///Sets controller values to those of profile
                          maxTemp.text = profiles[i].maxTemp.toString();
                          maxHumid.text = profiles[i].maxHumid.toString();
                          lightStart.text = profiles[i].lightStart.toString();
                          lightEnd.text = profiles[i].lightEnd.toString();
                          duration.text = profiles[i].duration.toString();
                          frequency.text = profiles[i].frequency.toString();
                          nutrientRatio.text = profiles[i].nutrientRatio.toString();

                          Navigator.of(context).pop(true); ///Profile loaded
                        }
                    ),
                    Divider(
                        height: 2.0,
                        color: Colors.grey
                    )
                  ]
              );
            }
          )
        )
    );
  }
}