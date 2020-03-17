import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';

class FirebaseOnlineStatus extends StatefulWidget {
  final Widget page;
  FirebaseOnlineStatus(this.page);

  @override
  _FirebaseOnlineStatusState createState() => _FirebaseOnlineStatusState();
}

class _FirebaseOnlineStatusState extends State<FirebaseOnlineStatus> {

  @override
  Widget build(BuildContext context) {
    return Container(
      
      child: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;
          return new Stack(
            //fit: StackFit.expand,
            children: [
              Positioned(
                height: 14.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  color: connected ? Color(0xFF00EE44) : Color(0xFFEE4400),
                  child: Center(
                    child: Text("${connected ? 'CONNECTED' : 'DISCONNECTED'}"),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Center(
                  child: widget.page  // the page to render
                ),
              ),
            ],
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'There are no bottons to push :)',
            ),
            new Text(
              'Just turn off your internet.',
            ),
          ],
        ),
      ),
      
    );
  }

}