import 'package:get/get.dart';
import 'package:note_app/ui/pages/new_note/new_note_page.dart';

import '../ui/pages/detail_note/detail_note_page.dart';
import '../ui/pages/home/home_page.dart';

class AppRoutes {
  static const String home = "/home";
  static const String detailNote = "/detail-note";
  static const String newNote = "/new-note";
  static List<GetPage> pages = [
    GetPage(
        name: home,
        page: () => HomePage(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: detailNote,
        page: () => const DetailNotePage(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: newNote,
        page: () => const NewNotePage(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500))
  ];
}
