import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:logger/logger.dart';

class Tools {
  static final _instance = Tools._internal();

  factory Tools() => _instance;

  Tools._internal();

  final Logger logger = Logger();


  static Future<Map<String, dynamic>> loadJson(String path) async {
    String content = await rootBundle.loadString(path);
    return jsonDecode(content);
  }

  static fieldFocusChange(
      BuildContext context,
      FocusNode current,
      FocusNode next,
      ) {
    current.unfocus();
    FocusScope.of(context).requestFocus(next);
  }

  static hiddenKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }


}


// class Tools {
//   static final Tools _instance = Tools.internal();
//
//   Tools.internal();
//
//   factory Tools() => _instance;
//
//   final Logger logger = Logger();
//
// }