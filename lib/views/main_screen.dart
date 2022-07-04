import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Providers
import '../providers/data.dart';
//Util
import '../util.dart';
//Widgets
import '../widgets/grid_item.dart';
//Models
import '../models/catagory.dart';

class AppMainScreen extends StatefulWidget {
  static const routeName = '/appMainScreen';
  const AppMainScreen({Key? key}) : super(key: key);

  @override
  State<AppMainScreen> createState() => _AppMainScreenState();
}

class _AppMainScreenState extends State<AppMainScreen> {
  var isLoading = false;
  final List<Catagory> catagories = [];
  @override
  Widget build(BuildContext context) {
    final catagoryProvider = Provider.of<Data>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MenuKarte',
          style: appBarTextStyle,
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: catagoryProvider.catagories.length,
              itemBuilder: (_, index) => GridItem(
                catagory: catagoryProvider.catagories[index],
              ),
            ),
    );
  }

  void switchIsLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  void initState() {
    switchIsLoading();
    Future.delayed(const Duration(milliseconds: 2)).then((value) {
      Provider.of<Data>(context, listen: false).loadData().then((value) {
        switchIsLoading();
      }).catchError((error) {
        switchIsLoading();
      });
    });
    super.initState();
  }
}
