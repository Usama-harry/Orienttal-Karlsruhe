import 'package:flutter/material.dart';

class WebMainScreen extends StatelessWidget {
  static const routeName = '/webMainScreen';
  const WebMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MenuKarte'),
      ),
    );
  }
}
