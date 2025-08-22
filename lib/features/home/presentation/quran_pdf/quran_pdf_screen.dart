import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:islamic_dunia/assets_helper/app_colors.dart';
import 'package:islamic_dunia/assets_helper/app_fonts.dart';
import 'package:islamic_dunia/assets_helper/app_lottie.dart';
import 'package:islamic_dunia/common_widgets/custom_appbar.dart';
import 'package:lottie/lottie.dart';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class QuranPDFScreen extends StatefulWidget {
  const QuranPDFScreen({super.key});

  @override
  State<QuranPDFScreen> createState() => _QuranPDFScreenState();
}

class _QuranPDFScreenState extends State<QuranPDFScreen> {
  late String filePath;
  int currentPage = 0; // Track the current page number

  @override
  void initState() {
    super.initState();
    filePath = "";
    loadAssetPDF();
    loadPageNumber();
  }

  // Load the PDF from assets and save it to the temporary directory
  Future<void> loadAssetPDF() async {
    // Load the PDF from assets
    final ByteData data = await rootBundle.load('assets/pdf/quran.pdf');
    final buffer = data.buffer.asUint8List();

    // Get the app's temporary directory
    final tempDir = await getTemporaryDirectory();

    // Create the subdirectory (if it doesn't exist)
    final pdfDir = Directory('${tempDir.path}/pdf');
    if (!await pdfDir.exists()) {
      await pdfDir.create(recursive: true);
    }

    // Write the PDF file to the temp directory
    final tempFile = File('${pdfDir.path}/quran.pdf');
    await tempFile.writeAsBytes(buffer);

    // Set the filePath to the temporary file path
    setState(() {
      filePath = tempFile.path;
    });
  }

  // Load saved page number from SharedPreferences
  Future<void> loadPageNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int savedPage = prefs.getInt('currentPage') ?? 0; // Default to page 0
    setState(() {
      currentPage = savedPage;
    });
  }

  // Save current page number to SharedPreferences
  Future<void> savePageNumber(int page) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('currentPage', page); // Save the current page number
  }

  // Update the page number whenever the page changes
  void onPageChanged(int page, int total) {
    setState(() {
      currentPage =
          page + 1; // Page is zero-indexed, so add 1 to make it 1-based
    });
    savePageNumber(currentPage); // Save the page number when it changes
    print("Current page: $currentPage of $total pages");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cDCE4E6.withOpacity(0.9),
      appBar: CustomAppBar(
        title: "আল কোরআন",
      ),
      body: filePath.isEmpty
          ? Center(
              child: Lottie.asset(
                AppLottie.whiteLottie,
                height: 350,
                width: 350,
              ),
            )
          : Column(
              children: [
                Expanded(
                    child: PDFScreen(
                        filePath: filePath,
                        onPageChanged: onPageChanged,
                        initialPage: currentPage)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'পৃষ্ঠা নংঃ- $currentPage',
                    style: TextFontStyle.textLine12w500Kalpurush.copyWith(
                      fontSize: 18,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class PDFScreen extends StatelessWidget {
  final String filePath;
  final Function(int, int) onPageChanged;
  final int initialPage;

  PDFScreen(
      {required this.filePath,
      required this.onPageChanged,
      required this.initialPage});

  @override
  Widget build(BuildContext context) {
    return PDFView(
      filePath: filePath,
      enableSwipe: true,
      swipeHorizontal: true,
      autoSpacing: true,
      pageFling: true,
      pageSnap: true,
      onPageChanged: (int? page, int? total) {
        if (page != null && total != null) {
          onPageChanged(page, total);
        }
      },
      onError: (error) {
        print(error);
      },
      onPageError: (page, error) {
        print("Page $page error: $error");
      },
      defaultPage: initialPage - 1,
    );
  }
}
