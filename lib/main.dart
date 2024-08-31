import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_my_properties/helper/route_helper.dart';
import 'package:get_my_properties/utils/app_constants.dart';
import 'package:get_my_properties/utils/theme/light_theme.dart';
import 'helper/gi_dart.dart' as di;
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();

  Location location = new Location();
  bool _serviceEnabled;

  try {
    // Request location permission
    final permissionStatus = await Permission.location.request();
    if (!permissionStatus.isGranted) {
      debugPrint('Location permission denied');
      return;
    }

    // Check if the location service is enabled
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        debugPrint('Location Service not enabled');
      }
    }
  } catch (e) {
    debugPrint('Error checking location service: $e');
  }

  await di.init();
  runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: light,
      initialRoute: RouteHelper.getInitialRoute(),
      getPages: RouteHelper.routes,
      defaultTransition: Transition.topLevel,
      // home: UserCurrentLocation(),
      transitionDuration: const Duration(milliseconds: 500),
      builder: (BuildContext context, widget) {
        return MediaQuery(data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0), child: widget!);
      },
    );
  }
}

