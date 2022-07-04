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
