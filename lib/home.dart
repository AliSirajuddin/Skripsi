import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:ggr_alpha_1_1/add_controller.dart';
import 'package:ggr_alpha_1_1/controller/load_data.dart';
import 'package:ggr_alpha_1_1/controller_page.dart';
import 'package:intl/intl.dart';
//import 'package:location/location.dart';

void main() {
  runApp(const HomePage());
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName = "t";
  String temperature = 29.1.toString();
  List<Data> _data = [];

  Future<void> load_data() async {
    final String response =
        await rootBundle.loadString('data/streamingAssets/data.json');
    final data = await json.decode(response);
    setState(() {
      userName = data['user'];
      _data = data['data'].map<Data>((model) => Data.fromJson(model)).toList();
      // print(_data[0]);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    load_data();
    //userName = _data[0];
  }

  @override
  Widget build(BuildContext context) {
    final medQueH = MediaQuery.of(context).size.height;
    final medQueW = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: SafeArea(
              child: Column(
        children: [
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
                  userName,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          //Home Info
          Container(
            width: medQueW,
            height: medQueH * 2 / 5,
            padding: const EdgeInsets.fromLTRB(12, 20, 12, 0),
            //color: Colors.amber,
            alignment: Alignment.topCenter,
            child: Stack(
              children: <Widget>[
                //InfoBackgroud
                Container(
                  width: medQueW,
                  height: medQueH / 3,
                  child: Container(
                    width: medQueW,
                    height: medQueH / 3.5,
                    child: Image.asset(
                      'data/image/Rectangle_Weather.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),

                //Location
                Positioned(
                  top: 12 / 100 * medQueW,
                  left: 5 / 100 * medQueW,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat('EEE d MMM')
                            .format(DateTime.now())
                            .toString(),
                        style: TextStyle(
                          fontSize: medQueH / 48,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF396C45),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "28",
                              style: TextStyle(
                                height: 0.9,
                                fontSize: medQueH / 8,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF396C45),
                              ),
                            ),
                            Text(
                              "O",
                              style: TextStyle(
                                height: 1,
                                fontWeight: FontWeight.w900,
                                fontSize: medQueH / 20,
                                color: Color(0xFF396C45),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "Celcius   ",
                        style: TextStyle(
                          wordSpacing: 0,
                          fontSize: medQueH / 40,
                          color: Color(0xFF396C45),
                        ),
                      ),
                    ],
                  ),
                ),
                //Connection
                Positioned(
                  top: medQueH / 32,
                  right: 0,
                  child: Container(
                      alignment: Alignment.centerRight,
                      //margin: EdgeInsets.only(top: 16, left: 10),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20))),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 16, left: 6),
                            child: Icon(
                              Icons.brightness_1,
                              color: Color(0xFF396C45),
                              size: 18,
                            ),
                          ),
                          Text(
                            "Online",
                            style: TextStyle(fontSize: 24),
                          ),
                        ],
                      )),
                ),
                //Weather Pic
                Positioned(
                  top: medQueH / 7,
                  right: 0,
                  child: Container(
                    width: medQueW / 2,
                    child: Image.asset(
                      'data/image/SunCloudRain.png',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(16, 4, 12, 4),
            padding: EdgeInsets.fromLTRB(10, 3, 10, 3),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Color(0xFFC9DFD2),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: TextField(
              //controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search...',
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search),
                hintStyle: TextStyle(
                  color: Color(0xFF396C45),
                ),
              ),
              style: TextStyle(
                color: Color(0xFF396C45),
              ),
              cursorColor: Color(0xFF396C45),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: _data.length,
                    itemBuilder: (context, index) {
                      return Container(
                          margin: EdgeInsets.fromLTRB(16, 4, 16, 4),
                          alignment: Alignment.center,
                          height: 52,
                          width: medQueW / 2,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  width: 2.0, color: const Color(0xFF146233))),
                          //margin: EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
                          child: InkWell(
                            splashColor: Color(0xFFC9DFD2),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ControllerPage(
                                    name: _data[index].name,
                                    code: _data[index].code,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              //margin: EdgeInsets.fromLTRB(16, 4, 16, 4),
                              alignment: Alignment.center,

                              height: 52,
                              width: medQueW - 32,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                _data[index].name,
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF146233)),
                              ),
                            ),
                          ));
                    }),
                Container(
                  alignment: Alignment.center,
                  height: 52,
                  width: medQueW - 32,
                  margin: EdgeInsets.only(top: 4),
                  decoration: BoxDecoration(
                      color: Color(0xFF146233),
                      borderRadius: BorderRadius.circular(20)),
                  child: InkWell(
                    onTap: () {
                              Navigator.pushNamed(context, "AddController");
                            },
                    
                    child: Text(
                      "Add Controller",
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ))),
    );
  }
}
