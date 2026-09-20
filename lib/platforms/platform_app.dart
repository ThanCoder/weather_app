import 'dart:async';

import 'package:flutter/material.dart';
import 'package:t_widgets/t_widgets.dart';
import 'package:weather/core/util/app_util.dart';
import 'package:weather/keys.dart';
import 'package:weather/platforms/desktop/desktop_home_screen.dart';
import 'package:weather/platforms/mobile/mobile_home_screen.dart';

class PlatformApp extends StatefulWidget {
  const new({super.key});

  @override
  State<PlatformApp> createState() => _PlatformAppState();
}

class _PlatformAppState extends State<PlatformApp> {
  final config = AppUtil.instance.config;
  BoxConstraints? constraints;
  Timer? _saveTimer;

  void saveSize() {
    if (constraints == null) return;
    _saveTimer?.cancel();
    _saveTimer = Timer(Duration(seconds: 3), () {
      config
          .put(appWindowWidthKey, constraints?.maxWidth)
          .put(appWindowHeightKey, constraints?.maxHeight)
          .writeAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return TMaterialThemeProvider(
      getTheme: () => .fromName(config.getString(appThemeKey)),
      onChanged: (type) {
        config.putAndWriteAll(appThemeKey, type.name);
      },
      child: _body,
    );
  }

  Widget get _body {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth <= 600;
        AppUtil.instance.isMobileNotifier.value = isMobile;
        this.constraints = constraints;
        saveSize();

        if (isMobile) {
          return MobileHomeScreen();
        }
        return DesktopHomeScreen();
      },
    );
  }
}
