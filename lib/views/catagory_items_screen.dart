import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Provider
import '../providers/data.dart';
//Util
import '../util.dart';
//Widget
import '../widgets/list_item.dart';

class CatagoryItemsScreen extends StatelessWidget {
  static const routeName = '/catagoryItemScreen';
  const CatagoryItemsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final catId = ModalRoute.of(context)!.settings.arguments as String;
    final catagory = Provider.of<Data>(context).findCatagoryById(catId);

    for (var i = 0; i < catagory.items.length; i++) {
      for (var j = i + 1; j < catagory.items.length; j++) {
        if (catagory.items[j].position < catagory.items[i].position) {
          final item = catagory.items[i];
          catagory.items[i] = catagory.items[j];
          catagory.items[j] = item;
        }
      }
    }

    for (var i = 0; i < catagory.items.length; i++) {
      print('${catagory.items[i].name}   ${catagory.items[i].position}');
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          catagory.name,
          style: appBarTextStyle,
        ),
      ),
      body: ListView.builder(
        itemCount: catagory.items.length,
        itemBuilder: (_, index) => ListItem(
          item: catagory.items[index],
        ),
      ),
    );
  }
}
