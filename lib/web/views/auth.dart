import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

//Widgets
import '../widgets/text_field.dart';
//Screens
import '../views/web_main_screen.dart';
//Util
import '../../util.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth';
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orienttal Karlsruhe'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: double.infinity),
            SizedBox(
              width: 350,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  MyTextField(
                    hintText: 'Email',
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                    isDigitOnly: false,
                  ),
                  MyTextField(
                    hintText: 'Password',
                    controller: passwordController,
                    isObsecure: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                    isDigitOnly: false,
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text,
                          )
                              .then((userCredential) {
                            if (userCredential.user != null) {
                              Navigator.of(context).pushReplacementNamed(
                                  WebMainScreen.routeName);
                            }
                          }).catchError((error) {
                            String message = 'Error signing in';

                            switch (error.code) {
                              case 'user-not-found':
                                message = "User not found with this email";
                                break;
                              case 'wrong-password':
                                message = "Wrong password";
                                break;
                            }
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(
                                  message,
                                  textAlign: TextAlign.center,
                                  style: snackBarTitleTextStyle,
                                ),
                              ),
                            );
                          });
                        }
                      },
                      child: const Text('Sign in'),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  clearControllers() {
    emailController.clear();
    passwordController.clear();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
