import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:soundpool/soundpool.dart';

class SmeupSoundNotificationsService {
  
  Soundpool pool = Soundpool(streamType: StreamType.notification);
  int soundErrorId = -1;

  playError() async {
    
    if(soundErrorId < 0) 
      soundErrorId =  await rootBundle.load("res/sounds/error2.mp3").then((ByteData soundData) {
        return pool.load(soundData);
      });
    
    pool.play(soundErrorId);
  }
}
