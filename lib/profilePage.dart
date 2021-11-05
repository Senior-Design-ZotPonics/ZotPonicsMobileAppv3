import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'textWidget.dart';
import 'services.dart';

///Stores profile info
class Profile {
  String name;
  int maxTemp;
  int maxHumid;
  int lightStart;
  int lightEnd;
  int duration;
  int frequency;

  Profile(this.name, this.maxTemp, this.maxHumid, this.lightStart, this.lightEnd, this.duration, this.frequency);
}

///Preset profiles
Profile Spinach = Profile("Spinach", 22, 60, 8, 20, 300, 10800);
Profile Lettuce = Profile("Lettuce", 22, 60, 8, 18, 300, 10800);
Profile Kale = Profile("Kale", 21, 60, 8, 4, 300, 10800);
Profile Pepper = Profile("Pepper", 22, 60, 6, 22, 300, 10800);
Profile Onion = Profile("Onion", 19, 70, 7, 19, 300, 10800);
Profile Tomato = Profile("Tomato", 27, 60, 6, 22, 300, 10800);

List<Profile> profiles = [Spinach, Lettuce, Kale, Pepper, Onion, Tomato];
List<String> profileNames = ["Select a profile"];

///Profile selection page

class ProfilePage extends StatefulWidget {
  final String _font;
  final int shelfNumber;

  ///Controller objects
  final maxTemp;
  final maxHumid;
  final lightStart;
  final lightEnd;
  final duration;
  final frequency;

  ///Constructor
  ProfilePage(this._font, this.shelfNumber, this.maxTemp, this.maxHumid, this.lightStart, this.lightEnd, this.duration, this.frequency);

  getProfileNames() {
    return profileNames.sublist(1);
  }

  @override
  State<StatefulWidget> createState() => _ProfilePage(_font, shelfNumber, maxTemp, maxHumid, lightStart, lightEnd, duration, frequency);
}

class _ProfilePage extends State<ProfilePage> {
  final String _font;
  final int shelfNumber;
  final int maxTemp;
  final int maxHumid;
  final int lightStart;
  final int lightEnd;
  final int duration;
  final int frequency;

  final profileField = TextEditingController();
  String newName = '';

  String deleteName = "Select a profile"; /// default value for delete drop-down menu

  @override
  void initState() {
    super.initState();
  }

  getProfileValue() {
    setState( () { newName = profileField.text.toString(); } );
  }

  deleteProfile(String name) {
    profiles.removeWhere( (item) => item.name == name);
    profileNames.remove(name);
    setState( () { /// reset drop-down menu
      if (profileNames.length == 1) {
        deleteName = profileNames[0];
      }
      else {
        deleteName = profileNames[1];
      }
    });
  }

  @override
  void dispose() {
    profileField.dispose();
    super.dispose();
  }

  bool postSettings(Profile plant) {
    CGPostPut post = CGPostPut(
        writings: [ CGWriting(
            timestamp: DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()),
            lightStart: plant.lightStart,
            lightEnd: plant.lightEnd,
            humidity: plant.maxHumid,
            temp: plant.maxTemp,
            waterFreq: plant.frequency,
            waterDuration: plant.duration,
            baseLevel: 40,
            shelfNumber: shelfNumber
        )]
    );

    postControlGrowth(post, shelfNumber).then((response) {
      if(response.statusCode > 200)
        print(response.body);
      else
        print(response.statusCode);
    }).catchError((error) {
      print('error : $error');
      return false;
    });

    return true;
  }

  ///Constructor
  _ProfilePage(this._font, this.shelfNumber, this.maxTemp, this.maxHumid, this.lightStart, this.lightEnd, this.duration, this.frequency);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        /// off-white background
        backgroundColor: const Color(0xFFF8F8F8),
        appBar: PreferredSize(
            /// modifies height of AppBar
            preferredSize: Size.fromHeight(60.0),
            child: AppBar(
                automaticallyImplyLeading: false, /// removes automatically included back button
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
                          /// go back to previous page
                          onPressed: () => Navigator.of(context).pop(false) /// profile not loaded - not sure if profileLoaded is still needed
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
                      children: <Widget>[
                        ListTile(
                            dense: true,
                            title: TextWidget(profiles[i].name, _font, Colors.black, FontWeight.w300, 20.0),
                            trailing: FlatButton( /// load button changes current settings to profile's settings
                                child: TextWidget("Load", _font, Colors.green, FontWeight.w300, 15.0),
                                onPressed: () {
                                    if (postSettings(profiles[i])) {
                                      Scaffold.of(context).showSnackBar( /// pop-up confirmation bar
                                          SnackBar(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(10.0),
                                                      topRight: Radius.circular(10.0))
                                              ),
                                              duration: Duration(seconds: 1, milliseconds: 500),
                                              content: Text('Profile loaded!')
                                          )
                                      );
                                    }
                                }
                            )
                        ),
                        Divider(
                          height: 5.0,
                          color: Colors.black26,
                        )
                      ]
                  );
                }
            )
        ),
        bottomNavigationBar: new BottomAppBar( /// create and delete buttons
            child: Row(
                children: <Widget>[
                    Expanded(
                       child: FlatButton(
                           color: Colors.white,
                           child: TextWidget("Create", _font, Colors.green, FontWeight.w400, 15.0),
                           onPressed: () {
                             showDialog(
                                 context: context,
                                 builder: (_) => new AlertDialog( /// pop-up window to enter new profile name
                                     title: Column(
                                         children: [
                                             TextWidget("New profile name", _font, Colors.black, FontWeight.w400, 15.0),
                                             TextWidget("Current settings will be saved under this name", _font, Colors.black54, FontWeight.w400, 10.0)
                                         ]
                                     ),
                                     content: new TextField(
                                         controller: profileField,
                                         obscureText: false,
                                         decoration: InputDecoration( border: OutlineInputBorder() )
                                     ),
                                     actions: <Widget>[
                                       RaisedButton(
                                           child: TextWidget("Create", _font, Colors.white, FontWeight.w400, 15.0),
                                           color: Colors.green,
                                           onPressed: () { /// make sure that the new profile name isn't empty and doesn't exist already
                                               getProfileValue();
                                               List<String> existingProfiles = [];
                                               for (int p = 0; p < profiles.length; p++) { existingProfiles.add(profiles[p].name); }
                                               if (newName != "" && !existingProfiles.contains(newName)) {
                                                   profiles.add(Profile(newName, this.maxTemp, this.maxHumid, this.lightStart, this.lightEnd, this.duration, this.frequency));
                                                   profileNames.add(newName);
                                                   Navigator.of(context).pop();
                                               }
                                           }
                                       )
                                     ]
                                 )
                             );
                           }
                       )
                    ),
                    Container(
                      width: 1.0,
                      height: 30.0,
                      color: Colors.black26
                    ),
                    Expanded(
                      child: FlatButton(
                          color: Colors.white,
                          child: TextWidget("Delete", _font, Colors.green, FontWeight.w400, 15.0),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (_) => new AlertDialog( /// pop-up window of a drop-down menu of created profiles
                                    title: TextWidget("Delete a profile", _font, Colors.black, FontWeight.w400, 15.0),
                                    content: StatefulBuilder(
                                      builder: (BuildContext context, StateSetter setState) {
                                        return new DropdownButton(
                                            hint: Text("Select profile"),
                                            value: deleteName,
                                            onChanged: (String name) {
                                              setState( () { deleteName = name; } );
                                            },
                                            items: profileNames.map((String name) {
                                              return new DropdownMenuItem<String>(
                                                  value: name,
                                                  child: new Text(name)
                                              );
                                            }).toList()
                                        );
                                      }
                                    ),
                                    actions: <Widget>[
                                      RaisedButton(
                                          child: TextWidget("Delete", _font, Colors.white, FontWeight.w400, 15.0),
                                          color: Colors.green,
                                          onPressed: () { /// make sure the user selected a profile
                                            if (deleteName != "Select a profile") {
                                              deleteProfile(deleteName);
                                              Navigator.of(context).pop();
                                            }
                                          }
                                      )
                                    ]
                                )
                            );
                          }
                      )
                    )
            ]
          )
        )
    );
  }
}