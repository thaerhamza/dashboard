import 'package:dashboard/pages/users/add.dart';
import 'package:dashboard/pages/users/edit.dart';
import 'package:dashboard/pages/users/users_data.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dashboard/pages/config.dart';

List<SingleUser> userList = new List<SingleUser>();

class Users extends StatefulWidget {
  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
  void getDataUser() async {
    List arr = await getdData(0);
    for (int i = 0; i < arr.length; i++) {
      userList.add(new SingleUser(
        use_id: arr[i]["use_id"],
        use_name: arr[i]["use_name"],
        use_mobile: arr[i]["use_mobile"],
        use_active: arr[i]["use_active"],
        use_lastdate: arr[i]["use_lastdate"],
      ));
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("ادارة التصنيفات"),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[50],
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          margin: EdgeInsets.only(top: 0),
          child: ListView.builder(
            itemCount: userList.length,
            itemBuilder: (context, index) {
              return SingleUser(
                use_id: userList[index].use_id,
                use_name: userList[index].use_name,
                use_lastdate: userList[index].use_lastdate,
                use_active: userList[index].use_active,
                use_mobile: userList[index].use_mobile,
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 50.0,
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddUsers()));
                },
                child: Text(
                  "اضافة مستخدم جديد",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              height: 40.0,
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(40)),
            ),
          ],
        ),
      ),
    );
  }
}

class SingleUser extends StatelessWidget {
  final String use_id;
  final String use_name;
  final String use_mobile;
  final String use_active;
  final String use_lastdate;

  SingleUser(
      {this.use_id,
      this.use_name,
      this.use_lastdate,
      this.use_mobile,
      this.use_active});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topRight,
            child: Icon(
              Icons.cancel,
              color: Colors.red,
            ),
          ),
          Container(
            child: ListTile(
              title: Text(
                use_name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Text(use_mobile),
              leading: Container(width: 50.0, child: Text(use_lastdate)),
              trailing: Container(
                width: 30.0,
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => new EditUsers()));
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
