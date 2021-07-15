import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Status{
  String type;
  Widget? statusWidget;
  Response? response;
  Status({this.type="",this.statusWidget,this.response});
}