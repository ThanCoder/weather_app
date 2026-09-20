import 'dart:io';
import 'dart:isolate';

import 'package:dart_core_extensions/dart_core_extensions.dart';
import 'package:flutter/material.dart';

class PUtils {
  /// ### Return -> [(count,size)]
  static Future<(int, int)?> getFolderInfo(Directory dir) async {
    if (!dir.existsSync()) return null;
    return await Isolate.run<(int, int)?>(() {
      try {
        int size = 0;
        int count = 0;
        for (var entry in dir.listSync(recursive: true)) {
          if (entry.isFile) {
            size += entry.size;
          }
          count++;
        }
        return (count, size);
      } catch (e) {
        debugPrint('[PUtils:deleteDir]: $e');
        return null;
      }
    });
  }

  static Future<bool> deleteFolder(Directory dir) async {
    if (!dir.existsSync()) return false;
    return await Isolate.run(() {
      try {
        dir.deleteSync(recursive: true);
        dir.createSync();
        return true;
      } catch (e) {
        debugPrint('[PUtils:deleteDir]: $e');
        return false;
      }
    });
  }
}
