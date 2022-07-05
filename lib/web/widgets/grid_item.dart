import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../util.dart';

//Screens
import '../views/catagories_items_screen.dart';

//Widgets
import '../widgets/text_field.dart';

class GridITem extends StatefulWidget {
  final Map<String, dynamic> data;
  const GridITem({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<GridITem> createState() => _GridITemState();
}

class _GridITemState extends State<GridITem> {
  final nameController = TextEditingController();
  final imageUrlController = TextEditingController();
  final _key = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    return StatefulBuilder(
      builder: (context, setState) => isLoading
          ? const Center(child: CircularProgressIndicator.adaptive())
          : GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(
                CatagoriesItemsScreen.routeName,
                arguments: widget.data,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 150,
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          widget.data['name'],
                          style: gridItemTitleTextStyle,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            nameController.text = widget.data['name'];
                            imageUrlController.text = widget.data['imageUrl'];
                            showDialog(
                              context: context,
                              builder: (_) => Form(
                                key: _key,
                                child: Dialog(
                                  child: SizedBox(
                                    height: 300,
                                    width: 300,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: ListView(
                                              children: [
                                                MyTextField(
                                                  hintText: 'Name',
                                                  controller: nameController,
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'This field is required';
                                                    }
                                                    return null;
                                                  },
                                                ),
                                                MyTextField(
                                                  hintText: 'imageUrl',
                                                  controller:
                                                      imageUrlController,
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'This field is required';
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            if (_key.currentState!.validate()) {
                                              FirebaseFirestore.instance
                                                  .collection('catagories')
                                                  .doc(widget.data['id'])
                                                  .update({
                                                'name': nameController.text,
                                                'imageUrl':
                                                    imageUrlController.text,
                                              });

                                              Navigator.pop(context);
                                            }
                                          },
                                          child: Container(
                                            height: 50,
                                            color: Colors.green,
                                            child: const Center(
                                              child: Icon(
                                                Icons.save,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.edit)),
                      IconButton(
                        onPressed: () {
                          isLoading = true;
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
                                            'Are you sure want to delete ${widget.data['name']}?',
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
                                                FirebaseFirestore.instance
                                                    .collection('catagories')
                                                    .doc(widget.data['id'])
                                                    .delete()
                                                    .then((value) {
                                                  isLoading = false;
                                                }).catchError((error) {
                                                  isLoading = false;
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
                        icon: const Icon(Icons.delete_rounded),
                        color: Colors.red,
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  void clearControllers() {
    nameController.clear();
    imageUrlController.clear();
  }

  @override
  void dispose() {
    nameController.dispose();
    imageUrlController.dispose();
    super.dispose();
  }
}
