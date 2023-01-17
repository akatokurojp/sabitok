import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lit_ui_kit/lit_ui_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sabitok/utils/utils.dart';

class ForgorPage extends StatefulWidget {
  const ForgorPage({Key? key}) : super(key: key);

  @override
  State<ForgorPage> createState() => _ForgorPage();
}

class _ForgorPage extends State<ForgorPage> {
  final TextEditingController forgoremailController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    forgoremailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: forgoremailController.text.trim());
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content:
                  Text('Password Reset Link has been Sent! Check your E-Mail'),
            );
          });
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
            child: Center(
                child: SingleChildScrollView(
                    child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.phone_android,
              size: 100,
            ),
            //Hello again!
            Text(
              'Hello again !',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Welcome Back !',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            //email textfield
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: TextField(
                    controller: forgoremailController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Email',
                    ),
                  ),
                ),
              ),
            ),
            MaterialButton(
              onPressed: passwordReset,
              child: Text('Reset Password'),
              color: Colors.deepPurple[200],
            ),

            //password textfield
            SizedBox(
              height: 10,
            )
          ],
        )))));
  }
}
