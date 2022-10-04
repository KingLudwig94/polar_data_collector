import 'dart:async';

import 'dart:math';
import 'package:intl/intl.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:polar/polar.dart';
import 'package:polar_data_collector/model.dart';

late MyDatabase database;

void main() {
  database = MyDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  Polar polar = Polar();
  bool connected = false;
  StreamSubscription? ppiStreamSubscription;
  StreamSubscription? ecgStreamSubscription;
  final int limit = 1000;

  List<FlSpot> one = [];
  List<FlSpot> second = [];
  List<FlSpot> third = [];
  List<FlSpot> ambient = [];
  int? battery;
  int? lasthr;
  List<FlSpot> hr = [];
  List<FlSpot> ecg = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    polar.deviceConnectingStream.listen((event) {
      debugPrint('Connecting: ${event.name}');
    });
    polar.deviceConnectedStream.listen((event) {
      debugPrint('Connected: ${event.name}');
      setState(() {
        connected = true;
      });
    });
    polar.deviceDisconnectedStream.listen((event) {
      debugPrint('Disconnected: ${event.name}');
      setState(() {
        connected = false;
      });
    });
    polar.heartRateStream.listen((e) => debugPrint('Heart rate: ${e.data.hr}'));
    polar.streamingFeaturesReadyStream.listen(
      (event) => debugPrint('Feature ready: ${event.features}'),
    );
    polar.batteryLevelStream.listen((event) {
      setState(() {
        battery = event.level;
      });
    });
    polar.heartRateStream.listen((event) {
      debugPrint(
          'hr: ${event.data.hr} - rss: ${event.data.rrsMs} - contact: ${event.data.contactStatus}');
      if (event.data.hr != 0) {
        database.hRDao
            .insert(HRData(time: DateTime.now(), value: event.data.hr));
      }
      setState(() {
        while (hr.length > limit) {
          hr.removeAt(0);
        }
        hr.add(FlSpot(DateTime.now().millisecondsSinceEpoch.toDouble(),
            event.data.hr.toDouble()));
        lasthr = event.data.hr;
      });
    });
  }

  String verityidentifier = 'B2178924';
  String h10identifier = 'B31B0B23';
  String identifier = '';

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    polar.disconnectFromDevice(identifier);
    print('dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              one.isNotEmpty
                  ? SizedBox(
                      width: 350,
                      height: 250,
                      child: LineChart(
                        LineChartData(
                          lineTouchData: LineTouchData(enabled: false),
                          clipData: FlClipData.all(),
                          gridData: FlGridData(
                            show: true,
                            drawVerticalLine: false,
                          ),
                          lineBarsData: [
                            firstLine(one),
                            //firstLine(second),
                            //firstLine(third),
                            //firstLine(ambient),
                          ],
                          titlesData: FlTitlesData(
                              bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                      showTitles: true,
                                      getTitlesWidget: (value, meta) {
                                        return Text(DateFormat('ss').format(
                                            DateTime.fromMicrosecondsSinceEpoch(
                                                value.toInt())));
                                      })),
                              topTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false)),
                              rightTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false)),
                              leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                      showTitles: true,
                                      reservedSize: 50,
                                      getTitlesWidget: (value, _) {
                                        return Text(
                                          value.toStringAsExponential(1),
                                          textAlign: TextAlign.left,
                                        );
                                      }))),
                        ),
                      ),
                    )
                  : Container(),
              SizedBox(
                height: 10,
              ),
              hr.isNotEmpty
                  ? SizedBox(
                      height: 200,
                      child: LineChart(
                        LineChartData(
                            lineTouchData: LineTouchData(enabled: false),
                            clipData: FlClipData.all(),
                            gridData: FlGridData(
                              show: true,
                              drawVerticalLine: false,
                            ),
                            lineBarsData: [
                              firstLine(hr),
                            ],
                            titlesData: FlTitlesData(
                                bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                        showTitles: true,
                                        getTitlesWidget: (value, meta) {
                                          return Text(DateFormat('ss').format(
                                              DateTime
                                                  .fromMillisecondsSinceEpoch(
                                                      value.toInt())));
                                        })),
                                topTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false)),
                                rightTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false)),
                                leftTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                        showTitles: true,
                                        reservedSize: 40,
                                        getTitlesWidget: (value, _) {
                                          return Text(
                                            value.toString(),
                                            textAlign: TextAlign.left,
                                          );
                                        }))),
                            minY: hr.map((e) => e.y).toList().reduce(
                                (value, element) => min(value, element)),
                            maxY: hr.map((e) => e.y).toList().reduce(
                                (value, element) => max(value, element))),
                      ),
                    )
                  : Container(),
              ecg.isNotEmpty
                  ? SizedBox(
                      width: 350,
                      height: 250,
                      child: LineChart(
                        LineChartData(
                          lineTouchData: LineTouchData(enabled: false),
                          clipData: FlClipData.all(),
                          gridData: FlGridData(
                            show: true,
                            drawVerticalLine: false,
                          ),
                          lineBarsData: [
                            firstLine(ecg),
                          ],
                          titlesData: FlTitlesData(
                              bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                      showTitles: true,
                                      getTitlesWidget: (value, meta) {
                                        return Text(DateFormat('ss').format(
                                            DateTime.fromMicrosecondsSinceEpoch(
                                                value.toInt())));
                                      })),
                              topTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false)),
                              rightTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false)),
                              leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                      showTitles: true,
                                      reservedSize: 60,
                                      getTitlesWidget: (value, _) {
                                        return Text(
                                          value.toStringAsPrecision(3),
                                          textAlign: TextAlign.left,
                                        );
                                      }))),
                        ),
                      ),
                    )
                  : Container(),
              SizedBox(
                height: 10,
              ),
              if (battery != null) Text('Battery: $battery'),
              if (lasthr != null) Text('Last HR: $lasthr'),
              !connected
                  ? Row(
                      children: [
                        TextButton(
                            onPressed: () {
                              identifier = h10identifier;
                              polar.connectToDevice(identifier);
                            },
                            child: Text('connect H10')),
                        TextButton(
                            onPressed: () {
                              identifier = verityidentifier;
                              polar.connectToDevice(identifier);
                            },
                            child: Text('connect Verity')),
                      ],
                    )
                  : TextButton(
                      onPressed: () {
                        polar.disconnectFromDevice(identifier);
                        setState(() {
                          identifier = '';
                        });
                      },
                      child: Text('disconnect')),
              if (identifier == verityidentifier)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ppiStreamSubscription == null
                        ? TextButton(
                            onPressed: () async {
                              Stream<PolarOhrData> ppgStream =
                                  polar.startOhrStreaming(identifier);
                              ppiStreamSubscription =
                                  ppgStream.listen((event) async {
                                debugPrint(
                                    'PPG1: ${event.timeStamp} => ${event.samples.map((v) => v[0]).toList()}');
                                for (var e in event.samples) {
                                  await database.pPGDao.insert(PPGData(
                                      time: event.timeStamp,
                                      first: e[0],
                                      second: e[1],
                                      third: e[2],
                                      ambient: e[3]));
                                }
                                while (one.length > limit) {
                                  one.removeAt(0);
                                  second.removeAt(0);
                                  third.removeAt(0);
                                  ambient.removeAt(0);
                                }
                                while (hr.length > limit) {
                                  hr.removeAt(0);
                                }

                                var data = await database.pPGDao.getLast100();
                                int i = 0;
                                one = [];
                                for (var element in data) {
                                  one.add(FlSpot(
                                      element.time / 1000.toDouble() -
                                          i * 1000000,
                                      element.first.toDouble()));
                                  second.add(FlSpot(element.time.toDouble(),
                                      element.second.toDouble()));
                                  third.add(FlSpot(element.time.toDouble(),
                                      element.third.toDouble()));
                                  ambient.add(FlSpot(element.time.toDouble(),
                                      element.ambient.toDouble()));
                                  i++;
                                }
                                setState(() {});
                              });
                            },
                            child: Text('startPPG'))
                        : TextButton(
                            onPressed: () async {
                              await ppiStreamSubscription!.cancel();
                              setState(() {
                                ppiStreamSubscription = null;
                              });
                            },
                            child: Text('stopPPG')),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            one = [];
                            second = [];
                            third = [];
                            ambient = [];
                          });
                        },
                        child: Text('deletePPG'))
                  ],
                ),
              if (identifier == h10identifier)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ecgStreamSubscription == null
                        ? TextButton(
                            onPressed: () async {
                              Stream<PolarEcgData> ecgStream =
                                  polar.startEcgStreaming(identifier);

                              ecgStreamSubscription =
                                  ecgStream.listen((event) async {
                                /* debugPrint(
                                    'ECG: ${event.timeStamp} => ${event.samples.toList()}'); */
                                //debugPrint('${event.samples.length}');
                                for (var e in event.samples) {
                                  await database.eCGDao.insert(
                                      ECGData(time: event.timeStamp, value: e));
                                }
                                while (ecg.length > limit) {
                                  ecg.removeAt(0);
                                }

                                var data = await database.eCGDao.getLast300();
                                int i = 0;
                                ecg = [];
                                for (var element in data) {
                                  ecg.add(FlSpot(
                                      event.timeStamp / 1000.toDouble() -
                                          i * 1000000,
                                      element.value.toDouble()));
                                  i++;
                                }
                                setState(() {});
                              });
                            },
                            child: Text('startECG'))
                        : TextButton(
                            onPressed: () async {
                              await ecgStreamSubscription!.cancel();
                              setState(() {
                                ecgStreamSubscription = null;
                              });
                            },
                            child: Text('stopECG')),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            ecg = [];
                          });
                        },
                        child: Text('deleteECG'))
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }

  LineChartBarData firstLine(List<FlSpot> points) {
    return LineChartBarData(
      spots: points,
      dotData: FlDotData(
        show: true,
      ),
      barWidth: 1,
      isCurved: false,
    );
  }
}
