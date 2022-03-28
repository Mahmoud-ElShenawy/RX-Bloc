import 'package:flutter/material.dart';
import 'package:rx_bloc/common/tools.dart';
import 'package:rx_bloc/util/tools.dart';

import 'connectivity.dart';

checkConnectivity(BuildContext contextDialog) {
  debugPrint('AppState: Init Mobile Modules ..');
  MyConnectivity.instance.initialise();
  MyConnectivity.instance.myStream.listen((onData) {
    debugPrint('App: Internet Issue Change: $onData');
    if (MyConnectivity.instance.isIssue(onData)) {
      if (MyConnectivity.instance.isShow == false) {
        Tools().logger.w('No Internet Connection');
        MyConnectivity.instance.isShow = true;
      }
    } else {
      if (MyConnectivity.instance.isShow == true) {
        MyConnectivity.instance.isShow = false;
        debugPrint('There is Internet Connection');
      }
    }
  });
  debugPrint('AppState: Register Modules .. DONE');
}
