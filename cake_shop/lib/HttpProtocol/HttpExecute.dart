import 'package:cake_shop/Common/Constant.dart';
import 'package:cake_shop/Model/Count.dart';
import 'package:cake_shop/Widgets/TextMessage.dart';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart';

import 'Status.dart';

typedef VoidCallBackParam(var param);

class HttpExecute {
  String endpoint;
  var parameters;
  Count? count;
  bool isRefresh;

  HttpExecute({this.endpoint = "", this.parameters,this.isRefresh=false});

  post() async{
    return await checkConnectivity(executeMethod, "post");
  }

  get() async{
    return await checkConnectivity(executeMethod, "get");
  }

  checkConnectivity(VoidCallBackParam voidCallBackParam, String type) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return (connectivityResult == ConnectivityResult.wifi ||
            connectivityResult == ConnectivityResult.mobile)
        ? await voidCallBackParam(type)
        : Status(
            type: CONNECTION_DISABLE,
            statusWidget: TextMessage("Sin conexión"));
  }

  executeMethod(var type) async {
    Response? response;
    count = await Count().getCount();

    count = (count!=null)?
    (this.isRefresh)?count:
        await count!.verifyToken():count;

    switch (type) {
      case "post":
        response =
            await Client().post(uri, headers: header, body: this.parameters);
        print("respuesta ${response.body}");
        break;
      case "get":
        response = await Client().get(uri,headers: header);
        print("respuesta ${response.body}");
    }

    return validateResponse(response);
  }

  validateResponse(Response? response) {
    return (response!.statusCode >= 200 && response.statusCode < 300)
        ? response.body
        : Status(
            type: SERVER_ERROR,
            response: response,
            statusWidget: TextMessage(
                "Error en el servido " + response.statusCode.toString()));
  }

  get uri {
    return Uri.parse(URL + this.endpoint);
  }

  Map<String, String>? get header {
    return {"content-type": "application/x-www-form-urlencoded",
    "Authorization":(count!=null)? authorization:""};
  }

  get authorization{
    return "${count!.tokenType} ${count!.accessToken}";
  }
}
