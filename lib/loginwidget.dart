import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:youth_fellowship/forgotpassword.dart';

import 'main.dart';


class LoginWidget extends StatefulWidget {

  final VoidCallback onClickedSignUp;

  const LoginWidget({
    Key? key,
    required this.onClickedSignUp,
}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
      return SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 60),
            const Padding(
              padding: EdgeInsets.only(left: 10, top: 60),
              child: CircleAvatar(
                radius: 150,
                backgroundImage: AssetImage('assets/youth2.jpg'),
              ),
            ),
            const SizedBox(height: 60),
            const Text(
              'Welcome Back Brethren \n Ready To Join Us',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
            const SizedBox(height: 80),
            TextField(
              controller: emailController,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 40,),
            TextField(
              controller: passwordController,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 40,),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              icon: const Icon(Icons.lock_open, size: 32),
              label: const Text('Sign In', style: TextStyle(fontSize: 24),),
              onPressed: signIn,
            ),
            const SizedBox(height: 20),
            GestureDetector(
              child: Text('Forgot Password?',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Theme
                      .of(context)
                      .colorScheme
                      .secondary,
                  fontSize: 20,
                ),),
              onTap: () =>
                  Navigator.of(context).push(MaterialPageRoute
                    (builder: (context) => ForgotPasswordPage(),
                  )),
            ),
            const SizedBox(height: 16),
            RichText(
                text: TextSpan(
                  style: const TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                  text: 'No account?     ',
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = widget.onClickedSignUp,
                      text: 'Sign Up',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Theme
                              .of(context)
                              .colorScheme
                              .secondary
                      ),
                    ),
                  ],
                ))
          ],
        ),
      );
}
  Future signIn() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
      if (e.code == 'user-not-found') {
        wrongEmailMessage();
      } else if (e.code == 'wrong-password') {
        wrongPasswordMessage();
      }
    }
  }
  void wrongEmailMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text('Incorrect Email'),
          );
        },
    );
  }

  void wrongPasswordMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text('Incorrect Password'),
        );
      },
    );
  }
}
