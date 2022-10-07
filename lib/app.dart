import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:note_app/common/app_colors.dart';
import 'package:note_app/repositories/mock_note_repository.dart';
import 'package:note_app/repositories/note_repository.dart';
import 'package:note_app/router/app_routes.dart';
import 'package:note_app/common/app_themes.dart';
import 'package:note_app/ui/pages/detail_note/detail_note_cubit.dart';
import 'package:note_app/ui/pages/home/home_cubit.dart';
import 'package:note_app/ui/pages/new_note/new_note_cubit.dart';

class NoteApp extends StatelessWidget {
  const NoteApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<NoteRepository>(create: (context) {
          return MockNoteRepositoryImpl();
        }),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) {
            final noteRepo = RepositoryProvider.of<NoteRepository>(context);
            return HomeCubit(noteRepository: noteRepo);
          }),
          BlocProvider(create: (context) {
            final noteRepo = RepositoryProvider.of<NoteRepository>(context);
            return DetailNoteCubit(noteRepository: noteRepo);
          }),
          BlocProvider(create: (context) {
            final noteRepo = RepositoryProvider.of<NoteRepository>(context);
            return NewNoteCubit(noteRepository: noteRepo);
          }),
        ],
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.home,
          getPages: AppRoutes.pages,
          title: "Note App",
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
        ),
      ),
    );
  }
}
