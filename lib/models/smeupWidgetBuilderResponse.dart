import 'package:flutter/cupertino.dart';

import '../models/smeupJson.dart';

class SmeupWidgetBuilderResponse {
  SmeupJson parentState;
  Widget children;

  SmeupWidgetBuilderResponse(this.parentState, this.children);
}