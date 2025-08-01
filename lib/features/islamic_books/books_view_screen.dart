// ignore_for_file: depend_on_referenced_packages
import 'dart:io';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:islamic_dunia/assets_helper/app_lottie.dart';
import 'package:islamic_dunia/common_widgets/custom_appbar.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';

class PDFViewScreen extends StatefulWidget {
  final String pdfURL;
  const PDFViewScreen({
    super.key,
    required this.pdfURL,
  });

  @override
  State<PDFViewScreen> createState() => _PDFViewScreenState();
}

class _PDFViewScreenState extends State<PDFViewScreen> {
  String localPath = "";

  @override
  void initState() {
    super.initState();
    downloadPdf();
  }

  Future<void> downloadPdf() async {
    try {
      // Get the application's document directory
      final directory = await getApplicationDocumentsDirectory();
      final filePath =
          '${directory.path}/downloaded.pdf'; // Local path to store the PDF

      // Send HTTP GET request to download the PDF
      final response = await http.get(Uri.parse(
          'https://islamicduniya.zobayerdev.top/' + "/" + widget.pdfURL));

      if (response.statusCode == 200) {
        // Write the PDF bytes to a file
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        setState(() {
          localPath = filePath; // Set the local file path
        });
      } else {
        log('Failed to load PDF');
      }
    } catch (e) {
      log('Error loading PDF: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    log("========================> PDF URL: ${'https://islamicduniya.zobayerdev.top/' + widget.pdfURL}");
    return Scaffold(
      appBar: CustomAppBar(
        title: 'বিস্তারিত দেখুন',
        isCenterd: true,
        leadingIconUnVisible: false,
      ),
      body: localPath.isEmpty
          ? Center(
              child: Lottie.asset(
                AppLottie.whiteLottie,
              ),
            )
          : PDFView(
              filePath: localPath,
              enableSwipe: true,
              swipeHorizontal: false,
              autoSpacing: false,
              pageFling: false,
              defaultPage: 0,
              backgroundColor: Colors.grey.shade100,
            ),
    );
  }
}
