import 'package:flutter/cupertino.dart';
import 'package:smeup_flutter/models/smeupJson.dart';

class SmeupWidgetBuilderResponse {
  SmeupJson parentState;
  Widget children;

  SmeupWidgetBuilderResponse(this.parentState, this.children);
}