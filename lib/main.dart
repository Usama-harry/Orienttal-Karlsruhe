import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

//Screens
import './views/main_screen.dart';
import './views/catagory_items_screen.dart';
import 'web/views/web_main_screen.dart';
import './web/views/catagories_items_screen.dart';
import './web/views/auth.dart';
//Providers
import './providers/data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyBi9-O-bGYaSNBS0ygJbCPKOytHIfOYmZU',
          appId: "1:854936757558:web:c269dfaafccb7cb343ff97",
          messagingSenderId: "854936757558",
          projectId: "orienttal-karlsruhe"),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Data(),
        )
      ],
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Orienttal Karlsruhe',
        theme: ThemeData.dark(),
        initialRoute: kIsWeb ? AuthScreen.routeName : AppMainScreen.routeName,
        routes: {
          AppMainScreen.routeName: (context) => const AppMainScreen(),
          CatagoryItemsScreen.routeName: (context) =>
              const CatagoryItemsScreen(),
          WebMainScreen.routeName: (context) => const WebMainScreen(),
          CatagoriesItemsScreen.routeName: (context) =>
              const CatagoriesItemsScreen(),
          AuthScreen.routeName: (context) => const AuthScreen(),
        },
      ),
    );
  }
}
