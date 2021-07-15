import 'package:flutter/material.dart';

class ButtonBase extends StatelessWidget{
  String name;
  var onTap;
  double width;
  ButtonBase(this.name,this.onTap,{this.width=0});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(padding: EdgeInsets.all(30.0),
    child: InkWell(
      onTap: this.onTap,
      child: Container(
        height: 45,
        padding: EdgeInsets.all(10),
        width: this.width>0?this.width:null,
        decoration: BoxDecoration(
          color: Colors.pink[400],
          borderRadius: BorderRadius.all(Radius.circular(50))
        ),
        child: Center(
          child: Text(
            this.name.toUpperCase(),
            style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ),);
  }

}