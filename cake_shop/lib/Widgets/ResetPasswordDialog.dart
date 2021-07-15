import 'package:cake_shop/Common/TransitionApp.dart';
import 'package:cake_shop/Model/Count.dart';
import 'package:cake_shop/Widgets/ButtonBase.dart';
import 'package:cake_shop/Widgets/SnackBarApp.dart';
import 'package:cake_shop/Widgets/TextFieldBase.dart';
import 'package:flutter/material.dart';

import 'TextMessage.dart';

class ResetPasswordDialog extends StatelessWidget{
  TextEditingController ctrlEmail = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Dialog(
      backgroundColor: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          mainAxisSize:MainAxisSize.min,children: [
          TextFieldBase("Correo", ctrlEmail),
          Row(
            children: [
              ButtonBase("Cancelar", ()=>close(context)),
              ButtonBase("Restablecer", ()=>reset(context)),
            ],
          )
        ],),
      ),
    );
  }

  close(BuildContext context){
    TransitionApp.closePageOrDialog(context);
  }

  reset(context)async{
    var resetPassword = await Count()
        .resetPassword(ctrlEmail.text);
    ScaffoldMessenger.of(context).showSnackBar(SnackBarApp(
        TextMessage(resetPassword)));
    TransitionApp.closePageOrDialog(context);
  }
}