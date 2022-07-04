import 'package:flutter/material.dart';

//models
import '../models/catagory.dart';
//Util
import '../util.dart';
//Screens
import '../views/catagory_items_screen.dart';

class GridItem extends StatelessWidget {
  final Catagory catagory;
  const GridItem({
    Key? key,
    required this.catagory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(
        CatagoryItemsScreen.routeName,
        arguments: catagory.id,
      ),
      child: CircleAvatar(
        backgroundImage: NetworkImage(
          catagory.imageUrl,
        ),
        child: Align(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: GridTileBar(
              backgroundColor: Colors.black45,
              title: Text(
                catagory.name,
                style: gridItemTitleTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
