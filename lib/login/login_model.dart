import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginModel extends ChangeNotifier {

  final titleController = TextEditingController();
  final authorController = TextEditingController();


  String? email;
  String? password;

  bool isLoding = false;

  void startLoding() {
    isLoding = true;
    notifyListeners();
  }

  void endLoding() {
    isLoding = false;
    notifyListeners();
  }


  void setEmail (String email) {
    this.email = email;
    notifyListeners();
  }

  void setPassword (String password) {
    this.password = password;
    notifyListeners();
  }

  Future login() async {
    this.email = titleController.text;
    this.password = authorController.text;

    if (email != null && password != null) {
      //ログイン
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: password!);

      final currentUser = FirebaseAuth.instance.currentUser;
      final uid = currentUser!.uid;
    }


  }
}
