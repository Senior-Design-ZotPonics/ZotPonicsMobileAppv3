import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'textWidget.dart';

///Hydroponic gardening page - recommended plants and how to grow them hydroponically

class HydroponicGardening extends StatefulWidget {
  final String _font;

  ///Constructor
  HydroponicGardening(this._font);

  @override
  State<StatefulWidget> createState() => _HydroponicGardening(_font);
}

class _HydroponicGardening extends State<HydroponicGardening> {

  final String _font;

  ///Constructor
  _HydroponicGardening(this._font);

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
                    'Hydroponic Gardening',
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
                      child: TextWidget("If you don’t know what plants to grow, here are some recommendations! These "
                          "recommendations come with plant profiles that you can automatically load into the system. It "
                          "is highly recommended that new users start with smaller leafy vegetables, also known as "
                          "microgreens. If you want some more variety, there are a few non-leafy vegetables that you "
                          "can try to grow but we still recommend starting with young plants and not seeds.",
                          this._font, Colors.black, FontWeight.w400, 16.0)
                  ),
                  Container(
                    margin: const EdgeInsets.all(10.0),
                    child: TextWidget("Spinach - Easy", this._font, Colors.black, FontWeight.w500, 20.0),
                  ),
                  Container(
                      margin: const EdgeInsets.all(10.0),
                      child: TextWidget("Spinach is a common choice for hydroponics, since it is a plant that does well "
                          "in a moist environment. Baby spinach in particular takes about 3 weeks to grow before it can "
                          "be harvested, so it can be regrown often.", this._font, Colors.black, FontWeight.w400, 16.0)
                  ),
                  Container(
                    margin: const EdgeInsets.all(10.0),
                    child: TextWidget("Lettuce - Easy", this._font, Colors.black, FontWeight.w500, 20.0),
                  ),
                  Container(
                      margin: const EdgeInsets.all(10.0),
                      child: TextWidget("Lettuces like Romaine or Bibb are easy to grow since they aren’t needy plants. "
                          "They grow well even with less light and lower temperatures, and can be grown year-round in these "
                          "kinds of controlled environments. They also take about 3 weeks to grow before harvest, but you "
                          "can start harvesting one leaf at a time and make it last longer.", this._font, Colors.black,
                          FontWeight.w400, 16.0)
                  ),
                  Container(
                    margin: const EdgeInsets.all(10.0),
                    child: TextWidget("Kale - Easy", this._font, Colors.black, FontWeight.w500, 20.0),
                  ),
                  Container(
                      margin: const EdgeInsets.all(10.0),
                      child: TextWidget("Kale is another type of leafy lettuce that isn’t too needy either, and also has "
                          "faster baby varieties. Their leaves can be picked within a month, but they taste best when they "
                          "reach a deeper green color with a firm texture after 3-4 months. ", this._font, Colors.black,
                          FontWeight.w400, 16.0)
                  ),
                  Container(
                    margin: const EdgeInsets.all(10.0),
                    child: TextWidget("Pepper - Medium", this._font, Colors.black, FontWeight.w500, 20.0),
                  ),
                  Container(
                      margin: const EdgeInsets.all(10.0),
                      child: TextWidget("Small peppers are not as easy and require a little more effort to cultivate. Pepper "
                          "plants need a lot of sunlight, so they will require 14-18 hours of light daily. The plants can get "
                          "fairly tall too, so you may need to prune them to make sure the peppers grow well. After about 2-3 "
                          "months, the peppers should be ready for harvest.", this._font, Colors.black, FontWeight.w400, 16.0)
                  ),
                  Container(
                    margin: const EdgeInsets.all(10.0),
                    child: TextWidget("Onion - Medium", this._font, Colors.black, FontWeight.w500, 20.0),
                  ),
                  Container(
                      margin: const EdgeInsets.all(10.0),
                      child: TextWidget("Onions are also a bit more difficult to grow. When growing onions, keep an eye out "
                          "for flowers. Flowers are a sign that the onion has stopped growing, so then you’ll have to harvest "
                          "it. If no flowers sprout, the onions should take about 2-3 months to harvest. They also require at "
                          "least 12 hours of light daily, if not more.", this._font, Colors.black, FontWeight.w400, 16.0)
                  ),
                  Container(
                    margin: const EdgeInsets.all(10.0),
                    child: TextWidget("Tomato - Hard", this._font, Colors.black, FontWeight.w500, 20.0),
                  ),
                  Container(
                      margin: const EdgeInsets.all(10.0),
                      child: TextWidget("If you want more of a challenge, try cherry or Roma tomatoes. Tomatoes are tougher "
                          "plants to maintain, but they should be fine if you keep the temperatures and lighting in the proper "
                          "ranges. Tomato plants are picky about temperature, in which they need warmer temperatures of about "
                          "82-85 F during the day and cooler temperatures of about 64 F at night. And for light, they want at "
                          "least 8 hours of uninterrupted darkness - this includes blocking out light pollution. If all goes "
                          "well, the tomatoes should be ready in 1-2 months.", this._font, Colors.black, FontWeight.w400, 16.0)
                  )
                ]
            )
        )
    );
  }
}
