import 'package:flutter/material.dart';
import 'package:custom_social_button/custom_social_button.dart';
import 'package:islamic_dunia/assets_helper/app_colors.dart';
import 'package:islamic_dunia/assets_helper/app_icons.dart';

class SocialButtonDemo extends StatelessWidget {
  const SocialButtonDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Social Button Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Facebook Button

            SocialButton(
              title: 'github',
              buttonTitle: 'Sign in with Github',
              svgIcon: AppIcons.github,
              color: Colors.blue,
              height: 60.0,
              borderRadius: 8.0,
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
              iconHeight: 20.0,
              iconWidth: 20.0,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Github button tapped!')),
                );
              },
            ),
            const SizedBox(height: 16.0),
            // Google Button with minimal customization
            SocialButton(
              title: 'google',
              buttonTitle: 'Sign in with Google',
              borderColor: AppColors.primaruDarki,
              borderWidth: 2,
              textStyle: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
              svgIcon: AppIcons.google,
              color: Colors.white,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Google button tapped!')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
