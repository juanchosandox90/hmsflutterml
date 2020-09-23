import 'package:flutter/material.dart';
import 'package:hmsflutterml/custom_grid_element.dart';
import 'package:hmsflutterml/text.dart';

class Home extends StatefulWidget {
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[900],
          title: Text(
            "Flutter Reconocimiento de Texto",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 230.0),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomGridElement(
                      name: "Text",
                      imagePath: "text2",
                      page: TextRecognition(),
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
