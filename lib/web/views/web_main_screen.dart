import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//Widgets
import '../widgets/grid_item.dart';
import '../widgets/text_field.dart';
//util
import '../../util.dart';

class WebMainScreen extends StatefulWidget {
  static const routeName = '/webMainScreen';
  const WebMainScreen({Key? key}) : super(key: key);

  @override
  State<WebMainScreen> createState() => _WebMainScreenState();
}

class _WebMainScreenState extends State<WebMainScreen> {
  final positionController = TextEditingController();
  final nameController = TextEditingController();
  final imageUrlController = TextEditingController();
  final _key = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MenuKarte',
          style: appBarTextStyle,
        ),
        actions: [
          IconButton(
            onPressed: () {
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
                                    hintText: 'imageUrl',
                                    controller: imageUrlController,
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
                                FirebaseFirestore.instance
                                    .collection('catagories')
                                    .add({
                                  'id': 'z',
                                  'position':
                                      int.parse(positionController.text),
                                  'name': nameController.text,
                                  'imageUrl': imageUrlController.text,
                                  'items': [],
                                }).then((doc) {
                                  FirebaseFirestore.instance
                                      .collection('catagories')
                                      .doc(doc.id)
                                      .update({'id': doc.id});
                                  clearControllers();
                                }).catchError((error) {
                                  print(error);
                                });

                                Navigator.pop(context);
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
            },
            icon: const Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('catagories')
            .orderBy('position')
            .snapshots(),
        builder: (_, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          return GridView.builder(
            padding: const EdgeInsets.all(100),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 300,
              childAspectRatio: 1,
              crossAxisSpacing: 30,
              mainAxisSpacing: 30,
            ),
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) => GridITem(
              data: snapshot.data.docs[index].data(),
            ),
          );
        },
      ),
    );
  }

  void clearControllers() {
    nameController.clear();
    imageUrlController.clear();
    positionController.clear();
  }

  @override
  void dispose() {
    nameController.dispose();
    imageUrlController.dispose();
    positionController.dispose();
    super.dispose();
  }
}
