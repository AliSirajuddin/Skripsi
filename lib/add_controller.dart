import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AddController extends StatefulWidget {
  const AddController({super.key});

  @override
  State<AddController> createState() => _AddControllerState();
}

class _AddControllerState extends State<AddController> {
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
                      "Add Controller",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(16, 4, 12, 4),
                child: TextField(
                  //controller: _searchController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.add_link),
                    labelText: "Device Code",
                    helperText: "look at on your device",
                    enabledBorder: UnderlineInputBorder(),
                    hintStyle: TextStyle(
                      color: Color(0xFF396C45),
                      fontSize: 24,
                    ),
                  ),
                  style: TextStyle(
                    color: Color(0xFF396C45),
                  ),
                  cursorColor: Color(0xFF396C45),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(16, 4, 12, 4),
                child: TextField(
                  //controller: _searchController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.eco_rounded),
                    labelText: "Plant's Name",
                    helperText: "input your plant name",
                    enabledBorder: UnderlineInputBorder(),
                    hintStyle: TextStyle(
                      color: Color(0xFF396C45),
                      fontSize: 24,
                    ),
                  ),
                  style: TextStyle(
                    color: Color(0xFF396C45),
                  ),
                  cursorColor: Color(0xFF396C45),
                ),
              ),
              Container(
                height: medQueH / 12,
                width: medQueW / 3,
                margin: EdgeInsets.only(top: 24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Color(0xFF396C45),
                ),
                child: Row(
                  children: [
                    Container(
                        margin: EdgeInsets.only(
                            left: 10, right: 5, top: 5, bottom: 10),
                        child: Icon(
                          Icons.eco_rounded,
                          size: 48,
                          color: Color(0xFFEEEEEE),
                        )),
                    Column(
                      children: [
                        Text(
                          "Let's",
                          style: TextStyle(
                            fontSize: 24,
                            color: Color(0xFFEEEEEE),
                          ),
                        ),
                        Text(
                          "Plant",
                          style: TextStyle(
                            fontSize: 24,
                            color: Color(0xFFEEEEEE),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
