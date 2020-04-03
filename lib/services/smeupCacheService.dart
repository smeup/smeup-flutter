import 'dart:async';

import 'package:async/async.dart';

import '../models/offLineMode.dart';

class SmeupCacheService {
  OfflineModes _offLineMode;
  Duration _offLineExpireTime;
  Duration _offLineCacheClearTime;
  Map<String, AsyncCache<List<String>>> _cacheList;

  SmeupCacheService(this._offLineMode, this._offLineExpireTime, this._offLineCacheClearTime) {
    _cacheList = new Map<String, AsyncCache<List<String>>>();

    if(_offLineMode == OfflineModes.time) {
      new Timer.periodic(_offLineCacheClearTime, (Timer t) => this.clearCache());
    }
  }

  
  AsyncCache<List<String>> createElement() {
    return new AsyncCache<List<String>>(this._offLineExpireTime);
  }

  removeElement(String key) {
    _cacheList.remove(key);
  }

  AsyncCache<List<String>> getElement(String key) {
    return _cacheList[key];
  }

  addElement(String key, AsyncCache<List<String>> value) {
    _cacheList[key] = value;
  }

  clearCache() {
    //print('before clear cache!: $_cacheList');
    _cacheList.clear();
    //print('after clear cache!: $_cacheList');
  }

}