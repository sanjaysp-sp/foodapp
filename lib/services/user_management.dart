import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserManagement {
  storeNewUser(user, context) {
    FirebaseFirestore.instance.collection('Users').add({
      'email': user.email,
      'uid': user.uid
    }).then((value) {
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed('/homepage');
    }).catchError((e) {
      print(e);
    });
  }
}