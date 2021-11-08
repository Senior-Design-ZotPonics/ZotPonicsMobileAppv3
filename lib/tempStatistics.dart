import 'package:flutter/material.dart';
import 'package:flutter_app/tempBarChart.dart';
import 'package:flutter_app/tempSeries.dart';
import 'textWidget.dart';
import 'services.dart';
import 'temperatureReading.dart';

/*
Calculates and renders the average temperature for the previous month.
Builds and renders the temperature bar chart which displays the temperatures
over the last month.
 */

class TempStatistics extends StatefulWidget {
  final int shelfNum;

  TempStatistics(this.shelfNum);

  @override
  State<StatefulWidget> createState() => _TempStatistics(this.shelfNum);
}

class _TempStatistics extends State<TempStatistics> {
  final int shelfNum;

  _TempStatistics(this.shelfNum);

  @override
  void initState() {
    super.initState();
  }

  double getAverage(List<TempSeries> temperatureData) {
    double temperatureAverage;
    double totalTemperature = 0.0;
    int numReadings = temperatureData.length;
    for (var i=0; i<numReadings; i++){
      totalTemperature += temperatureData[i].temp;
    }
    temperatureAverage = totalTemperature/numReadings;
    return temperatureAverage;
  }
  
  @override
  Widget build(BuildContext context) {
    List<TempSeries> temperatureData = [];
    List toSort = [];
    double average;
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: PreferredSize(
        ///Modifies height of AppBar
          preferredSize: Size.fromHeight(70.0),
          child: AppBar(
            ///Back button
              backgroundColor: Colors.red,
              leading: IconButton(
                  padding: EdgeInsets.only(top: 12.0),
                  icon: Icon(Icons.keyboard_arrow_left, color: Colors.white),
                  iconSize: 35.0,
                  splashColor: Colors.transparent,
                  ///Go back to home page
                  onPressed: () => Navigator.of(context).pop()
              ),
              title: Text(
                  'Temperature Statistics',
                  style: TextStyle(
                      height: 2,
                      // fontFamily: _font,
                      fontWeight: FontWeight.w500,
                      fontSize: 23.0,
                      color: Colors.white)
              ),
          )
      ),
      body: FutureBuilder<List<TemperatureReading>>(
        future: getTemperatureData(shelfNum),
        builder: (context, snapshot) {
          if (snapshot.connectionState==ConnectionState.done){
            if (!snapshot.hasData){
              return Center(child: TextWidget(
                'No temperature data to display',
                  'Montserrat',
                  Colors.red,
                  FontWeight.w400,
                  40.0
              ));
            } else if (snapshot.hasError) {
              return Center(
                  child: TextWidget(
                      'ERROR',
                      'Montserrat',
                      Colors.red,
                      FontWeight.w400,
                      40.0)
              );
            }
            // build temp, timestamp list
            for (int i=0; i<snapshot.data.length; i++) {
              toSort.add([snapshot.data[i].temperature, snapshot.data[i].timestamp]);
            }
            // sort this list by timestamp (day)
            toSort.sort((a,b) => a[1].compareTo(b[1]));

            // build temperature data list for bar chart from sorted list
            for (int i=0; i<snapshot.data.length; i++){
              TempSeries seriesToAdd = TempSeries(temp: toSort[i][0],
                timestamp: toSort[i][1]);
              temperatureData.add(seriesToAdd);
            }

            // get average
            average = getAverage(temperatureData);

            return Container(
              height: 800,
              width: double.infinity,
              // padding: EdgeInsets.only(top: 25.0, bottom: 25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 25.0, right: 25.0, bottom: 45.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: TextWidget(
                        'Monthly Temperature Data',
                        'Montserrat',
                        Colors.blueGrey,
                        FontWeight.w500,
                        20.0
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 50.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: TextWidget(
                            '${double.parse(average.toStringAsFixed(2))}' + '°C',
                            'Montserrat',
                            Colors.red,
                            FontWeight.w700,
                            30.0
                        ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 50.0, bottom:15.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: TextWidget(
                        'Monthly Avg.',
                        'Montserrat',
                        Colors.blueGrey,
                        FontWeight.bold,
                        12.0
                      ),
                    ),
                  ),
                  Container(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TemperatureChart(temperatureData: temperatureData)
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 15.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: TextWidget(
                        'Note: Chart is left-right scrollable, '
                            '\ngiven sufficient data. Give it a try!',
                        'Montserrat',
                        Colors.blueGrey,
                        FontWeight.bold,
                        10.0
                      )
                    )
                  )
                ],
              ),
            );
          } else {
            return Center(
                child: TextWidget(
                    'Loading...',
                    'Montserrat',
                    Colors.black,
                    FontWeight.w400,
                    20.0)
            );
          }
        }
      )
    );
  }
}