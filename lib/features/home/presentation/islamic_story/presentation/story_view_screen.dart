// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:islamic_dunia/assets_helper/app_colors.dart';
import 'package:islamic_dunia/assets_helper/app_fonts.dart';
import 'package:islamic_dunia/common_widgets/custom_appbar.dart';
import 'package:islamic_dunia/features/home/presentation/islamic_story/model/story_model.dart';
import 'package:islamic_dunia/networks/api_acess.dart';

class IslamicStoryViewScreen extends StatefulWidget {
  final String? title, reference, description;
  const IslamicStoryViewScreen(
      {super.key, this.title, this.reference, this.description});

  @override
  State<IslamicStoryViewScreen> createState() => _IslamicStoryViewScreenState();
}

class _IslamicStoryViewScreenState extends State<IslamicStoryViewScreen> {
  @override
  void initState() {
    super.initState();
    getStoryRX.storyAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.title ?? 'ইসলামিক গল্প ও কাহিনীসমূহ',
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
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  StreamBuilder<StoryModel>(
                    stream: getStoryRX.dataFetcher,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting ||
                          !snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      var stories = snapshot.data?.islamicStory ?? [];

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: stories.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            // onTap: () {
                            //   NavigationService.navigateToWithArgs(
                            //     Routes.pdfViewScreen,
                            //     {'pdfURL': stories[index].filePath ?? ''},
                            //   );
                            // },
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
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            widget.title ?? 'No Title',
                                            style: TextFontStyle
                                                .textLine12w500Kalpurush
                                                .copyWith(
                                              fontSize: 18,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            widget.description ??
                                                'No Description',
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
                                          const SizedBox(height: 4),
                                          Text(
                                            "রেফারেন্সঃ- " +
                                                (widget.reference ??
                                                    'No Reference'),
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
