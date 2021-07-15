import 'package:cake_shop/Common/TransitionApp.dart';
import 'package:cake_shop/Common/Validate.dart';
import 'package:cake_shop/HttpProtocol/Status.dart';
import 'package:cake_shop/Model/Count.dart';
import 'package:cake_shop/Model/User.dart';
import 'package:cake_shop/Widgets/BarGradient.dart';
import 'package:cake_shop/Widgets/ButtonBase.dart';
import 'package:cake_shop/Widgets/ProgressDialog.dart';
import 'package:cake_shop/Widgets/SnackBarApp.dart';
import 'package:cake_shop/Widgets/TextFieldBase.dart';
import 'package:cake_shop/Widgets/TextMessage.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget{
  TextEditingController ctrlName = TextEditingController();
  TextEditingController ctrlUser = TextEditingController();
  TextEditingController ctrlEmail = TextEditingController();
  TextEditingController ctrlPass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Scaffold(
     body: SafeArea(child:SingleChildScrollView(
       child: Column(children: [
         BarGradient("Crear Cuenta", Icons.person_add_alt_1_sharp),
         TextFieldBase("Nombre", ctrlName),
         TextFieldBase("Usuario", ctrlUser),
         TextFieldBase("Correo", ctrlEmail),
         TextFieldBase("Contraseña", ctrlPass),
         ButtonBase("Crear Cuenta", ()=>signUp(context)),
         InkWell(
           child: Row(
             mainAxisAlignment:MainAxisAlignment.center,children: [
             Text("¿Tienes una cuenta?"),
             Text(" Iniciar Sesión",style: TextStyle(color: Colors.pink[400]),)
           ],),
           onTap: ()=>TransitionApp.closePageOrDialog(context),
         )
       ],),
     ),
   ));
  }

  signUp(context)async{
    showProgress(context);
    var user = await User(userName: ctrlUser.text,password: ctrlPass.text,email: ctrlEmail.text,name: ctrlName.text).createUser();
    if(Validate.isNotStatus(user)) {
      var count = await Count().login(ctrlEmail.text, ctrlPass.text);
      if (Validate.isNotStatus(count)) {
        TransitionApp.closePageOrDialog(context);
        TransitionApp.goMain(context, count: count, user: user);
      } else
        error(count,context);
    }else
      error(user,context);
  }

  Future<void>showProgress(context)async{
    return showDialog(context: context, builder: (BuildContext contet){
      return ProgressDialog();
    });
  }

  error(Status status,context){
    TransitionApp.closePageOrDialog(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBarApp(status.statusWidget));
  }
}