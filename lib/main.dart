import 'package:camera/camera.dart';
//import 'package:file_cache/file_cache.dart';
import 'package:flutter/material.dart';
import 'package:smeup_flutter/models/offLineMode.dart';
import 'package:smeup_flutter/services/smeupCacheService.dart';
import 'package:smeup_flutter/services/smeupSoundNotificationsService.dart';

import 'homePage.dart';
import 'models/smeupSettings.dart';
import 'services/smeupHttpService.dart';

Future<void> main() async {
  // Fetch the available cameras before initializing the app.
  try {
    WidgetsFlutterBinding.ensureInitialized();
    MyApp.cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error: ${e.code}\nError Message: ${e.description}');
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // grafanaUrl:
  //  prod: "http://172.16.2.142:3000/api/datasources/proxy/1/"
  //  debug "http://10.0.2.2:8087/api/datasources/proxy/1/"
  static SmeupSettings smeupSettings = SmeupSettings(
      /// If you're running the server locally and using the Android emulator,
      /// then your server endpoint should be 10.0.2.2:3000 instead of localhost:3000
      /// as AVD uses 10.0.2.2 as an alias to your host loopback interface (i.e) localhost
      configUrl: "http://10.0.2.2:3000",
      grafanaUrl: "http://172.16.2.142:3000/api/datasources/proxy/1/",
      backendAudioNotificationEnabled: true,
      offlineEnabled: true,
      connectionTimeout: Duration(days: 0, hours: 0, minutes: 0, seconds: 1)
  );

  // http service for the backend requests
  static SmeupHttpService smeupHttpService = new SmeupHttpService();
  // Create the instance of FileCache
  static SmeupCacheService smeupCacheService = new SmeupCacheService(OfflineModes.time, 
                                      Duration(days: 0, hours: 0, minutes: 1, seconds: 0), 
                                      Duration(days: 0, hours: 0, minutes: 10, seconds: 0));
  // Create the instance of FileCache
  static SmeupSoundNotificationsService notificationsService = new SmeupSoundNotificationsService();

  // list of device cameras
  static List<CameraDescription> cameras = [];

  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smeup - Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(title: 'Smeup Flutter - Home Page'),
    );
  }
}
