import 'package:cake_shop/Common/TransitionApp.dart';
import 'package:cake_shop/Common/Validate.dart';
import 'package:cake_shop/HttpProtocol/Status.dart';
import 'package:cake_shop/Model/Count.dart';
import 'package:cake_shop/Model/User.dart';
import 'package:cake_shop/Widgets/BarGradient.dart';
import 'package:cake_shop/Widgets/ButtonBase.dart';
import 'package:cake_shop/Widgets/ProgressDialog.dart';
import 'package:cake_shop/Widgets/ResetPasswordDialog.dart';
import 'package:cake_shop/Widgets/SnackBarApp.dart';
import 'package:cake_shop/Widgets/TextFieldBase.dart';
import 'package:cake_shop/Widgets/TextMessage.dart';
import 'package:flutter/material.dart';

import 'HomePage.dart';
import 'LoadingPage.dart';
import 'SignUpPage.dart';

class LoginPage extends StatelessWidget{
  TextEditingController ctrlEmail = TextEditingController();
  TextEditingController ctrlPass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        child:Column(children: [
          BarGradient("Cake Shop",Icons.store),
          TextFieldBase("Usuario",ctrlEmail,icon: Icons.person,),
          TextFieldBase("Contraseña",ctrlPass,icon: Icons.remove_red_eye,obscureText: true,),
          InkWell(
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(padding:EdgeInsets.only(right: 32,top: 16),child:Text("¿Se te olvido la contraseña?",style: TextStyle(color: Colors.grey),)),
            ),
            onTap: ()=>resetPassword(context),
          ),
          ButtonBase("Iniciar Sesión",()=>login(context)),
        InkWell(
          child: Row(
            mainAxisAlignment:MainAxisAlignment.center,children: [
            Text("¿No tienes una cuenta?"),
            Text(" Crear Cuenta",style: TextStyle(color: Colors.pink[400]),)
          ],),
          onTap: ()=>signUp(context),
        )]) ,
        
      ),

    );
  }

  login(BuildContext context)async{
    showProgress(context);
    var count = await Count().login("mega-0210@hotmail.com","@Hola0210");
    if(Validate.isNotStatus(count)){
      var user = await User().getUserServer();
      if(Validate.isNotStatus(user)){
        TransitionApp.closePageOrDialog(context);
        TransitionApp.goMain(context,count: count,user: user);
      }else
        error(user,context);
    }else
      error(count,context);


    //TransitionApp.openPage(LoadingPage(), context);
  }

  error(Status status,context){
    TransitionApp.closePageOrDialog(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBarApp(
       Validate.isWrongEmailPassword(status.response)? TextMessage("Usuario o contraseña incorrecta. Intente de  nuevo")
           :status.statusWidget
    ));
  }

  Future<void>showProgress(context)async{
    return showDialog(context: context, builder: (BuildContext contet){
      return ProgressDialog();
    });
  }

  signUp(context){
    TransitionApp.openPage(SignUpPage(),context);
  }

  Future<void>resetPassword(BuildContext context){
    return showDialog<void>(context: context,builder:  (BuildContext context){
      return ResetPasswordDialog();
    });
  }

}