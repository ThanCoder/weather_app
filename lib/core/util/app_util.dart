import 'dart:io';

import 'package:cfb_store/cfb_store.dart';
import 'package:dart_core_extensions/dart_core_extensions.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:than_pkg_linux/than_pkg_linux.dart';

class AppUtil {
  static final AppUtil instance = AppUtil._();
  AppUtil._();
  factory AppUtil() => instance;

  final config = CFBStore.instance;
  late final String appName;
  late final String packageName;
  late final String version;
  late Directory _cacheDir;
  late Directory _configDir;
  final isMobileNotifier = ValueNotifier<bool>(true);

  Future<void> init() async {
    final info = await PackageInfo.fromPlatform();
    appName = info.appName;
    packageName = info.packageName;
    version = info.version;

    _cacheDir = await getApplicationCacheDirectory();
    if (Platform.isLinux) {
      _configDir = (await ThanPkgLinux.getInstance.pathHandler
          .getApplicationConfigDirectory())!;
    }
    if (Platform.isAndroid) {
      _configDir = (await getExternalStorageDirectory())!;
    }

    await config.open(_configDir.join('app.config.cfb'));
  }

  String getPlatformCachePath([String? name]) {
    if (!_cacheDir.existsSync()) {
      _cacheDir.createSync(recursive: true);
    }
    if (name != null) {
      return _cacheDir.join(name);
    }
    return _cacheDir.path;
  }

  String getPlatformConfigPath([String? name]) {
    if (!_configDir.existsSync()) {
      _configDir.createSync(recursive: true);
    }
    if (name != null) {
      return _configDir.join(name);
    }
    return _configDir.path;
  }
}
