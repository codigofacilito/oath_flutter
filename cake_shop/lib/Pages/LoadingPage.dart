import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(child: Scaffold(
      body: Container(
        height: double.infinity,
        width:double.infinity ,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.pink,
              Colors.pink.withOpacity(0.45)
            ]
          )
        ),
        child: Icon(Icons.cake,color: Colors.white,size: 150,),
      ),
    ));
  }

}