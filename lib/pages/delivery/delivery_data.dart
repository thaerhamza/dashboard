import 'package:cached_network_image/cached_network_image.dart';
import 'package:dashboard/pages/delivery/edit.dart';
import 'package:dashboard/pages/config.dart';
import 'package:dashboard/pages/provider/loading.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../function.dart';

List<DeliveryData> deliveryList = null;
String imageDelivery = path_images + "delivery/";

class DeliveryData {
  String del_id;

  String del_name;
  String del_pwd;
  String del_mobile;

  String del_note;
  String del_regdate;
  String del_thumbnail;

  DeliveryData(
      {this.del_id,
      this.del_name,
      this.del_pwd,
      this.del_mobile,
      this.del_note,
      this.del_regdate,
      this.del_thumbnail});
}

class SingleDelivery extends StatelessWidget {
  int del_index;
  DeliveryData delivery;
  SingleDelivery({this.del_index, this.delivery});
  @override
  Widget build(BuildContext context) {
    var providerDelivery = Provider.of<LoadingControl>(context);
    return Card(
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              deliveryList.removeAt(del_index);
              deleteData(
                  "del_id", delivery.del_id, "delivery/delete_delivery.php");
              providerDelivery.add_loading();
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
              leading: delivery.del_thumbnail == null ||
                      delivery.del_thumbnail == ""
                  ? CachedNetworkImage(
                      imageUrl: imageDelivery + "def.png",
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    )
                  : CachedNetworkImage(
                      imageUrl: imageDelivery + delivery.del_thumbnail,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
              title: Text(
                delivery.del_name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text(delivery.del_regdate)]),
              trailing: Container(
                width: 30.0,
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => new EditDelivery(
                                    del_index: del_index,
                                    mydelivery: delivery)));
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
