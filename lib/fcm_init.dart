import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:template/dependency_injection.dart';

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  requestPermission();
  prepairingNotification();
}

Future<void> backgroundHandler(RemoteMessage message) async {
  // print(message.data.toString());
  // print(message.notification!.title);
}

void requestPermission() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    //  print('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    //  print('User granted provisional permission');
  } else {
    //  print('User declined or has not accepted permission');
  }
}

prepairingNotification() async {
  var getInitialMessage = await FirebaseMessaging.instance.getInitialMessage();
  if (getInitialMessage != null) {
    // final routeFromMessage = getInitialMessage.data["route"];
    // print(routeFromMessage);
    //Navigator.of(context).of(context).pushNamed("");
  }

  String? getToken = await FirebaseMessaging.instance.getToken();

  //final box = GetStorage();
  locator.get<GetStorage>().write('notifyToken', getToken);
  log('${getToken.toString()} firebase');

  FirebaseMessaging.instance.onTokenRefresh.listen((token) async {
    // print("$token   dhskjhfdhjgfdgfkfdghjdffhdjgdhfjgdkfhjfkhgkdjhfg");
  });
  FirebaseMessaging.onMessage.listen((message) {
    if (message.notification != null) {
      //  print(message.notification!.body);
      // print(message.notification!.title);
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    // final routeFromMessage = message.data["route"];
    //  print(" message is: $routeFromMessage");
  });
}
