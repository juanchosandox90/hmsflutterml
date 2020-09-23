import 'package:flutter/material.dart';

class CustomGridElement extends StatelessWidget {
  final Widget page;
  final String imagePath;
  final String name;

  CustomGridElement({this.page, this.imagePath, this.name});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) => page));
      },
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width /4,
          minHeight: MediaQuery.of(context).size.height /4+10,
        ),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(5.0),
          child: Column(
            children: [
              Image.asset("assets/$imagePath.png", height: 50),
              SizedBox(height: 5.0),
              Text(name, textAlign: TextAlign.center)
            ],
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  width: 1, color: Colors.black54, style: BorderStyle.solid)),
        ),
      ),
    );
  }
}
