import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'infoCard.dart';
//import 'textWidget.dart';

//https://stackoverflow.com/questions/51061412/how-to-set-the-text-value-dynamically-from-the-json-in-flutter

void main() => runApp(ZotPonics());

class ZotPonics extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZotPonics',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        fontFamily: 'Montserrat',
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'ZotPonics'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.
  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Controllers used for keeping input variables
  final tempMax = TextEditingController();

  // Text widget
  Widget TextWidget(String _text, String _font, Color _color, FontWeight _weight, double _size) {
    return Text(_text, style: TextStyle(fontFamily: _font,
        fontWeight: _weight,
        fontSize: _size,
        color: _color));
  }

  // Setting card for number variables
  Widget _numberSettingItem(String _title, String _subtitle, IconData _icon, TextEditingController _controller) {
    bool _numberValid = false;
    String _num = '100';
    return Card(
      child: ListTile(
        leading: Icon(_icon, color: Colors.green, size: 40.0),
        title: TextWidget(_title, 'Montserrat', Colors.black87, FontWeight.w600, 20.0),
        subtitle: TextWidget(_num, 'Montserrat', Colors.black, FontWeight.w300, 15.0),
        onTap: () {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => SimpleDialog(
              title: TextWidget(_title, 'Montserrat', Colors.black87, FontWeight.w600, 20.0),
              children: <Widget>[
                TextField(
                  keyboardType: TextInputType.number,
                  //controller: _controller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter an integer',
                      errorText: _numberValid ? null : 'Please enter an integer'
                  ),
                  onChanged: (String num) {
                    final n = int.tryParse(num);
                    if (n == null) {
                      setState(() => _numberValid = false);
                    }
                    else {
                      setState(() => _numberValid = true);
                    }
                  },
                  onSubmitted: (num) => Navigator.pop(context, num)
                )
              ]
            )
          ).then( (returnNum) {
              if (returnNum != null) {
                _num = returnNum;
              }
            }
          );
        },
      )
    );
  }


  //Go to settings page
  void _pushSettings() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return Scaffold(         // Add 6 lines from here...
            appBar: AppBar(
              leading: IconButton(
                  icon: Icon(Icons.keyboard_arrow_left, color: Colors.white),
                  iconSize: 35.0,
                  splashColor: Colors.transparent,
                  onPressed: () => Navigator.of(context).pop(),
                ),
              title: TextWidget('Settings', 'Montserrat', Colors.white, FontWeight.w600, 35.0),
            ),
            body: ListView(
              children: <Widget> [
                _numberSettingItem('Max Temperature','100°F',FontAwesomeIcons.thermometerHalf,tempMax)
              ]
            )
          );
        },
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          title: Text(widget.title, style: TextStyle(height: 2, fontFamily: 'Montserrat', fontWeight: FontWeight.w700, fontSize: 40.0, color: Colors.white)),
          actions: [
            Padding(
              padding: EdgeInsets.only(top: 12.0),
              child: IconButton(
                icon: Icon(Icons.settings, color: Colors.white),
                iconSize: 35.0,
                splashColor: Colors.transparent,
                onPressed: _pushSettings,
              )
            )
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InfoCard('75°F', 'Temperature', Colors.red, FontAwesomeIcons.thermometerHalf),
          InfoCard('60%', 'Humidity', Colors.orange, FontAwesomeIcons.water),
          InfoCard('ON', 'Lights', Colors.yellow, FontAwesomeIcons.lightbulb),
          InfoCard('6.2 cm', 'Plant Height', Colors.lightGreen, FontAwesomeIcons.leaf),
          InfoCard('17:00', 'Last Watered', Colors.lightBlue, FontAwesomeIcons.clock)
        ]
      )
    );
  }
}
