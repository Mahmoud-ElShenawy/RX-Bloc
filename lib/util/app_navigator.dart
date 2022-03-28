import 'package:flutter/material.dart';

class AppNavigator {
  static void push(BuildContext context, Widget scene) {
    Navigator.push<void>(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => scene,
      ),
    );
  }

  static void pushReplacement(BuildContext context, Widget scene) {
    Navigator.pushReplacement<void, void>(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => scene,
      ),
    );
  }

  static void pushAndRemoveUntil(BuildContext context, Widget scene) {
    Navigator.pushAndRemoveUntil<void>(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => scene,
        ),
        (route) => false);
  }

  static void pushResult(
      BuildContext context, Widget scene, Function(Object?) function) {
    Navigator.push<void>(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => scene,
      ),
    ).then((dynamic result) {
      if (result == null) {
        return;
      }
      function(result);
    }).catchError((dynamic error) {
      print('$error');
    });
  }

  static void goBack(BuildContext context) {
    Navigator.pop(context);
  }

  static void goBackWithParams(BuildContext context, dynamic result) {
    Navigator.pop<dynamic>(context, result);
  }
}
