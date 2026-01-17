import 'package:flutter/cupertino.dart';

class LocationNotifier {
  static final ValueNotifier<int> refresh = ValueNotifier(0);

  static void notify() {
    refresh.value++;
  }
}
