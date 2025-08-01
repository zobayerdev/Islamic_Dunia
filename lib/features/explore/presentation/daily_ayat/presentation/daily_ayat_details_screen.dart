import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:islamic_dunia/assets_helper/app_colors.dart';
import 'package:islamic_dunia/assets_helper/app_fonts.dart';
import 'package:islamic_dunia/common_widgets/custom_appbar.dart';

class DailyAyatDetailsScreen extends StatefulWidget {
  final String title, description, imageURL, reference;
  const DailyAyatDetailsScreen({
    super.key,
    required this.title,
    required this.description,
    required this.imageURL,
    required this.reference,
  });

  @override
  State<DailyAyatDetailsScreen> createState() => _DailyAyatDetailsScreenState();
}

class _DailyAyatDetailsScreenState extends State<DailyAyatDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    log("DailyAyatDetailsScreen: ${widget.title}, ${widget.description}, ${widget.imageURL}, ${widget.reference}");

    return Scaffold(
      appBar: CustomAppBar(
        title: "আয়াত বিস্তারিত",
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.cDCE4E6.withOpacity(0.9),
        ),
        child: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(
              20,
            ),
            child: Column(
              children: [
                // * Image Screen
                SizedBox(
                  width: double.infinity,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 1,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          20), // Matches container's borderRadius
                      child: Image.network(
                        "https://islamicduniya.zobayerdev.top/" +
                            widget.imageURL,
                        width: double.infinity,
                        fit: BoxFit
                            .cover, // Ensures image fills the container without distortion
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(
                              child: CircularProgressIndicator());
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                              child: Text('Error loading image'));
                        },
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.grey.shade300,
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: TextFontStyle.textLine12w500Kalpurush.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          widget.description,
                          style: TextFontStyle.textLine12w500Kalpurush.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          widget.reference,
                          style: TextFontStyle.textLine12w500Kalpurush.copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
