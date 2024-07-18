
import 'package:flutter/material.dart';

import 'key_helper.dart';

class DeviceHelper {
  static double get screenHeight {
    return MediaQuery.of(KeyHelper.appNavKey.currentContext!).size.height;
  }

  static double get screenWidth {
    return MediaQuery.of(KeyHelper.appNavKey.currentContext!).size.width;
  }

  static double get availableScreenHeight {
    return screenHeight -
        (MediaQuery.of(KeyHelper.appNavKey.currentContext!).padding.top +
        kToolbarHeight ) - kBottomNavigationBarHeight;
  }
}
