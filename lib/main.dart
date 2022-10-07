import 'package:flutter/material.dart';
import 'package:note_app/app.dart';

import 'database/sqlite_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await sqliteHelper.init();
  runApp(const NoteApp());
}
