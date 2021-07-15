import 'package:cake_shop/Common/Validate.dart';
import 'package:cake_shop/DataBase/CRUD.dart';
import 'package:cake_shop/DataBase/Tables.dart';
import 'package:cake_shop/HttpProtocol/EndPoints.dart';
import 'package:cake_shop/Model/Count.dart';
import 'package:flutter/cupertino.dart';

class User extends CRUD{
  int id;
  String userName;
  String name;
  String email;
  String password;
  User({this.id=0,
    this.userName="",
    this.name="",
    this.email="",this.password=""}):super(Tables.USER);

  factory User.toObject(Map<String, Object?>data){
    Validate validate =Validate(data);
    return User(
        id: validate.checkKeyExists(key: "id",initialize: 0),
        userName: validate.checkKeyExists(key: "username",initialize: ""),
        name: validate.checkKeyExists(key: "name",initialize: ""),
        email :validate.checkKeyExists(key: "email",initialize: ""),
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'username': this.userName,
      "name" :this.name,
      "email" : this.email,
    };
  }

  getUserServer()async{
    var data = await EndPoints.getUser();
    return Validate(data).checkIsStatusOrResponse(saveOrUpdate);
  }

  saveOrUpdate(data)async{
    User user = User.toObject(data);
    user.id = (user.id>0)?await update(user.toMap()):await insert(user.toMap());
    return user;
  }

  Future<User?> getUser()async{
    List<Map<String, Object?>> result =await query("SELECT * FROM ${Tables.USER}");
    return (result.isNotEmpty)?User.toObject(result[0]):null;
  }

  createUser() async {
    var response = await EndPoints.createUser(this);
    return await Validate(response).checkIsStatusOrResponse(saveOrUpdate);
  }
}