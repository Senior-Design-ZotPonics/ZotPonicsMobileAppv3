import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../services.dart';
import '../textWidget.dart';
import '../TemperatureReading.dart';
import 'package:flutter_app/tempSeries.dart';
import 'package:flutter_app/tempBarChart.dart';

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
    List<TempSeries> d = [];
    return Scaffold(
      body: FutureBuilder<List<TemperatureReading>>(
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
            for (int i=0; i<snapshot.data.length; i++){
              TempSeries seriesToAdd = TempSeries(temp: snapshot.data[i].temperature,
                  timestamp: snapshot.data[i].timestamp);
                print(seriesToAdd);
              d.add(seriesToAdd);
            }

            return Center(
              child: Card(
                child: TemperatureChart(temperatureData: d)
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