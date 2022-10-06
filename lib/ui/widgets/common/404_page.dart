import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../common/app_colors.dart';
import '../../../common/app_images.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightPrimary,
      body: Center(
        child: Lottie.asset(AppImages.lottie404),
      ),
    );
  }
}
