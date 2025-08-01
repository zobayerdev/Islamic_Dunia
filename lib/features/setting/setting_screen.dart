import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:islamic_dunia/assets_helper/app_colors.dart';
import 'package:islamic_dunia/assets_helper/app_fonts.dart';
import 'package:islamic_dunia/assets_helper/app_images.dart';
import 'package:islamic_dunia/common_widgets/custom_button.dart';
import 'package:islamic_dunia/constants/app_constants.dart';
import 'package:islamic_dunia/helpers/all_routes.dart';
import 'package:islamic_dunia/helpers/di.dart';
import 'package:islamic_dunia/helpers/navigation_service.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final TextEditingController _controller = TextEditingController();
  String? _selectedDistrict;

  // List of 64 districts with English and Bengali names
  final List<Map<String, String>> districts = [
    {'english': 'Bandarban', 'bengali': 'বান্দরবান'},
    {'english': 'Barguna', 'bengali': 'বরগুনা'},
    {'english': 'Barishal', 'bengali': 'বরিশাল'},
    {'english': 'Bhola', 'bengali': 'ভোলা'},
    {'english': 'Bogura', 'bengali': 'বগুড়া'},
    {'english': 'Brahmanbaria', 'bengali': 'ব্রাহ্মণবাড়িয়া'},
    {'english': 'Chandpur', 'bengali': 'চাঁদপুর'},
    {'english': 'Chattogram', 'bengali': 'চট্টগ্রাম'},
    {'english': 'Chuadanga', 'bengali': 'চুয়াডাঙ্গা'},
    {'english': 'Cox’s Bazar', 'bengali': 'কক্সবাজার'},
    {'english': 'Cumilla', 'bengali': 'কুমিল্লা'},
    {'english': 'Dhaka', 'bengali': 'ঢাকা'},
    {'english': 'Dinajpur', 'bengali': 'দিনাজপুর'},
    {'english': 'Faridpur', 'bengali': 'ফরিদপুর'},
    {'english': 'Feni', 'bengali': 'ফেনী'},
    {'english': 'Gaibandha', 'bengali': 'গাইবান্ধা'},
    {'english': 'Gazipur', 'bengali': 'গাজীপুর'},
    {'english': 'Gopalganj', 'bengali': 'গোপালগঞ্জ'},
    {'english': 'Habiganj', 'bengali': 'হবিগঞ্জ'},
    {'english': 'Jamalpur', 'bengali': 'জামালপুর'},
    {'english': 'Jashore', 'bengali': 'যশোর'},
    {'english': 'Jhalokati', 'bengali': 'ঝালকাতি'},
    {'english': 'Jhenaidah', 'bengali': 'ঝিনাইদহ'},
    {'english': 'Joypurhat', 'bengali': 'জয়পুরহাট'},
    {'english': 'Khagrachhari', 'bengali': 'খাগড়াছড়ি'},
    {'english': 'Khulna', 'bengali': 'খুলনা'},
    {'english': 'Kishoreganj', 'bengali': 'কিশোরগঞ্জ'},
    {'english': 'Kurigram', 'bengali': 'কুড়িগ্রাম'},
    {'english': 'Kushtia', 'bengali': 'কুষ্টিয়া'},
    {'english': 'Lakshmipur', 'bengali': 'লক্ষ্মীপুর'},
    {'english': 'Lalmonirhat', 'bengali': 'লালমনিরহাট'},
    {'english': 'Madaripur', 'bengali': 'মাদারীপুর'},
    {'english': 'Magura', 'bengali': 'মাগুরা'},
    {'english': 'Manikganj', 'bengali': 'মানিকগঞ্জ'},
    {'english': 'Meherpur', 'bengali': 'মেহেরপুর'},
    {'english': 'Moulvibazar', 'bengali': 'মৌলভীবাজার'},
    {'english': 'Munshiganj', 'bengali': 'মুন্সীগঞ্জ'},
    {'english': 'Mymensingh', 'bengali': 'ময়মনসিংহ'},
    {'english': 'Naogaon', 'bengali': 'নওগাঁ'},
    {'english': 'Narail', 'bengali': 'নড়াইল'},
    {'english': 'Narayanganj', 'bengali': 'নারায়ণগঞ্জ'},
    {'english': 'Narsingdi', 'bengali': 'নরসিংদী'},
    {'english': 'Natore', 'bengali': 'নাটোর'},
    {'english': 'Netrokona', 'bengali': 'নেত্রকোণা'},
    {'english': 'Nilphamari', 'bengali': 'নীলফামারী'},
    {'english': 'Noakhali', 'bengali': 'নোয়াখালী'},
    {'english': 'Pabna', 'bengali': 'পাবনা'},
    {'english': 'Panchagarh', 'bengali': 'পঞ্চগড়'},
    {'english': 'Patuakhali', 'bengali': 'পটুয়াখালী'},
    {'english': 'Pirojpur', 'bengali': 'পিরোজপুর'},
    {'english': 'Rajbari', 'bengali': 'রাজবাড়ী'},
    {'english': 'Rajshahi', 'bengali': 'রাজশাহী'},
    {'english': 'Rangamati', 'bengali': 'রাঙ্গামাটি'},
    {'english': 'Rangpur', 'bengali': 'রংপুর'},
    {'english': 'Satkhira', 'bengali': 'সাতক্ষীরা'},
    {'english': 'Shariatpur', 'bengali': 'শরীয়তপুর'},
    {'english': 'Sherpur', 'bengali': 'শেরপুর'},
    {'english': 'Sirajganj', 'bengali': 'সিরাজগঞ্জ'},
    {'english': 'Sunamganj', 'bengali': 'সুনামগঞ্জ'},
    {'english': 'Sylhet', 'bengali': 'সিলেট'},
    {'english': 'Tangail', 'bengali': 'টাঙ্গাইল'},
    {'english': 'Thakurgaon', 'bengali': 'ঠাকুরগাঁও'},
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool isFirstTime = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(AppImages.islamic_app),
            SizedBox(height: 50),
            Text(
              'নামাযের সময় জানতে আপনার জেলা নির্বাচন করুন, আপনার অবস্থান অনুযায়ী নামাযের সময় নির্ধারণ করা হবে।',
              style: TextFontStyle.textLine12w500Kalpurush.copyWith(
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            DropdownButtonFormField<String>(
              isExpanded: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'জেলা নির্বাচন করুন',
                labelStyle: TextFontStyle.textLine12w500Kalpurush.copyWith(
                  fontSize: 18,
                ),
              ),
              value: _selectedDistrict,
              items: districts.map((district) {
                return DropdownMenuItem<String>(
                  value: district['english'],
                  child: Text(
                    district['bengali']!,
                    style: TextFontStyle.textLine12w500Kalpurush.copyWith(
                      fontSize: 18,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedDistrict = newValue;
                  _controller.text = newValue ?? '';
                  print(
                      'Selected District: $newValue'); // Print English name to console
                });
              },
            ),
            SizedBox(height: 40),
            customButton(
              name: 'সেভ করে রাখুন',
              textStyle: TextFontStyle.textLine12w500Kalpurush.copyWith(
                fontSize: 18,
                color: Colors.white,
              ),
              onCallBack: () {
                if (_selectedDistrict != null) {
                  // Find the Bengali name for the selected English district
                  final selectedBengali = districts.firstWhere((district) =>
                      district['english'] == _selectedDistrict)['bengali'];
                  // Save English and Bengali names
                  appData.write(kKeySelectedAddress, _selectedDistrict);
                  appData.write(kKeySelectedAddressBengali, selectedBengali);
                  appData.write(kKeyIsExploring, true);
                  // Log both names
                  log('Save Selected District: English: $_selectedDistrict, Bengali: $selectedBengali');
                  NavigationService.navigateTo(Routes.navigationScreen);
                }
              },
              context: context,
              color: AppColors.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
