import 'package:flutter/material.dart';

//models
import '../models/item.dart';
//Util
import '../util.dart';

class ListItem extends StatelessWidget {
  final Item item;

  const ListItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        item.name,
        style: listItemTitleTextStyle,
      ),
      subtitle: Text(
        item.description,
        style: listItemSubTitleTextStyle,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Text(
        '${item.price}\u{20AC}',
        style: listItemPriceTextStyle,
      ),
    );
  }
}
