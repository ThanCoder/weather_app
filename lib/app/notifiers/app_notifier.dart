import 'package:flutter/material.dart';

import '../models/core/app_config_model.dart';
//path
ValueNotifier<String> appRootPathNotifier = ValueNotifier('');
ValueNotifier<String> appExternalPathNotifier = ValueNotifier('');
ValueNotifier<String> appConfigPathNotifier = ValueNotifier('');
//theme
ValueNotifier<bool> isDarkThemeNotifier = ValueNotifier(false);
//config
ValueNotifier<AppConfigModel> appConfigNotifier =
    ValueNotifier(AppConfigModel());
