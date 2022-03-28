import 'package:flutter/material.dart';
import 'package:rx_bloc/util/util_shared.dart';
import 'package:rx_bloc/view/home_page.dart';

import 'common/bloc_module/bloc_base/bloc_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UtilShared.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: 'Flutter Bloc Demo',
        debugShowCheckedModeBanner: false,
        home: HomePage(
          title: 'TEEEEESSSSTTT',
        ));
  }
}
