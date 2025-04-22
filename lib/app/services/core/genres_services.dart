import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../models/core/genres_model.dart';
import '../../utils/path_util.dart';


Future<List<GenresModel>> getGenresList() async {
  List<GenresModel> list = [];
  try {
    final file = File('${PathUtil.instance.getDatabasePath()}/$appGenresDatabaseName');
    if (await file.exists()) {
      List<dynamic> resList = jsonDecode(await file.readAsString());
      list = resList.map((map) => GenresModel.fromMap(map)).toList();
    }
  } catch (e) {
    debugPrint('getGenresList: ${e.toString()}');
  }
  return list;
}

Future<void> removeGenresList({required String title}) async {
  try {
    List<GenresModel> list = [];
    final file = File('${PathUtil.instance.getDatabasePath()}/$appGenresDatabaseName');
    if (await file.exists()) {
      List<dynamic> resList = jsonDecode(await file.readAsString());
      list = resList.map((map) => GenresModel.fromMap(map)).toList();
    }
    list = list.where((gen) => gen.title != title).toList();
    //save
    final data = list.map((gen) => gen.toMap()).toList();
    await file.writeAsString(jsonEncode(data));
  } catch (e) {
    debugPrint('removeGenresList: ${e.toString()}');
  }
}

Future<void> addGenresList({required GenresModel genres}) async {
  try {
    List<GenresModel> list = [];
    final file = File('${PathUtil.instance.getDatabasePath()}/$appGenresDatabaseName');
    if (await file.exists()) {
      List<dynamic> resList = jsonDecode(await file.readAsString());
      list = resList.map((map) => GenresModel.fromMap(map)).toList();
    }
    list.insert(0, genres);
    //save
    final data = list.map((gen) => gen.toMap()).toList();
    await file.writeAsString(jsonEncode(data));
  } catch (e) {
    debugPrint('addGenresList: ${e.toString()}');
  }
}
