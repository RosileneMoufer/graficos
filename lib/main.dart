import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'configs/hive_config.dart';
import 'my_app_page.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.blueGrey,
  ));

  WidgetsFlutterBinding.ensureInitialized();
  await HiveConfig.start();

  runApp(MyApp());
}
