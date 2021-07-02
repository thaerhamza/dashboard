import 'dart:ui';
import 'package:dashboard/pages/component/progress.dart';
import 'package:dashboard/pages/provider/loading.dart';
import 'package:dashboard/pages/food/add.dart';
import 'package:flutter/material.dart';
import 'package:dashboard/pages/config.dart';
import 'package:dashboard/pages/function.dart';
import 'package:provider/provider.dart';
import '../function.dart';
import 'food_data.dart';

class Food extends StatefulWidget {
  final String cat_id;
  final String cat_name;
  Food({@required this.cat_id, @required this.cat_name});
  @override
  _FoodState createState() => _FoodState();
}

class _FoodState extends State<Food> {
  ScrollController myScroll;
  GlobalKey<RefreshIndicatorState> refreshKey;
  int i = 0;
  bool loadingList = false;
  void getDataFood(int count, String strSearch) async {
    loadingList = true;
    setState(() {});
    List arr = await getData(
        count, "food/readfood.php", strSearch, "cat_id=${widget.cat_id}&");
    for (int i = 0; i < arr.length; i++) {
      foodList.add(new FoodData(
        foo_id: arr[i]["foo_id"],
        cat_id: arr[i]["cat_id"],
        foo_name: arr[i]["foo_name"],
        foo_name_en: arr[i]["foo_name_en"],
        foo_price: arr[i]["foo_price"],
        foo_offer: arr[i]["foo_offer"],
        foo_info: arr[i]["foo_info"],
        foo_info_en: arr[i]["foo_info_en"],
        foo_regdate: arr[i]["foo_regdate"],
        foo_thumbnail: arr[i]["foo_thumbnail"],
      ));
    }
    loadingList = false;
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    myScroll.dispose();
    foodList.clear();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _appBarTitle = new Text(widget.cat_name);
    foodList = new List<FoodData>();
    myScroll = new ScrollController();
    refreshKey = GlobalKey<RefreshIndicatorState>();
    getDataFood(0, "");

    myScroll.addListener(() {
      if (myScroll.position.pixels == myScroll.position.maxScrollExtent) {
        i += 10;
        getDataFood(i, "");
        print("scroll");
      }
    });
  }

  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle;

  void _searchPressed(LoadingControl myProv) {
    if (this._searchIcon.icon == Icons.search) {
      this._searchIcon = new Icon(Icons.close);
      this._appBarTitle = new TextField(
        style: TextStyle(color: Colors.white),
        decoration: new InputDecoration(
            prefixIcon: Icon(Icons.search), hintText: "ابحث ..."),
        onChanged: (text) {
          print(text);

          foodList.clear();
          i = 0;
          getDataFood(0, text);
          myProv.add_loading();
        },
      );
    } else {
      this._searchIcon = new Icon(Icons.search);
      this._appBarTitle = new Text("بحث باسم المأكولات");
    }
    myProv.add_loading();
  }

  @override
  Widget build(BuildContext context) {
    var myProvider = Provider.of<LoadingControl>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: _appBarTitle,
        centerTitle: true,
        actions: [
          Container(
            padding: EdgeInsets.all(10),
            child: GestureDetector(
              onTap: () {
                _searchPressed(myProvider);
              },
              child: _searchIcon,
            ),
          )
        ],
      ),
      backgroundColor: Colors.grey[50],
      body: RefreshIndicator(
        onRefresh: () async {
          i = 0;
          foodList.clear();
          await getDataFood(0, "");
        },
        key: refreshKey,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: 0),
                child: ListView.builder(
                  controller: myScroll,
                  itemCount: foodList.length,
                  itemBuilder: (context, index) {
                    final item = foodList[index];
                    return Dismissible(
                      key: Key(item.foo_id),
                      direction: DismissDirection.startToEnd,
                      child: SingleFood(
                        foo_index: index,
                        food: foodList[index],
                      ),
                      onDismissed: (direction) {
                        foodList.remove(item);
                        deleteData(
                            "foo_id", item.foo_id, "food/delete_food.php");
                        myProvider.add_loading();
                      },
                    );
                  },
                ),
              ),
              Positioned(
                  child: loadingList ? circularProgress() : Text(""),
                  bottom: 0,
                  left: MediaQuery.of(context).size.width / 2)
            ],
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddFood(
                              cat_id: widget.cat_id,
                              cat_name: widget.cat_name)));
                },
                child: Text(
                  "اضافة مأكولات جديدة",
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
