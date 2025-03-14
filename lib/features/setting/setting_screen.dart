import 'package:flutter/material.dart';
import 'package:islamic_dunia/assets_helper/app_colors.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cDCE4E6.withOpacity(0.9),
      body: Center(
        child: Text('Setting Screen'),
      ),
    );
  }
}
