import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//Models
import '../models/catagory.dart';

class Data with ChangeNotifier {
  final List<Catagory> _catagories = [];

  List<Catagory> get catagories {
    return [..._catagories];
  }

  Future<void> loadData() async {
    FirebaseFirestore.instance.collection('catagories').get().then((value) {
      _catagories.clear();
      for (var doc in value.docs) {
        _catagories.add(Catagory.fromMap(
          doc.data(),
        ));
      }
      notifyListeners();
    });

    FirebaseFirestore.instance
        .collection('catagories')
        .snapshots()
        .listen((event) {
      _catagories.clear();
      for (var doc in event.docs) {
        _catagories.add(Catagory.fromMap(
          doc.data(),
        ));
      }
      notifyListeners();
    });
  }

  Catagory findCatagoryById(String id) {
    for (var catagory in _catagories) {
      if (catagory.id == id) return catagory;
    }
    throw Exception('Catagory not found');
  }
}
