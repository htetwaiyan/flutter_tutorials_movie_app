import 'dart:io';
import 'package:flutter_shell/ob/response_ob.dart';
import 'package:flutter_shell/utils/app_constants.dart';
import 'package:http/http.dart' as http;

class BaseNetwork {

  Future<ResponseOb> getRequest({String endUrl,bool isWallet=false}) async {

    ResponseOb rv = ResponseOb();
      return http.get(BASE_URL + endUrl).then((res) {
        if (res.statusCode == 200) {
          rv.message = MsgState.data;
          rv.data = res.body.toString();
        }  else {
          rv.message = MsgState.error;
          rv.data = "Data Fetching Error";
        }
        return rv;
      }).catchError((e) {
        if (e is SocketException) {
          rv.message = MsgState.error;
          rv.data = "No Internet";
        } else {
          rv.message = MsgState.error;
          rv.data = "Data ${e.toString()} Error";
        }
        return rv;
      });
  }


  Future<ResponseOb> postRequest({String endUrl, Map body,bool isWallet=false}) async {

    ResponseOb rv = ResponseOb();
    return http.post(BASE_URL+endUrl, body: body).then((res) {
      if (res.statusCode == 200) {
        rv.message = MsgState.data;
        rv.data = res.body;
      }  else {
        rv.message = MsgState.error;
        rv.data = "Data Fetching Error";
      }
      return rv;
    }).catchError((e) {
      print(e.toString() + ">>");
      if (e is SocketException) {
        rv.message = MsgState.error;
        rv.data = "No Internet";
      } else {
        rv.message = MsgState.error;
        rv.data = "Data ${e.toString()} Error ";
      }
      return rv;
    });

  }


}
