import 'package:flutter/material.dart';
import 'package:islamic_dunia/assets_helper/app_colors.dart';
import 'package:islamic_dunia/assets_helper/app_fonts.dart';
import 'package:islamic_dunia/assets_helper/app_images.dart';
import 'package:islamic_dunia/common_widgets/custom_appbar.dart';
import 'package:islamic_dunia/features/explore/presentation/daily_ayat/model/daily_ayat_model.dart';
import 'package:islamic_dunia/helpers/all_routes.dart';
import 'package:islamic_dunia/helpers/navigation_service.dart';
import 'package:islamic_dunia/networks/api_acess.dart';

class DailyAyatScreen extends StatefulWidget {
  const DailyAyatScreen({super.key});

  @override
  State<DailyAyatScreen> createState() => _DailyAyatScreenState();
}

class _DailyAyatScreenState extends State<DailyAyatScreen> {
  @override
  void initState() {
    super.initState();
    getDailyAyatAPIRX.dailyAyatAPI();
  }

  // স্ট্যাটিক ডেটা লিস্ট (১০টি আইটেম)
  final List<Map<String, String>> ayatData = List.generate(
    10,
    (index) => {
      'title': 'আয়াত টাইটেল ${index + 1}',
      'reference': 'রেফারেন্স ${index + 1}',
      'description':
          'আয়াতের বিস্তারিত বর্ণনা রয়েছে, সম্পূর্ণ পড়তে ক্লিক করুন।',
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "দৈনিক আয়াত",
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
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: AssetImage(AppImages.suraCard),
                          fit: BoxFit.contain,
                          // colorFilter: ColorFilter.mode(
                          //   AppColors.primaryColor.withOpacity(0.9),
                          //   BlendMode.darken,
                          // ),
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'আজকের আয়াত',
                              style: TextFontStyle.textLine12w500Kalpurush
                                  .copyWith(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      )),
                  StreamBuilder<DailyAyatModel>(
                      stream: getDailyAyatAPIRX.horseissue,
                      builder: (context, snapshot) {
                        var ayatsData = snapshot.data?.dailyAyats ?? [];

                        return ListView.builder(
                          shrinkWrap:
                              true, // লিস্টভিউর সাইজ কন্টেন্টের উপর নির্ভর করবে
                          physics:
                              const NeverScrollableScrollPhysics(), // স্ক্রলিং নিষ্ক্রিয়
                          itemCount: ayatsData.length, // ১০টি আইটেম
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                NavigationService.navigateToWithArgs(
                                    Routes.dailyAyatDetailsScreen, {
                                  'title': ayatsData[index].title,
                                  'description': ayatsData[index].description,
                                  'imageURL': ayatsData[index].imagePath,
                                  'reference': ayatsData[index].reference,
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 16), // আইটেমের মধ্যে ব্যবধান
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                        ),
                                        child: Container(
                                          width: 100,
                                          height: 100,
                                          decoration: const BoxDecoration(
                                            color:
                                                Colors.grey, // প্লেসহোল্ডার রঙ
                                          ),
                                          child: Image.network(
                                            'https://islamicduniya.zobayerdev.top/${ayatsData[index].imagePath!}',
                                            width: 100,
                                            fit: BoxFit
                                                .cover, // ইমেজ পুরো স্থান পূরণ করবে
                                            loadingBuilder: (context, child,
                                                loadingProgress) {
                                              if (loadingProgress == null)
                                                return child;
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            },
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return const Center(
                                                child: Icon(
                                                  Icons.error,
                                                  color: Colors.red,
                                                  size: 40,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                ayatsData[index].title!,
                                                style: TextFontStyle
                                                    .textLine12w500Kalpurush
                                                    .copyWith(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              Row(
                                                children: [
                                                  Text(
                                                    ayatsData[index].reference!,
                                                    style: TextFontStyle
                                                        .textLine12w500Kalpurush
                                                        .copyWith(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 5),
                                              Text(
                                                ayatData[index]['description']!,
                                                style: TextFontStyle
                                                    .textLine12w500Kalpurush
                                                    .copyWith(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                maxLines: null,
                                                softWrap: true,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
