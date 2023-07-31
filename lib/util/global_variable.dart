import 'package:flutter/widgets.dart';

/// context를 언제든 불러오기위한 GlobalKey
class GlobalAccessContext {
  static final GlobalKey<NavigatorState> navigatorState =
      GlobalKey<NavigatorState>();
}
