import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'package:template/presentation/core/base_widget.dart';

import 'dependency_injection.dart';
import 'fcm_init.dart';

Future<void> main() async {
  await init();
  await GetStorage.init();

  WidgetsFlutterBinding.ensureInitialized();
  setupDI(); //Dependency Injection
  await locator.allReady(); //DI waiting
  runApp(const BaseWidget());
}
