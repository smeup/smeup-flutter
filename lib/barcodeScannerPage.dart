import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:image_picker/image_picker.dart';

class BarcodeScannerPage extends StatefulWidget {
  BarcodeScannerPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _BarcodeScannerPageState createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  String barcode = "";
  //String _scanBarcode = 'Unknown';

  @override
  void initState() {
    super.initState();
  }

  File galleryFile;

  imageSelectorGallery() async {
    galleryFile = await ImagePicker.pickImage(
      source: ImageSource.gallery,
// maxHeight: 50.0,
// maxWidth: 50.0,
    );
    print("You selected gallery image : " + galleryFile.path);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
          appBar: new AppBar(
            title: const Text('Scan Barcode'),
          ),
          body: new Center(
            child: new Column(
              children: <Widget>[
                new Container(
                  child: new RaisedButton(
                      onPressed: barcodeScanning,
                      child: const Text("Capture image")),
                  padding: const EdgeInsets.all(8.0),
                ),
                new Padding(
                  padding: const EdgeInsets.all(8.0),
                ),
                Text("Barcode Number after Scan : " + barcode),
                // displayImage(),
              ],
            ),
          ));
  }

  Widget displayImage() {
    return new SizedBox(
      height: 300.0,
      width: 400.0,
      child: galleryFile == null
          ? const Text('Sorry nothing to display')
          : new Image.file(galleryFile),
    );
  }

// Method for scanning barcode....
  Future barcodeScanning() async {
//imageSelectorGallery();

    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'No camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => this.barcode = 'Nothing captured.');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }

//  startBarcodeScanStream() async {
//     FlutterBarcodeScanner.getBarcodeStreamReceiver(
//             "#ff6666", "Cancel", true, ScanMode.BARCODE)
//         .listen((barcode) => print(barcode));
//   }

//   Future<void> scanQR() async {
//     String barcodeScanRes;
//     // Platform messages may fail, so we use a try/catch PlatformException.
//     try {
//       barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
//           "#ff6666", "Cancel", true, ScanMode.QR);
//       print(barcodeScanRes);
//     } on PlatformException {
//       barcodeScanRes = 'Failed to get platform version.';
//     }

//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//     if (!mounted) return;

//     setState(() {
//       _scanBarcode = barcodeScanRes;
//     });
//   }

//   // Platform messages are asynchronous, so we initialize in an async method.
//   Future<void> scanBarcodeNormal() async {
//     String barcodeScanRes;
//     // Platform messages may fail, so we use a try/catch PlatformException.
//     try {
//       barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
//           "#ff6666", "Cancel", true, ScanMode.BARCODE);
//       print(barcodeScanRes);
//     } on PlatformException {
//       barcodeScanRes = 'Failed to get platform version.';
//     }

//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//     if (!mounted) return;

//     setState(() {
//       _scanBarcode = barcodeScanRes;
//     });
//   }

// @override
//   Widget build(BuildContext context) {
//     return 
//         Scaffold(
//             appBar: AppBar(title: const Text('Barcode scan')),
//             body: Builder(builder: (BuildContext context) {
//               return Container(
//                   alignment: Alignment.center,
//                   child: Flex(
//                       direction: Axis.vertical,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         RaisedButton(
//                             onPressed: () => scanBarcodeNormal(),
//                             child: Text("Start barcode scan")),
//                         RaisedButton(
//                             onPressed: () => scanQR(),
//                             child: Text("Start QR scan")),
//                         RaisedButton(
//                             onPressed: () => startBarcodeScanStream(),
//                             child: Text("Start barcode scan stream")),
//                         Text('Scan result : $_scanBarcode\n',
//                             style: TextStyle(fontSize: 20))
//                       ]));
//             }));
//   }

}
