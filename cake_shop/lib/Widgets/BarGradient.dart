import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BarGradient extends StatelessWidget{
  String name;
  IconData icon;
  BarGradient(this.name,this.icon);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(bottom: 30.0),
      height: 220,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin:Alignment.centerRight ,
          end: Alignment.topLeft,
          colors: [
            Colors.pink,
            Colors.pink.withOpacity(0.45)
          ]
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(90)
        )
      ),
      child: Column(
        children: [
          Spacer(),
          Align(
            alignment: Alignment.center,
            child: Icon(this.icon,
            size: 90,
            color: Colors.white,),
          ),
          Spacer(),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: 32,
                right: 32
              ),
              child: Text(this.name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                letterSpacing: 10
              ),),
            ),
          )
        ],
      ),
    );
  }

}