import 'dart:convert';
import 'package:dashboard/pages/provider/loading.dart';
import 'package:dashboard/pages/users/users.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:dashboard/pages/config.dart';
import 'dart:async';

import 'package:provider/provider.dart';

import 'edit.dart';

List<UsersData> userList = null;

Future<bool> createUser(Map arrInsert, BuildContext context) async {
  String url = path_api + "users/insert_user.php?token=" + token;

  http.Response respone = await http.post(url, body: arrInsert);
  if (json.decode(respone.body)["code"] == "200") {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Users()));

    print("success");
    return true;
  } else {
    print("Failer");
    return false;
  }
}

Future<bool> updateUser(Map arrUpdate, BuildContext context) async {
  String url = path_api + "users/update_user.php?token=" + token;

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

Future<bool> deleteData(String use_id) async {
  String url =
      path_api + "users/delete_user.php?use_id=${use_id}&token=" + token;
  print(url);
  http.Response respone = await http.post(url);

  if (json.decode(respone.body)["code"] == "200") {
    return true;
  } else {
    return false;
  }
}

class UsersData {
  String use_id;
  String use_name;
  String use_pwd;
  String use_mobile;
  bool use_active;
  String use_lastdate;
  String use_note;
  UsersData(
      {this.use_id,
      this.use_name,
      this.use_pwd,
      this.use_lastdate,
      this.use_mobile,
      this.use_active,
      this.use_note});
}

class SingleUser extends StatelessWidget {
  int use_index;
  UsersData users;
  SingleUser({this.use_index, this.users});
  @override
  Widget build(BuildContext context) {
    var providerUser = Provider.of<LoadingControl>(context);
    return Card(
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              userList.removeAt(use_index);
              deleteData(users.use_id);
              providerUser.add_loading();
            },
            child: Container(
              alignment: Alignment.topRight,
              child: Icon(
                Icons.cancel,
                color: Colors.red,
              ),
            ),
          ),
          Container(
            child: ListTile(
              title: Text(
                users.use_name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text(users.use_mobile), Text(users.use_lastdate)]),
              trailing: Container(
                width: 30.0,
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => new EditUsers(
                                      use_index: use_index,
                                      users: users,
                                    )));
                      },
                      child: Container(
                        padding: EdgeInsets.all(5),
                        child: FaIcon(
                          FontAwesomeIcons.edit,
                          color: Colors.white,
                          size: 16,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
