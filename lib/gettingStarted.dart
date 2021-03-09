import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'textWidget.dart';

///Getting started page - system overview, user role in running the system (preparing nutrient water, power supply, how to use app, etc.)

class GettingStarted extends StatefulWidget {
  final String _font;

  ///Constructor
  GettingStarted(this._font);

  @override
  State<StatefulWidget> createState() => _GettingStarted(_font);
}

class _GettingStarted extends State<GettingStarted> {

  final String _font;

  ///Constructor
  _GettingStarted(this._font);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///Off-white background
        backgroundColor: const Color(0xFFF8F8F8),
        appBar: PreferredSize(
          ///Modifies height of AppBar
            preferredSize: Size.fromHeight(70.0),
            child: AppBar(
              ///Back button
                leading: IconButton(
                    padding: EdgeInsets.only(top: 12.0),
                    icon: Icon(Icons.keyboard_arrow_left, color: Colors.white),
                    iconSize: 35.0,
                    splashColor: Colors.transparent,
                    ///Go back to home page
                    onPressed: () => Navigator.of(context).pop()
                ),
                title: Text(
                    'Getting Started',
                    style: TextStyle(
                        height: 1.8,
                        fontFamily: _font,
                        fontWeight: FontWeight.w600,
                        fontSize: 25.0,
                        color: Colors.white
                    )
                )
            )
        ),
        ///Setting items
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 10),
                  Container(
                      margin: const EdgeInsets.all(10.0),
                      child: TextWidget("What's in the ZotPonics system", this._font, Colors.black, FontWeight.w500, 20.0),
                  ),
                  Container(
                      margin: const EdgeInsets.all(10.0),
                      child: TextWidget("The ZotPonics system is structured as a shelf unit of four shelves. The top "
                          "three shelves contain troughs for the plants, and the bottom shelf contains a reservoir for the "
                          "nutrient water, the water pump, and the circuit board that connects all the electrical parts. "
                          "Each of the top three shelves can maintain a different environment, so you can grow at most "
                          "three different varieties of plants at a time.",
                      this._font, Colors.black, FontWeight.w400, 16.0)
                  ),
                  Container(
                      margin: const EdgeInsets.all(10.0),
                      child: TextWidget("To start using ZotPonics for the first time, you need to have plants, a 12 V power "
                          "source, nutrient solution, a monitor, an HDMI cable, a keyboard, and a mouse. Here's how to get started.",
                          this._font, Colors.black, FontWeight.w400, 16.0)
                  ),
                  Container(
                    margin: const EdgeInsets.all(10.0),
                    child: TextWidget("Step 1: Pick out your plants and purchase nutrient solution", this._font, Colors.black, FontWeight.w500, 20.0),
                  ),
                  Container(
                      margin: const EdgeInsets.all(10.0),
                      child: TextWidget("Don't know what plants to grow? Go back to the guide menu and check out the Hydroponic gardening "
                          "page for some recommendations.",
                          this._font, Colors.black, FontWeight.w400, 16.0)
                  ),
                  Container(
                      margin: const EdgeInsets.all(10.0),
                      child: TextWidget("When purchasing your plants, we highly recommend starting with young plants. The plants will "
                          "then be large enough to be held in place within the troughs. Seedlings are also acceptable, but make sure "
                          "to secure them well.",
                          this._font, Colors.black, FontWeight.w400, 16.0)
                  ),
                  Container(
                      margin: const EdgeInsets.all(10.0),
                      child: TextWidget("When purchasing a nutrient solution, keep in mind that it is not meant to be given directly "
                          "to the plants. You will have to mix the nutrient solution with a lot of water, and the resulting nutrient "
                          "water will be poured into the reservoir.",
                          this._font, Colors.black, FontWeight.w400, 16.0)
                  ),
                  Container(
                    margin: const EdgeInsets.all(10.0),
                    child: TextWidget("Step 2: Arrange the plants in the troughs", this._font, Colors.black, FontWeight.w500, 20.0),
                  ),
                  Container(
                      margin: const EdgeInsets.all(10.0),
                      child: TextWidget("Included with the system are small plastic pots and clay pebbles. For each of the troughs, "
                          "you will see circular openings on the lids. Place the small pots in each opening. Fill each pot halfway "
                          "with clay pebbles, place your plants on top, and secure them with more pebbles. Make sure each shelf has "
                          "only one type of plant, since they must grow under the same conditions.",
                          this._font, Colors.black, FontWeight.w400, 16.0)
                  ),
                  Container(
                    margin: const EdgeInsets.all(10.0),
                    child: TextWidget("Step 3: Supply the system with power and set up the Raspberry Pi", this._font, Colors.black, FontWeight.w500, 20.0),
                  ),
                  Container(
                      margin: const EdgeInsets.all(10.0),
                      child: TextWidget("Check out the ZotPonics GitHub at https://github.com/Senior-Design-ZotPonics/Documentation "
                          "for the detailed diagrams on how to connect the Raspberry Pi, the water pump, the sensors, and the actuators "
                          "to the circuit board. Once you have your plants placed in the troughs and all of the electrical parts connected "
                          "to the circuit board, turn on the ZotPonics system by plugging it in to a 12 V power source.",
                          this._font, Colors.black, FontWeight.w400, 16.0)
                  ),
                  Container(
                      margin: const EdgeInsets.all(10.0),
                      child: TextWidget("The GitHub is also where you can find the instructions for setting up the Raspberry Pi server. "
                          "Now that the ZotPonics system is powered on, the Raspberry Pi will be powered on automatically. You will need "
                          "these additional materials to interact with the Raspberry Pi: a monitor, an HDMI cable, a keyboard, and a "
                          "mouse. Follow the instructions from GitHub, and then you can disconnect those additional materials. Make sure "
                          "the Raspberry Pi is still lit up to indicate that it’s on, and you can proceed to the next step!",
                          this._font, Colors.black, FontWeight.w400, 16.0)
                  ),
                  Container(
                    margin: const EdgeInsets.all(10.0),
                    child: TextWidget("Step 4: Fill the reservoir with the nutrient water", this._font, Colors.black, FontWeight.w500, 20.0),
                  ),
                  Container(
                      margin: const EdgeInsets.all(10.0),
                      child: TextWidget("As we mentioned in Step 1, the nutrient solution must be mixed with water. Check the instructions "
                          "on the solution you bought to prepare the nutrient water. And please note, young plants should be fed with a "
                          "diluted solution - this means about double the water. As the plants continue to grow, the additional water can "
                          "be reduced to match the recommendations in the solution’s instructions. Prepare the nutrient water and completely "
                          "fill the reservoir on the bottom shelf of the system. The plants will grow and absorb the nutrients, so the "
                          "nutrient water must be replaced approximately every other week. The mobile app will send you notifications once "
                          "you start!",
                          this._font, Colors.black, FontWeight.w400, 16.0)
                  ),
                  Container(
                    margin: const EdgeInsets.all(10.0),
                    child: TextWidget("Step 5: Set your growth factors", this._font, Colors.black, FontWeight.w500, 20.0),
                  ),
                  Container(
                      margin: const EdgeInsets.all(10.0),
                      child: TextWidget("Finally, you must configure the growth environments in the ZotPonics app. The app that you are "
                          "using now has a main menu that allows you to control each shelf’s growth environment. By tapping on a shelf "
                          "icon in the main menu, you will be able to view the current sensor readings for the individual shelf. From "
                          "the sensor readings menu, you can adjust the shelf environment settings through the control growth factors.",
                          this._font, Colors.black, FontWeight.w400, 16.0)
                  ),
                  Container(
                      margin: const EdgeInsets.all(10.0),
                      child: TextWidget("And if you have decided to grow plants that we have recommended, you can use the given settings "
                          "under the plant profiles option on the settings page. You also have the option to save your own settings to use "
                          "again too - you can save them in the settings page, and then create a new plant profile that contains those "
                          "settings in the profile menu.",
                          this._font, Colors.black, FontWeight.w400, 16.0)
                  ),
                  Container(
                    margin: const EdgeInsets.all(10.0),
                    child: TextWidget("Ready to go!", this._font, Colors.black, FontWeight.w500, 20.0),
                  ),
                  Container(
                      margin: const EdgeInsets.all(10.0),
                      child: TextWidget("Congratulations on setting up your ZotPonics system! Now your system is on and your plants are "
                          "ready to grow. All that’s left to do is to monitor the system and replace the nutrient water on a regular "
                          "basis. Good luck!",
                          this._font, Colors.black, FontWeight.w400, 16.0)
                  )
            ]
        )
        )
    );
  }
}
