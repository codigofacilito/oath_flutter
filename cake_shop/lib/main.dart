import 'package:cake_shop/Pages/HomePage.dart';
import 'package:cake_shop/Pages/LoadingPage.dart';
import 'package:flutter/material.dart';

import 'Model/Count.dart';
import 'Model/User.dart';
import 'Pages/LoginPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  User? user;
  Count? count;
  MyApp({this.count,this.user});
  @override
  State<StatefulWidget> createState()=>MyAppState(this.count,this.user);

}
class MyAppState extends State<MyApp> {
  User? user;
  Count? count;
  bool isLoading=false;
  MyAppState(this.count,this.user);

  @override
  void initState() {
    if(this.count==null && this.user ==null)
      getUserAndCount();
    super.initState();
  }

  getUserAndCount()async{
    setState(() => this.isLoading=true);

    Count? count = await Count().getCount();
    User? user = await User().getUser();

    if(mounted)
    if(count!=null && user!=null)
      setState(() {
        this.user=user;
        this.count = count;
        this.isLoading = false;
      });
    else
      setState(() => this.isLoading=false);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: getPage()
    );
  }

  Widget getPage(){
    return (isLoading)
        ?LoadingPage()
        :(count!=null && user!=null)
        ?HomePage(this.count,this.user)
        :LoginPage();
  }
}
