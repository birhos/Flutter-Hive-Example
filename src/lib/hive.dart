import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

import 'domain/models/user/userModel.dart';

Future<void> setupHive() async {
  final Directory appDocumentDirectory =
      await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);

  Hive.registerAdapter(UserModelAdapter());
}

Future<void> closeHive() async {
  await Hive.close();
}
