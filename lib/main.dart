import 'dart:io';

import 'package:flutter/material.dart';
import 'package:than_pkg_linux/than_pkg_linux.dart';
import 'package:weather/core/util/app_util.dart';
import 'package:weather/keys.dart';
import 'package:weather/platforms/platform_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppUtil.instance.init();


   if (Platform.isLinux) {
    final cf = AppUtil.instance.config;
    ThanPkgLinux.getInstance.window.setWindowSize(
      width: cf.getDouble(appWindowWidthKey,600).toInt(),
      height: cf.getDouble(appWindowHeightKey,400).toInt(),
    );
  }

  runApp(const PlatformApp());
}
