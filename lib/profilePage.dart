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
  int nutrientRatio;

  Profile(this.name, this.maxTemp, this.maxHumid, this.lightStart, this.lightEnd, this.duration, this.frequency, this.nutrientRatio);
}

///Preset profiles
Profile Lettuce = Profile("Lettuce", 0, 0, 0, 0, 0, 0, 0);
Profile Potato = Profile("Potato", 100, 100, 100, 100, 100, 100, 100);
Profile Spinach = Profile("Spinach", 50, 50, 50, 50, 50, 50, 50);
Profile Tomato = Profile("Tomato", 42, 42, 42, 42, 42, 42, 42);

List<Profile> profiles = [Lettuce, Potato, Spinach, Tomato];
List<String> profileNames = [];

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
  final nutrientRatio;

  ///Constructor
  ProfilePage(this._font, this.shelfNumber, this.maxTemp, this.maxHumid, this.lightStart, this.lightEnd, this.duration, this.frequency, this.nutrientRatio);

  @override
  State<StatefulWidget> createState() => _ProfilePage(_font, shelfNumber, maxTemp, maxHumid, lightStart, lightEnd, duration, frequency, nutrientRatio);
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
  final int nutrientRatio;

  final profileField = TextEditingController();
  String newName = '';

  String deleteName; //needs to be an existing value from profileNames

  @override
  void initState() {
    super.initState();
    debugPrint(this.maxTemp.toString());
  }

  getProfileValue() {
    setState( () { newName = profileField.text.toString(); } );
  }

  deleteProfile(String name) {
    setState( () {
      deleteName = null; ///value of dropDownButton must be set to null before reassigning value
      deleteName = profileNames[0];
    } );
    profiles.removeWhere( (item) => item.name == name);
    profileNames.remove(name);
  }

  @override
  void dispose() {
    profileField.dispose();
    super.dispose();
  }

  ///Constructor
  _ProfilePage(this._font, this.shelfNumber, this.maxTemp, this.maxHumid, this.lightStart, this.lightEnd, this.duration, this.frequency, this.nutrientRatio);

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
                      children: <Widget>[
                        ListTile(
                            dense: true,
                            title: TextWidget(profiles[i].name, _font, Colors.black, FontWeight.w300, 20.0),
                            trailing: FlatButton( ///load -> changes settings to profile's settings, and returns to updated settings
                              child: TextWidget("Load", _font, Colors.green, FontWeight.w300, 15.0),
                              onPressed: () {}
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
      bottomNavigationBar: new BottomAppBar( ///Save current settings under new profile, delete existing profile in drop down menu
          child: Row(
            children: <Widget>[
              Expanded(
                 child: FlatButton(
                     color: Colors.white,
                     child: TextWidget("Create", _font, Colors.green, FontWeight.w400, 15.0),
                     onPressed: () {
                       showDialog(
                           context: context,
                           builder: (_) => new AlertDialog(
                               title: TextWidget("New profile name", _font, Colors.black, FontWeight.w400, 15.0),
                               content: new TextField(
                                   controller: profileField,
                                   obscureText: false,
                                   decoration: InputDecoration( border: OutlineInputBorder() )
                               ),
                               actions: <Widget>[
                                 RaisedButton(
                                     child: TextWidget("Create", _font, Colors.white, FontWeight.w400, 15.0),
                                     color: Colors.green,
                                     onPressed: () {
                                       getProfileValue();
                                       List<String> existingProfiles = [];
                                       for (int p = 0; p < profiles.length; p++) { existingProfiles.add(profiles[p].name); }
                                       if (newName != "" && !existingProfiles.contains(newName)) {
                                         profiles.add(Profile(newName, 0, 0, 0, 0, 0, 0, 0));
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
                          builder: (_) => new AlertDialog(
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
                                    onPressed: () {
                                      deleteProfile(deleteName);
                                      ///figure out why reopening the delete pop up after deleting a profile triggers "same value" error
                                      Navigator.of(context).pop();
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