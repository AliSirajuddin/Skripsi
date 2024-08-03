import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

class ControllerPage extends StatefulWidget {
  const ControllerPage({super.key, required this.name, required this.code});
  final String name, code;
  @override
  State<ControllerPage> createState() => _ControllerPageState();
}

class _ControllerPageState extends State<ControllerPage> {
  @override
  void initState() {
    super.initState();
    init();
  }
  //bool power = false;
  var temperature = "0";
  var soilMoisture = "0";
  var airHumidity = "0";
  var fertilizer = false;
  var power = false;
  var waterPump = false;
  bool fertilizerCheck = false;
  bool powerCheck = false;
  bool waterPumpCheck = false;

  Future<void> init() async{
    
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    final dbref = FirebaseDatabase.instance.ref(widget.code);
    dbref.child("suhu").onValue.listen((event) {
      final String temp = event.snapshot.value.toString();
      setState(() {
        temperature = temp;
        
      });
    });
    dbref.child("soilMoisture").onValue.listen((event) {
      final String soilMoistureRate = event.snapshot.value.toString();
      setState(() {
        soilMoisture = soilMoistureRate;
      });
    });
    dbref.child("kelembapan").onValue.listen((event) {
      final String airHumidityRate = event.snapshot.value.toString();
      setState(() {
        airHumidity = airHumidityRate;
      });
    });
    dbref.child("fetilizer").onValue.listen((event) {
      var fertilizerStat = event.snapshot.value.toString();
      setState(() {
        if(fertilizerStat=="true"){
          fertilizer = true;
          fertilizerCheck = true;
        }else{
          fertilizer = false;
        }
        print(fertilizerStat +"fertilizer");
        print(fertilizer.toString() +"fertilizer2");
      });
      
    });
    dbref.child("connect").onValue.listen((event) {
      var powerStat = event.snapshot.value.toString();
      setState(() {
        if(powerStat==true){
          power = true;
          powerCheck = true;
        }else{
          power = false;
        }
      });
    });
    dbref.child("waterswitch").onValue.listen((event) {
      var waterPumpStat = event.snapshot.value.toString();
      setState(() {
        if(waterPumpStat==true){
          waterPump = true;
          waterPumpCheck = true;
        }else{
          waterPump = false;
        }
      });
      if(fertilizerCheck!=fertilizer){
        dbref.child("fetilizer").set(fertilizer);
        fertilizerCheck = fertilizer;
      }
      if(powerCheck!=power){
        dbref.child("connect").set(power);
        powerCheck = power;
      }
      if(waterPumpCheck!=waterPump){
        dbref.child("waterswitch").set(waterPump);
        waterPumpCheck = waterPump;
      }
    });
    
    
}
  @override
  Widget build(BuildContext context) {
    final medQueH = MediaQuery.of(context).size.height;
    final medQueW = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(
          children: [
            //header
            Stack(
              children: <Widget>[
                //Header Home
                Image.asset(
                  'data/image/Header_Home.png',
                  height: medQueH / 6,
                  width: medQueW,
                  fit: BoxFit.cover,
                ),
                //UserName
                Positioned(
                  top: 5 / 100 * medQueW,
                  left: 10 / 100 * medQueW,
                  child: Text(
                    widget.name,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontFamily: 'Lexand',fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ],
            ),
            //Content Body
            Container(
              margin: EdgeInsets.only(right: 16, left: 16, top: 12),
              height: medQueH * 2 / 5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Color(0xFFC9E4CF),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // weather
                  Container(
                    margin: EdgeInsets.only(left: 16),
                    child: Image.asset(
                      'data/image/SunCloudRain.png',
                    ),
                  ),
                  //data
                  Container(
                    margin: EdgeInsets.only(top: 12, bottom: 12, right: 12),
                    width: medQueW * 3 / 7,
                    decoration: BoxDecoration(
                        color: Color(0xFFEAF0EC),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Column(
                      children: [
                        //Humidity
                        Container(
                          child: Column(
                            children: [
                              Text(
                                "Air Humidity",
                                style: TextStyle(
                                    fontSize: 24, color: Color(0xFF146233),fontFamily: 'Lexand',fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "$airHumidity %",
                                style: TextStyle(
                                    fontSize: 52, color: Color(0xFF146233),fontFamily: 'Lexand'),
                              )
                            ],
                          ),
                        ),
                        //Temperature
                        Container(
                          child: Column(
                            children: [
                              Text(
                                "Temperature",
                                style: TextStyle(
                                    fontSize: 24, color: Color(0xFF146233),fontFamily: 'Lexand',fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "$temperature \u2103",
                                style: TextStyle(
                                    fontSize: 52, color: Color(0xFF146233),fontFamily: 'Lexand',),
                              ),
                            ],
                          ),
                        ),
                        //Soil Moisture
                        Container(
                          child: Column(
                            children: [
                              Text(
                                " Soil Moisture",
                                style: TextStyle(
                                    fontSize: 24, color: Color(0xFF146233),fontFamily: 'Lexand',fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "$soilMoisture %",
                                style: TextStyle(
                                    fontSize: 52, color: Color(0xFF146233),fontFamily: 'Lexand'),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            //controller
            Text(
              "Controller",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
              textAlign: TextAlign.left,
            ),
            //power
            Container(
              height: medQueH / 15,
              margin: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
              decoration: BoxDecoration(
                  color: Color(0xFFC9E4CF),
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 12, right: 12),
                        child: Icon(
                          Icons.power_settings_new_rounded,
                          size: 48,
                        ),
                      ),
                      Text(
                        "Power",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 16),
                    child: Switch(
                      value: power,
                      onChanged: (value) {
                        setState(() {
                          power = value;
                        });
                      },
                      activeColor: Color(0xFF146233),
                    ),
                  )
                ],
              ),
            ),
            //Water
            Container(
              height: medQueH / 15,
              margin: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
              decoration: BoxDecoration(
                  color: Color(0xFFC9E4CF),
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 12, right: 12),
                        child: Icon(
                          Icons.water_drop_outlined,
                          size: 48,
                        ),
                      ),
                      Text(
                        "Water Pump",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 16),
                    child: Switch(
                      value: waterPump,
                      onChanged: (value) {
                        setState(() {
                          waterPump = value;
                        });
                      },
                      activeColor: Color(0xFF146233),
                    ),
                  )
                ],
              ),
            ),

            //Fertilizer
            Container(
              height: medQueH / 15,
              margin: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
              decoration: BoxDecoration(
                  color: Color(0xFFC9E4CF),
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 12, right: 12),
                        child: Icon(
                          Icons.water_drop_rounded,
                          size: 48,
                        ),
                      ),
                      Text(
                        "Fertilizer",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 16),
                    child: Switch(
                      value: fertilizer,
                      onChanged: (value) {
                        setState(() {
                          fertilizer = value;
                        });
                      },
                      activeColor: Color(0xFF146233),
                    ),
                  )
                ],
              ),
            ),

            
          ],
        ))),
      ),
    );
  }
}
