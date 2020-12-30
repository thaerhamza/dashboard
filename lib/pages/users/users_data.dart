import 'dart:convert';
import 'package:dashboard/pages/users/users.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dashboard/pages/config.dart';
import 'dart:async';

Future<bool> createUser(String use_name, String use_mobile, String use_pwd,
    bool use_active, String use_note, BuildContext context) async {
  String url = path_api + "users/insert_user.php?token=" + token;
  Map data = {
    "use_name": use_name,
    "use_mobile": use_mobile,
    "use_pwd": use_pwd,
    "use_active": use_active ? "1" : "0",
    "use_note": use_note
  };
  http.Response respone = await http.post(url, body: data);
  if (json.decode(respone.body)["code"] == "200") {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Users()));

    print("success");
    return true;
  } else {
    print("Failer");
    return false;
  }
}

Future<List> getdData(int count, String strSearch) async {
  String url = path_api +
      "users/readuser.php?txtsearch=${strSearch}&start=${count}&end=10&token=" +
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
