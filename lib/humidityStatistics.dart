import 'package:flutter/material.dart';
import 'humidityBarChart.dart';
import 'humiditySeries.dart';
import 'textWidget.dart';
import 'services.dart';
import 'humidityReading.dart';

/*
Calculates, and renders the average humidity percentage for the
previous month. Builds and renders the humidity bar chart which
displays the humidity data values over the last month.
 */

class HumidityStatistics extends StatefulWidget {
  final int shelfNum;

  HumidityStatistics(this.shelfNum);

  @override
  State<StatefulWidget> createState() => _HumidityStatistics(this.shelfNum);
}

class _HumidityStatistics extends State<HumidityStatistics> {
  final int shelfNum;

  _HumidityStatistics(this.shelfNum);

  @override
  void initState() {
    super.initState();
  }

  double getAverage(List<HumiditySeries> humidityData) {
    double humidityAverage;
    double totalHumidity = 0.0;
    int numReadings = humidityData.length;
    if (numReadings == 0) {
      return 0.0;
    } else {
      for (var i=0; i<numReadings; i++){
        totalHumidity += humidityData[i].humidity;
      }
      humidityAverage = totalHumidity/numReadings;
      return humidityAverage;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<HumiditySeries> humidityData = [];
    List toSort = [];
    double average;
    return Scaffold(
        backgroundColor: const Color(0xFFF8F8F8),
        appBar: PreferredSize(
          ///Modifies height of AppBar
            preferredSize: Size.fromHeight(70.0),
            child: AppBar(
              ///Back button
              backgroundColor: Colors.cyan,
              leading: IconButton(
                  padding: EdgeInsets.only(top: 12.0),
                  icon: Icon(Icons.keyboard_arrow_left, color: Colors.white),
                  iconSize: 35.0,
                  splashColor: Colors.transparent,
                  ///Go back to home page
                  onPressed: () => Navigator.of(context).pop()
              ),
              title: Text(
                  'Humidity Statistics',
                  style: TextStyle(
                      height: 2,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                      fontSize: 23.0,
                      color: Colors.white)
              ),
            )
        ),
        body: FutureBuilder<List<HumidityReading>>(
            future: getHumidityData(shelfNum),
            builder: (context, snapshot) {
              if (snapshot.connectionState==ConnectionState.done){
                if (!snapshot.hasData){
                  return Center(child: TextWidget(
                      'No humidity data to display!',
                      'Montserrat',
                      Colors.cyan,
                      FontWeight.w400,
                      40.0
                  ));
                } else if (snapshot.hasError) {
                  return Center(
                      child: TextWidget(
                          'Error retrieving data!',
                          'Montserrat',
                          Colors.red,
                          FontWeight.w400,
                          40.0)
                  );
                }
                // build humidity, timestamp list
                for (int i=0; i<snapshot.data.length; i++) {
                  toSort.add([snapshot.data[i].humidity, snapshot.data[i].timestamp]);
                }
                // sort this list by timestamp (day)
                toSort.sort((a,b) => a[1].compareTo(b[1]));

                // build temperature data list for bar chart from sorted list
                for (int i=0; i<snapshot.data.length; i++){
                  HumiditySeries seriesToAdd = HumiditySeries(toSort[i][0], toSort[i][1]);
                  humidityData.add(seriesToAdd);
                }

                // get average
                average = getAverage(humidityData);

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
                              'Monthly Humidity Data',
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
                              '${double.parse(average.toStringAsFixed(2))}' + '%',
                              'Montserrat',
                              Colors.cyan,
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
                            child: HumidityChart(humidityData: humidityData)
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