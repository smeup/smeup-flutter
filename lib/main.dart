import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

import 'models/offLineMode.dart';
import 'services/firebaseHttpService.dart';
import 'services/smeupCacheService.dart';
import 'services/smeupSoundNotificationsService.dart';
import 'homePage.dart';
import 'models/smeupSettings.dart';
import 'services/smeupHttpService.dart';
import 'package:connectivity/connectivity.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  // Fetch the available cameras before initializing the app.
  try {
    MyApp.cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error: ${e.code}\nError Message: ${e.description}');
  }

  await MyApp.fsCloudDb.settings(persistenceEnabled: true).timeout(MyApp.smeupSettings.connectionTimeout);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // grafanaUrl:
  //  prod: "http://172.16.2.142:3000/api/datasources/proxy/1/"
  //  debug "http://10.0.2.2:8087/api/datasources/proxy/1/"
  static SmeupSettings smeupSettings = SmeupSettings(
      /// If you're running the server locally and using the Android emulator,
      /// then your server endpoint should be 10.0.2.2:3000 instead of localhost:3000
      /// as AVD uses 10.0.2.2 as an alias to your host loopback interface (i.e) localhost
      configUrl: 'http://10.0.2.2:3000',
      grafanaUrl: 'http://172.16.2.142:3000/api/datasources/proxy/1/',
      backendAudioNotificationEnabled: true,
      offlineEnabled: true,
      connectionTimeout: Duration(days: 0, hours: 0, minutes: 0, seconds: 1),
      firebaseUrl:'https://smeupflutter.firebaseio.com/'
  );

  // http service for the smeup backend requests
  static SmeupHttpService smeupHttpService = new SmeupHttpService();

  // http service for the firebase backend requests
  static FirebaseHttpService firebaseHttpService = new FirebaseHttpService();

  // Create the instance of FileCache
  static SmeupCacheService smeupCacheService = new SmeupCacheService(OfflineModes.time, 
                                      Duration(days: 0, hours: 0, minutes: 1, seconds: 0), 
                                      Duration(days: 0, hours: 0, minutes: 10, seconds: 0));
  // Create the instance of FileCache
  static SmeupSoundNotificationsService notificationsService = new SmeupSoundNotificationsService();

  // list of device cameras
  static List<CameraDescription> cameras = [];

  // Firebase Cloud Database Reference
  static final fbCloudDb = FirebaseDatabase.instance.reference();
  static final fsCloudDb = Firestore.instance;

  static Future<bool> isOnline() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    switch (connectivityResult) {
      case ConnectivityResult.none:
        return false;
      default:
        return true;
    }
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smeup - Flutter',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: HomePage(title: 'Smeup Flutter - Home Page'),
    );
  }

/// App states management
@override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }
  
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

}
