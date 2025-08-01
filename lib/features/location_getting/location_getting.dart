import 'package:flutter/material.dart';
import 'package:islamic_dunia/common_widgets/custom_appbar.dart';

class LocationGettingScreen extends StatefulWidget {
  const LocationGettingScreen({super.key});

  @override
  State<LocationGettingScreen> createState() => _LocationGettingScreenState();
}

class _LocationGettingScreenState extends State<LocationGettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'লোকেশন আপডেট',
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFDCE4E6).withOpacity(0.9),
        ),
        child: Padding(
          padding: EdgeInsets.all(
            20,
          ),
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
