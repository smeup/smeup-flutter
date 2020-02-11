
class SmeupSettings {
  String configUrl;
  String grafanaUrl;
  bool offlineEnabled;
  bool backendAudioNotificationEnabled;
  Duration connectionTimeout;


  SmeupSettings({this.configUrl, this.grafanaUrl, this.backendAudioNotificationEnabled, this.offlineEnabled, this.connectionTimeout});
   
}