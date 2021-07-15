import 'package:cake_shop/Model/Count.dart';
import 'package:cake_shop/Model/User.dart';
import 'package:cake_shop/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TransitionApp {

  static closePageOrDialog(BuildContext context){
    Navigator.of(context,rootNavigator: true).pop();
  }
  static openPage(var page,BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>page));
  }

  static goMain(BuildContext context,{Count? count, User? user}){
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>MyApp(count: count,user: user,)),
    ModalRoute.withName("/MyApp"));
  }
}