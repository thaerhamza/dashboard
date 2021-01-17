import 'package:cached_network_image/cached_network_image.dart';
import 'package:dashboard/pages/food/edit.dart';
import 'package:dashboard/pages/config.dart';
import 'package:dashboard/pages/provider/loading.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../function.dart';

List<FoodData> foodList = null;
String imageFood = path_images + "food/";

class FoodData {
  String foo_id;
  String cat_id;
  String foo_name;
  String foo_name_en;
  String foo_price;
  String foo_offer;
  String foo_info;
  String foo_info_en;
  String foo_regdate;
  String foo_thumbnail;

  FoodData(
      {this.foo_id,
      this.cat_id,
      this.foo_name,
      this.foo_name_en,
      this.foo_price,
      this.foo_offer,
      this.foo_info,
      this.foo_info_en,
      this.foo_regdate,
      this.foo_thumbnail});
}

class SingleFood extends StatelessWidget {
  int foo_index;
  FoodData food;
  SingleFood({this.foo_index, this.food});
  @override
  Widget build(BuildContext context) {
    var providerFood = Provider.of<LoadingControl>(context);
    return Card(
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              foodList.removeAt(foo_index);
              deleteData("foo_id", food.foo_id, "food/delete_food.php");
              providerFood.add_loading();
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
              leading: food.foo_thumbnail == null || food.foo_thumbnail == ""
                  ? CachedNetworkImage(
                      imageUrl: imageFood + "def.png",
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    )
                  : CachedNetworkImage(
                      imageUrl: imageFood + food.foo_thumbnail,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
              title: Text(
                food.foo_name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text(food.foo_regdate)]),
              trailing: Container(
                width: 30.0,
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => new EditFood(
                                    foo_index: foo_index, myfood: food)));
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
