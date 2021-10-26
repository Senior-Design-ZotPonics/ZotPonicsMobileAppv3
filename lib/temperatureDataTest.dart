import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'services.dart';
import 'textWidget.dart';

class DataTest extends StatefulWidget {
  final int shelfNum;

  DataTest(this.shelfNum);

  @override
  State<StatefulWidget> createState() => _DataTest(shelfNum);
}

class _DataTest extends State<DataTest> {
  final int shelfNum;

  @override
  void initState() {
    super.initState();
  }

  _DataTest(this.shelfNum);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<TemperaturePostGet>(
        future: getTemperatureData(shelfNum),
        builder: (context, snapshot) {
          if (snapshot.connectionState==ConnectionState.done){
            if (!snapshot.hasData) {
              return Center(child: TextWidget(
                  'ERROR', FontAwesomeIcons.sadCry.toString(), Colors.red,
                  FontWeight.w400, 40.0));
            } else if (snapshot.hasError) {
              debugPrint(snapshot.error);
              return Center(child: TextWidget('ERROR', FontAwesomeIcons.sadCry.toString(), Colors.red, FontWeight.w400, 40.0));
            }
            print(snapshot.data);
            return Container(
              child: Card(
                child: Text('${snapshot.data}')
              )
            );
          }
          else {
            return Center(child: TextWidget('Loading...', FontAwesomeIcons.sadTear.toString(), Colors.black, FontWeight.w400, 20.0));
          }
        }
      )
    );
  }
}