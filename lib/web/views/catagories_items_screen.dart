import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//Util
import '../../util.dart';
//Widgets
import '../widgets/list_item.dart';
import '../widgets/text_field.dart';

class CatagoriesItemsScreen extends StatefulWidget {
  static const routeName = '/catagoriesItemScreen';

  const CatagoriesItemsScreen({Key? key}) : super(key: key);

  @override
  State<CatagoriesItemsScreen> createState() => _CatagoriesItemsScreenState();
}

class _CatagoriesItemsScreenState extends State<CatagoriesItemsScreen> {
  final positionController = TextEditingController();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final _key = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          data['name'],
          style: appBarTextStyle,
        ),
        actions: [
          IconButton(
            onPressed: () => myDialog(context, data),
            icon: const Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator.adaptive())
          : StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('catagories')
                  .doc(data['id'])
                  .snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }

                return ListView.builder(
                  itemCount: snapshot.data['items'].length,
                  itemBuilder: (_, index) => ListItem(
                    data: data,
                    index: index,
                  ),
                );
              },
            ),
    );
  }

  Future<dynamic> myDialog(BuildContext context, Map<String, dynamic> data) {
    return showDialog(
      context: context,
      builder: (context) => Form(
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
                          hintText: 'Position',
                          controller: positionController,
                          isDigitOnly: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This field is required';
                            }
                            return null;
                          },
                        ),
                        MyTextField(
                          hintText: 'Name',
                          controller: nameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This field is required';
                            }
                            return null;
                          },
                        ),
                        MyTextField(
                          hintText: 'Description',
                          controller: descriptionController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This field is required';
                            }
                            return null;
                          },
                        ),
                        MyTextField(
                          hintText: 'Price',
                          controller: priceController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
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
                      final updatedItems = data['items'] as List<dynamic>;
                      updatedItems.add(
                        {
                          'position': int.parse(positionController.text),
                          'id': DateTime.now().toString(),
                          'name': nameController.text,
                          'description': descriptionController.text,
                          'price': double.tryParse(
                            priceController.text,
                          ),
                        },
                      );
                      switchIsLoading();
                      FirebaseFirestore.instance
                          .collection('catagories')
                          .doc(data['id'])
                          .update(
                        {
                          'items': FieldValue.arrayUnion(updatedItems),
                        },
                      ).then((value) {
                        switchIsLoading();
                        clearControllers();
                        Navigator.pop(context);
                      }).catchError((error) {
                        switchIsLoading();
                        Navigator.pop(context);
                      });
                    }
                  },
                  child: Container(
                    height: 50,
                    color: Colors.green,
                    child: const Center(
                      child: Icon(
                        Icons.add,
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
  }

  void clearControllers() {
    positionController.clear();
    nameController.clear();
    descriptionController.clear();
    priceController.clear();
  }

  void switchIsLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  void dispose() {
    positionController.dispose();
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    super.dispose();
  }
}
