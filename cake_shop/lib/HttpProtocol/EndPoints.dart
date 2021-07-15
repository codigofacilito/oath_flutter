import 'package:cake_shop/Common/Constant.dart';
import 'package:cake_shop/HttpProtocol/HttpExecute.dart';
import 'package:cake_shop/Model/Count.dart';
import 'package:cake_shop/Model/User.dart';

class EndPoints{

  static login(String email, String password){
    Map parameters = {
      GRANT_TYPE : "password",
      USERNAME : email,
      PASSWORD : password,
      AUDIENCE : URL+API,
      SCOPE : "offline_access openid",
      CLIENT_ID : APP_ID,
      CLIENT_SECRET : APP_SECRET
    };

    return HttpExecute(endpoint: "/oauth/token",parameters: parameters).post();
  }

  static getUser(){
    return HttpExecute(endpoint:"/userinfo").get();
  }

  static refreshAccessToke(String refreshToken){
    Map parameters = {
      GRANT_TYPE : "refresh_token",
      REFRESH_TOKEN : refreshToken,
      CLIENT_ID : APP_ID,
      CLIENT_SECRET : APP_SECRET
    };
    return HttpExecute(endpoint:"/oauth/token",parameters: parameters,isRefresh: true).post();
  }

  static resetPassword(String email) {
    Map parameters = {
      EMAIL: email,
      "connection": "Username-Password-Authentication",
      CLIENT_ID: APP_ID,
      CLIENT_SECRET: APP_SECRET,
    };

    return HttpExecute(endpoint: "dbconnections/change_password",parameters:parameters ).post();
  }

  static createUser (User user) {
    Map parameters = {
      USERNAME: user.userName,
      PASSWORD: user.password,
      NAME: user.name,
      EMAIL: user.email,
      "connection": "Username-Password-Authentication",
      CLIENT_ID: APP_ID,
      CLIENT_SECRET: APP_SECRET,
    };

    return HttpExecute(endpoint: "dbconnections/signup",parameters:parameters ).post();
  }

}