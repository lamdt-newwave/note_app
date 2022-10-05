import 'package:get/get.dart';

import '../ui/pages/home/home_page.dart';

class AppRoute {
  static const String home = "/home";

  static List<GetPage> pages = [
    GetPage(name: home, page: () => HomePage()),
  ];
}
