import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:here_sdk/core.dart';
import 'package:here_sdk/core.engine.dart';
import 'package:here_sdk/core.errors.dart';
import 'package:location/location.dart' as loc;
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'logic/stores/auth_store.dart';
import 'logic/stores/location_store.dart';
import 'logic/stores/order_store.dart';
import 'utils/const.dart';
import 'utils/dark_theme.dart';
import 'utils/env/env.dart';
import 'utils/light_theme.dart';
import 'utils/routes/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Usually, you need to initialize the HERE SDK only once during the lifetime of an application.
  _initializeHERESDK();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  initLocation();

  runApp(MainApp());
}

void _initializeHERESDK() async {
  // Needs to be called before accessing SDKOptions to load necessary libraries.
  SdkContext.init(IsolateOrigin.main);

  // Set your credentials for the HERE SDK.
  String accessKeyId = Env.hereSdkID;
  String accessKeySecret = Env.hereSdkSecret;
  SDKOptions sdkOptions = SDKOptions.withAccessKeySecret(accessKeyId, accessKeySecret);

  try {
    await SDKNativeEngine.makeSharedInstance(sdkOptions);
  } on InstantiationException {
    logger.d("Initialization failed: InstantiationException");
    throw Exception("Failed to initialize the HERE SDK.");
  }
}

Future<void> initLocation() async {
  loc.Location location = loc.Location();

  bool serviceEnabled;
  loc.PermissionStatus permissionGranted;

  serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) {
      return;
    }
  }

  permissionGranted = await location.hasPermission();
  if (permissionGranted == loc.PermissionStatus.denied) {
    permissionGranted = await location.requestPermission();
    if (permissionGranted != loc.PermissionStatus.granted) {
      return;
    }
  }
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final AppRouter appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthStore()),
        ChangeNotifierProvider(create: (_) => OrderStore()),
        ChangeNotifierProvider(create: (_) => LocationStore()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: lightTheme(),
        darkTheme: darkTheme(),
        // themeMode: ThemeMode.dark,
        routerConfig: appRouter.config(),
      ),
    );
  }
}
