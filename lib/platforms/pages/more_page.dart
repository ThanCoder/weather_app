import 'package:flutter/material.dart';
import 'package:t_widgets/t_widgets.dart';
import 'package:weather/platforms/pages/app_about_dialog.dart';
import 'package:weather/platforms/pages/dev_pages/dev_route_tile.dart';

import 'version_manager.dart';

class MorePage extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    // final col = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text("More")),
      body: TScrollableColumn(
        children: [
          TMaterialThemeProviderChooser(),
          VersionManager(githubUrl: 'https://github.com/ThanCoder/weather_app'),
          // CacheManagerListTile(
          //   cacheDirPath: AppUtil.instance.getPlatformCachePath(),
          // ),
          DevRouteTile(),
          AppAboutDialogListTile(appDesc: 'Weather App'),
        ],
      ),
    );
  }
}
