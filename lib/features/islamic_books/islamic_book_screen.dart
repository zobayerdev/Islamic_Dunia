import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:islamic_dunia/assets_helper/app_colors.dart';
import 'package:islamic_dunia/assets_helper/app_fonts.dart';
import 'package:islamic_dunia/assets_helper/app_icons.dart';
import 'package:islamic_dunia/assets_helper/app_lottie.dart';
import 'package:islamic_dunia/features/islamic_books/model/books_model.dart';
import 'package:islamic_dunia/helpers/all_routes.dart';
import 'package:islamic_dunia/helpers/navigation_service.dart';
import 'package:islamic_dunia/networks/api_acess.dart';
import 'package:lottie/lottie.dart';

class IslamicBook extends StatefulWidget {
  const IslamicBook({super.key});

  @override
  State<IslamicBook> createState() => _IslamicBookState();
}

class _IslamicBookState extends State<IslamicBook> {
  @override
  void initState() {
    super.initState();
    getBookRX.bookAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.cDCE4E6.withOpacity(0.9),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    'ইসলামিক বইসমূহ',
                    style: TextFontStyle.textLine12w500Kalpurush.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  StreamBuilder<BookModel>(
                    stream: getBookRX.dataFetcher,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting ||
                          !snapshot.hasData) {
                        return Center(
                          child: Lottie.asset(
                            AppLottie.whiteLottie,
                            height: 250,
                            width: 250,
                          ),
                        );
                      }
                      var books = snapshot.data?.islamicBooks ?? [];

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: books.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              NavigationService.navigateToWithArgs(
                                Routes.pdfViewScreen,
                                {'pdfURL': books[index].filePath ?? ''},
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    blurRadius: 5,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SvgPicture.asset(
                                        AppIcons.book,
                                        height: 40,
                                        width: 40,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            books[index].title ?? 'No Title',
                                            style: TextFontStyle
                                                .textLine12w500Kalpurush
                                                .copyWith(
                                              fontSize: 18,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            books[index].description ??
                                                'No Author',
                                            style: TextFontStyle
                                                .textLine12w500Kalpurush
                                                .copyWith(
                                              fontSize: 12,
                                              color: AppColors.c3D4040,
                                            ),
                                            maxLines: 10,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: true,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
