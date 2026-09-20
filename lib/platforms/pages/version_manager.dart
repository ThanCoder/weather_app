import 'dart:io';

import 'package:flutter/material.dart';
import 'package:than_pkg_android/than_pkg_android.dart';
import 'package:than_pkg_linux/than_pkg_linux.dart';
import 'package:weather/core/util/app_util.dart';

class VersionManager extends StatelessWidget {
  final String githubUrl;

  const VersionManager({super.key, required this.githubUrl});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () {
        if (Platform.isAndroid) {
          ThanPkgAndroid.getInstance.launchHandler.launchUrl(
            '$githubUrl/releases',
          );
        }
        if (Platform.isLinux) {
          ThanPkgLinux.getInstance.launcher.launchUrl('$githubUrl/releases');
        }
      },
      child: Container(
        padding: .symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest.withValues(alpha: .45),
          borderRadius: .circular(15),
        ),
        child: Row(
          spacing: 10,
          children: [
            Icon(Icons.info_outline_rounded, color: colorScheme.primary),
            Column(
              crossAxisAlignment: .start,
              children: [
                const Text('Version', style: TextStyle(fontWeight: .w600)),
                Text(
                  AppUtil.instance.version,
                  style: TextStyle(color: colorScheme.onSurfaceVariant),
                ),
              ],
            ),

            const Spacer(),
            const Icon(Icons.open_in_new_rounded, size: 20),
          ],
        ),
      ),
    );
  }
}
