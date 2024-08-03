import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:ggr_alpha_1_1/controller_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

/// main application widget
class MyApp extends StatelessWidget {
  static const String _title = 'Flutter Application';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        body: MyStatefulWidget(),
        backgroundColor: Color(0xFFE8F5F8),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final dbref = FirebaseDatabase.instance.ref("monitor");

  @override
  void initState() {
    super.initState();
    temperatureData();
  }

  String suhu = "here";
  bool isSwitch = true;
  int batteryval = 0;
  bool isCharge = true;

  void temperatureData() {
    dbref.child("suhu").onValue.listen((event) {
      final String temp = event.snapshot.value.toString();
      setState(() {
        suhu = temp;
      });
    });
  }

  void valueData() {
    dbref.child("lampu1").onValue.listen((event) {
      final String val = event.snapshot.value.toString();
      setState(() {
        if (val == "true") {
          isSwitch = true;
        } else {
          isSwitch = false;
        }
      });
    });
  }

  void chargeData() {
    dbref.child("chargeStat").onValue.listen((event) {
      final String val = event.snapshot.value.toString();
      setState(() {
        if (val == "true") {
          isCharge = true;
        }
        if (batteryval == 100) {
          isCharge = false;
        } else {
          isCharge = false;
        }
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Center(
      child: Column(
        children: <Widget>[
          _widgetHeader(mediaQuery),
          _widgetCardRelay(mediaQuery)
        ],
      ),
    );
  }

  Widget _widgetHeader(MediaQueryData mediaQuery) {
    return Container(
        width: double.infinity,
        height: mediaQuery.size.height / 3,
        margin: EdgeInsets.only(top: 24.0),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Color(0xFF74CAC5),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40.0),
                bottomRight: Radius.circular(40.0)),
            image: DecorationImage(
                image: AssetImage('assets/images/rumah_header_crop.png'),
                alignment: Alignment.bottomRight)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 16.0),
              child: Text(
                suhu,
                style: TextStyle(
                    fontFamily: "poppinsMedium", fontSize: 40, height: 1.2),
              ),
            ),
          ],
        ));
  }

  
  Widget _widgetCardRelay(MediaQueryData mediaQuery) {
    return Container(
      width: mediaQuery.size.width * 7 / 8,
      height: 52,
      margin: EdgeInsets.only(top: 24),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Color(0xFFF9FBED),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomLeft: Radius.circular(15)),
                      image: DecorationImage(
                          image: AssetImage('assets/images/lamp_crop.png'),
                          fit: BoxFit.cover)),
                  height: 48,
                  width: 32,
                  alignment: Alignment.bottomLeft,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 36),
                  child: Text(
                    "Lampu 1",
                    style: TextStyle(fontFamily: "poppinsMedium", fontSize: 32),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 24),
                  child: Switch(
                    value: isSwitch,
                    onChanged: (value) {
                      setState(() {
                        isSwitch = value;
                        dbref.update({"lampu1": isSwitch.toString()});
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  battContainer(double _height, IconData icon, bool hasglow) {
    return Container(
      width: _height / 7,
      height: _height / 7,
      child: Icon(
        icon,
      ),
    );
  }
}