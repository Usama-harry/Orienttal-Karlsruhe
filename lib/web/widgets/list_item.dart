import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//Util
import '../../util.dart';

class ListItem extends StatefulWidget {
  final Map<String, dynamic> data;
  final int index;
  const ListItem({
    Key? key,
    required this.data,
    required this.index,
  }) : super(key: key);

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    for (var i = 0; i < widget.data['items'].length; i++) {
      for (var j = i + 1; j < widget.data['items'].length; j++) {
        if (widget.data['items'][j]['position'] <
            widget.data['items'][i]['position']) {
          final item = widget.data['items'][i];
          widget.data['items'][i] = widget.data['items'][j];
          widget.data['items'][j] = item;
        }
      }
    }

    for (var i = 0; i < widget.data['items'].length; i++) {
      print(widget.data['items'][i]);
    }

    return isLoading
        ? const Center(child: CircularProgressIndicator.adaptive())
        : ListTile(
            title: Text(
              widget.data['items'][widget.index]['name'],
              style: listItemTitleTextStyle,
            ),
            subtitle: Text(
              widget.data['items'][widget.index]['description'],
              style: listItemSubTitleTextStyle,
            ),
            trailing: SizedBox(
              width: 100,
              child: Row(
                children: [
                  Expanded(
                    child: IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => Dialog(
                            child: SizedBox(
                              height: 150,
                              width: 250,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          'Are you sure to delete ${widget.data['items'][widget.index]['name']}?',
                                          style: dialogTitleTextStyle,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 40,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.green),
                                            ),
                                            child: const Text('Cancel'),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              switchIsLoading();
                                              final updatedItems =
                                                  widget.data['items']
                                                      as List<dynamic>;

                                              updatedItems.removeWhere(
                                                (element) =>
                                                    element['id'] ==
                                                    widget.data['items']
                                                        [widget.index]['id'],
                                              );

                                              FirebaseFirestore.instance
                                                  .collection('catagories')
                                                  .doc(widget.data['id'])
                                                  .set({
                                                'id': widget.data['id'],
                                                'name': widget.data['name'],
                                                'imageUrl':
                                                    widget.data['imageUrl'],
                                                'items': updatedItems,
                                              }).then((value) {
                                                switchIsLoading();
                                              }).catchError((error) {
                                                switchIsLoading();
                                              });
                                              Navigator.pop(context);
                                            },
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.red),
                                            ),
                                            child: const Text('Delete'),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 20,
                      ),
                    ),
                  ),
                  Expanded(
                    child: FittedBox(
                      child: Text(
                        "${widget.data['items'][widget.index]['price']}\u{20AC}",
                        style: listItemPriceTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ));
  }

  void switchIsLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }
}
