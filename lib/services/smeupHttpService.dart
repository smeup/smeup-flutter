import 'package:http/http.dart' as http;
import 'package:smeup_flutter/main.dart';

enum HttpResponseType { json, influxDB }

class HttpScriptResponse {
  String data;
  HttpResponseType responseType;
  bool isError;

  HttpScriptResponse(this.data, this.responseType, this.isError);
}

class SmeupHttpService {
  Future<HttpScriptResponse> getScript(String scriptName) async {
    HttpResponseType responseType = scriptName.startsWith('graf:')
        ? HttpResponseType.influxDB
        : HttpResponseType.json;

    scriptName = normalizeScriptName(scriptName, responseType);

    if (MyApp.smeupSettings.offlineEnabled) {
      /// OFFLINE ENABLED

      /// try to get the online result first
      return getScriptOnLine(scriptName, responseType).then((resOnline) {
        
        if (resOnline.isError) {

          /// online is not working. check if the cache element exists in the list 
          var cacheElement = MyApp.smeupCacheService.getElement(scriptName);

          /// if it doesn't exist return error
          if (cacheElement == null) {
                  MyApp.notificationsService.playError();
                  return getError(scriptName, responseType, "the server is offline");
          }

          /// otherwise I fetch the cache element and return the value
          return cacheElement.fetch(() {
            
            /// if the element is expired: remove the cache element from the list and return error
            MyApp.smeupCacheService.removeElement(scriptName);
            MyApp.notificationsService.playError();
            return getError(scriptName, responseType, "the server is offline");

          }).then((list) {
            
            /// return the value of the cache element
            return Future(() {
              return HttpScriptResponse(list.first, responseType, false);
            });

          });

        } else {

          /// online is working but I save the cache anyway
          
          /// create a new cache element
          var cacheElement = MyApp.smeupCacheService.createElement();

          /// fetch the cache element and set the value
          return cacheElement.fetch(() {

            /// set the value of the cache element
            return Future(() {
              var list = new List<String>();
              list.add(resOnline.data);
              return list;
            });

          }).then((list) {
            
            /// add the cache element in the list
            MyApp.smeupCacheService.addElement(scriptName, cacheElement);

            /// return the result from online
            return Future(() {
              return HttpScriptResponse(list.first, responseType, false);
            });

          });
        }
      });

    } else {
      
      // OFFLINE DISABLED
      return getScriptOnLine(scriptName, responseType);
    }
  }

  Future<HttpScriptResponse> getScriptOnLine(
      String scriptName, HttpResponseType responseType) async {
    return http
        .get(scriptName)
        .timeout(MyApp.smeupSettings.connectionTimeout)
        .then((http.Response response) {
      return HttpScriptResponse(response.body, responseType, false);
    }).catchError((e) {
      return getError(scriptName, responseType, "the server is offline");
    });
  }

  String normalizeScriptName(String scriptName, HttpResponseType responseType) {
    if (responseType == HttpResponseType.influxDB) {
      scriptName = scriptName.replaceFirst("graf:", "");
      scriptName = '${MyApp.smeupSettings.grafanaUrl}/$scriptName';
    } else {
      if (scriptName.contains("config/"))
        scriptName = scriptName.replaceFirst("config/", "");

      if (scriptName.contains("graf/"))
        scriptName = scriptName.replaceFirst("graf/", "");

      scriptName = '${MyApp.smeupSettings.configUrl}/config/graf/$scriptName';
    }

    return scriptName;
  }

  getError(String scriptName, HttpResponseType responseType, String message) {
    return Future(() {
      return HttpScriptResponse(message, responseType, true);
    });
  }
}
