import 'package:flutter/material.dart';
import 'package:islamic_dunia/assets_helper/app_colors.dart';
import 'package:islamic_dunia/assets_helper/app_images.dart';

final class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        //decoration: const BoxDecoration(color: AppColors.allPrimaryColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Image.asset(
              AppImages.playStoreImage,
              height: 170,
              width: 170,
            ),
          ],
        ),
      ),
    );
  }
}
