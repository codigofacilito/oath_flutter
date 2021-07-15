import 'package:flutter/material.dart';

class TextFieldBase extends StatelessWidget{
  String name;
  IconData? icon;
  bool obscureText;
  TextEditingController controller = TextEditingController();

  TextFieldBase(this.name,this.controller,{this.obscureText=false,this.icon});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30.0,vertical: 10.0),
      height: 45,
      padding: EdgeInsets.symmetric(vertical: 4,horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(50)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5
          )
        ]
      ),
      child: TextField(
        controller: this.controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          icon: this.icon!=null?Icon(this.icon,color: Colors.pink,):null,
          hintText: this.name,
          border: InputBorder.none
        ),
      ),
    );
  }

}