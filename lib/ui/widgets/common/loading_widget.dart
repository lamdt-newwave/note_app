import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../common/app_colors.dart';
import '../../../common/app_images.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightPrimary,
      body: Center(
        child: Lottie.asset(AppImages.lottiePleaseWait),
      ),
    );
  }
}
