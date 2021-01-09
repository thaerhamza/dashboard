import "package:dashboard/pages/config.dart";
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<bool> createData(Map arrInsert, String urlPage, BuildContext context,
    Widget Function() movePage) async {
  String url = path_api + "${urlPage}?token=" + token;

  http.Response respone = await http.post(url, body: arrInsert);
  if (json.decode(respone.body)["code"] == "200") {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => movePage()));

    print("success");
    return true;
  } else {
    print("Failer");
    return false;
  }
}

Future<bool> updateData(
    Map arrUpdate, String urlPage, BuildContext context) async {
  String url = path_api + "${urlPage}?token=" + token;

  http.Response respone = await http.post(url, body: arrUpdate);
  if (json.decode(respone.body)["code"] == "200") {
    Navigator.pop(context);

    print("success");
    return true;
  } else {
    print("Failer");
    return false;
  }
}

Future<List> getData(int count, String urlPage, String strSearch) async {
  String url = path_api +
      "${urlPage}?txtsearch=${strSearch}&start=${count}&end=10&token=" +
      token;
  print(url);
  http.Response respone = await http.post(url);

  if (json.decode(respone.body)["code"] == "200") {
    {
      List arr = (json.decode(respone.body)["message"]);
      print(arr);
      return arr;
    }
  }
}

Future<bool> deleteData(String col_id, String val_id, String urlPage) async {
  String url = path_api + "${urlPage}?${col_id}=${val_id}&token=" + token;
  print(url);
  http.Response respone = await http.post(url);

  if (json.decode(respone.body)["code"] == "200") {
    return true;
  } else {
    return false;
  }
}
