import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'main.dart';


class SignUpWidget extends StatefulWidget {

  final Function() onClickedSignIn;

  const SignUpWidget({
    Key? key,
    required this.onClickedSignIn,
  }) : super(key: key);

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose(){
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Form(
      key: formKey,
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
            'Hello Brethren \n Ready To Join Us',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          const SizedBox(height: 60),
          TextFormField(
            controller: nameController,
            cursorColor: Colors.white,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(labelText: 'Name'),
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
          const SizedBox(height: 40,),
          TextFormField(
            controller: emailController,
            cursorColor: Colors.white,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(labelText: 'Email'),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (email) =>
            email != null && !EmailValidator.validate(email)
              ? 'Enter a valid email'
              : null,
          ),
          const SizedBox(height: 40,),
          TextFormField(
            controller: passwordController,
            cursorColor: Colors.white,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) => value != null && value.length < 6
            ? 'Enter min. of 6 characters'
            : null,
          ),
          const SizedBox(height: 40,),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
            ),
            icon: const Icon(Icons.arrow_forward, size: 32),
            label: const Text('Sign Up', style: TextStyle(fontSize: 24),),
            onPressed: signUp,
          ),
          const SizedBox(height: 20),
          RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                text: 'Already have an account?     ',
                children: [
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = widget.onClickedSignIn,
                    text: 'Log In',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Theme.of(context).colorScheme.secondary
                    ),
                  ),
                ],
              ))
        ],
      ),
    ),
  );
  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Incorrect Password Or No Data Connection')));
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
