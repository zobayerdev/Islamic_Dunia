// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:islamic_dunia/assets_helper/app_fonts.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

class PrayerTimer extends StatefulWidget {
  final Map<String, String>? prayerTimesInput;
  final double progressBarSize;
  final Color progressBarColor;
  final Color progressBarBackgroundColor;
  final Color fontColor;
  final String? fontName;
  final String? containerHeight;

  const PrayerTimer({
    Key? key,
    this.prayerTimesInput,
    this.progressBarSize = 200.0,
    this.progressBarColor = Colors.green,
    this.progressBarBackgroundColor = Colors.grey,
    this.fontColor = Colors.black,
    this.fontName,
    this.containerHeight,
  }) : super(key: key);

  @override
  _PrayerTimerState createState() => _PrayerTimerState();
}

class _PrayerTimerState extends State<PrayerTimer> {
  List<PrayerTime> prayerTimes = [];
  PrayerTime? currentPrayer;
  DateTime? endDateTime;
  Duration? totalDuration;
  Timer? timer;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    loadPrayerTimes();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted && endDateTime != null) {
        final now = DateTime.now();
        final remaining = endDateTime!.difference(now);
        if (remaining.inSeconds <= 0) {
          updateCurrentPrayer();
        } else {
          setState(() {}); // Trigger rebuild for live countdown
        }
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future<void> loadPrayerTimes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    const String cacheKey = 'prayer_times';
    print('Checking cache for key: $cacheKey');
    String? savedPrayerTimes = prefs.getString(cacheKey);

    if (savedPrayerTimes != null) {
      print('Cache hit. Loading cached prayer times.');
      try {
        List<dynamic> decoded = jsonDecode(savedPrayerTimes);
        prayerTimes = decoded.map((e) => PrayerTime.fromJson(e)).toList();
        setState(() {
          isLoading = false;
          updateCurrentPrayer();
        });
      } catch (e) {
        print('Error parsing cached data: $e');
        loadInputPrayerTimes();
      }
    } else {
      print('Cache miss. Loading input prayer times.');
      loadInputPrayerTimes();
    }
  }

  Future<void> loadInputPrayerTimes() async {
    if (widget.prayerTimesInput == null || widget.prayerTimesInput!.isEmpty) {
      print('No input prayer times provided.');
      setState(() {
        isLoading = false;
        errorMessage = 'কোনো নামাযের সময় প্রদান করা হয়নি।';
      });
      return;
    }

    try {
      final times = widget.prayerTimesInput!;
      print('Input prayer times: $times');

      TimeOfDay fajrTime = parseTime(times['Fajr']!);
      TimeOfDay dhuhrTime = parseTime(times['Dhuhr']!);
      TimeOfDay asrTime = parseTime(times['Asr']!);
      TimeOfDay maghribTime = parseTime(times['Maghrib']!);
      TimeOfDay ishaTime = parseTime(times['Isha']!);

      prayerTimes = [
        PrayerTime(name: 'এশা', startTime: ishaTime, endTime: fajrTime),
        PrayerTime(name: 'ফজর', startTime: fajrTime, endTime: dhuhrTime),
        PrayerTime(name: 'যোহর', startTime: dhuhrTime, endTime: asrTime),
        PrayerTime(name: 'আসর', startTime: asrTime, endTime: maghribTime),
        PrayerTime(name: 'মাগরিব', startTime: maghribTime, endTime: ishaTime),
      ];

      SharedPreferences prefs = await SharedPreferences.getInstance();
      // await prefs.setString(
      //   cacheKey,
      //   jsonEncode(prayerTimes.map((e) => e.toJson()).toList()),
      // );
      // print('Cached prayer times for key: $cacheKey');
      // print(
      //     'Loaded prayer times: ${prayerTimes.map((e) => '${e.name}: ${e.startTime.format(context)} - ${e.endTime.format(context)}').toList()}');

      setState(() {
        isLoading = false;
        errorMessage = null;
        updateCurrentPrayer();
      });
    } catch (e) {
      print('Error loading input prayer times: $e');
      setState(() {
        isLoading = false;
        errorMessage = 'ইনপুট সময় পার্স করতে ত্রুটি: $e';
      });
    }
  }

  Future<void> clearCache() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    print('Cache cleared.');
    setState(() {
      isLoading = true;
      prayerTimes = [];
      currentPrayer = null;
      errorMessage = null;
    });
    loadPrayerTimes();
  }

  TimeOfDay parseTime(String time) {
    try {
      final format = DateFormat('HH:mm');
      final dateTime = format.parse(time.trim());
      print('Parsed time: $time -> ${dateTime.hour}:${dateTime.minute}');
      return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
    } catch (e) {
      print('Time parsing error: $e');
      try {
        final format = DateFormat('hh:mm a');
        final dateTime = format.parse(time.trim());
        print(
            'Parsed AM/PM time: $time -> ${dateTime.hour}:${dateTime.minute}');
        return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
      } catch (e) {
        print('AM/PM parsing error: $e');
        throw FormatException('Invalid time format: $time');
      }
    }
  }

  void updateCurrentPrayer() {
    if (prayerTimes.isEmpty) {
      print('No prayer times available.');
      setState(() {
        errorMessage = 'কোনো নামাযের সময় পাওয়া যায়নি।';
      });
      return;
    }

    final now = DateTime.now();
    final currentTime = TimeOfDay(hour: now.hour, minute: now.minute);
    print('Current time: ${currentTime.hour}:${currentTime.minute}');

    currentPrayer = null;
    for (var prayer in prayerTimes) {
      if (isTimeInRange(currentTime, prayer.startTime, prayer.endTime)) {
        currentPrayer = prayer;
        break;
      }
    }

    if (currentPrayer == null) {
      print('No prayer time matches current time. Defaulting to Isha.');
      currentPrayer = prayerTimes.firstWhere((p) => p.name == 'এশা');
    }

    endDateTime = convertToDateTime(currentPrayer!.endTime);
    totalDuration =
        endDateTime!.difference(convertToDateTime(currentPrayer!.startTime));
    setState(() {});
  }

  DateTime convertToDateTime(TimeOfDay time) {
    final now = DateTime.now();
    var dateTime =
        DateTime(now.year, now.month, now.day, time.hour, time.minute);

    if (currentPrayer?.name == 'এশা' && time == currentPrayer!.endTime) {
      if (time.hour * 60 + time.minute <= now.hour * 60 + now.minute) {
        dateTime = dateTime.add(Duration(days: 1));
      }
    } else if (currentPrayer?.name == 'এশা' &&
        time == currentPrayer!.startTime) {
      if (now.hour * 60 + now.minute < time.hour * 60 + time.minute) {
        dateTime = dateTime.subtract(Duration(days: 1));
      }
    }

    print('Converted time: ${time.format(context)} -> $dateTime');
    return dateTime;
  }

  bool isTimeInRange(TimeOfDay current, TimeOfDay start, TimeOfDay end) {
    final now = current.hour * 60 + current.minute;
    final startMin = start.hour * 60 + start.minute;
    var endMin = end.hour * 60 + end.minute;

    if (endMin <= startMin) {
      endMin += 24 * 60;
    }

    var adjustedNow = now;
    if (now < startMin && endMin > 24 * 60) {
      adjustedNow += 24 * 60;
    }

    print('Checking time range: $adjustedNow between $startMin and $endMin');
    return adjustedNow >= startMin && adjustedNow < endMin;
  }

  TextStyle _getFontStyle(double fontSize,
      {FontWeight fontWeight = FontWeight.normal}) {
    final fontName = widget.fontName ?? 'Roboto';
    try {
      return GoogleFonts.getFont(
        fontName,
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: widget.fontColor,
      );
    } catch (e) {
      print('Font error: $e. Using default font.');
      return TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: widget.fontColor,
      );
    }
  }

  PrayerTime getNextPrayer() {
    final currentIndex = prayerTimes.indexOf(currentPrayer!);
    return prayerTimes[(currentIndex + 1) % prayerTimes.length];
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    final now = DateTime.now();
    final remaining =
        endDateTime != null ? endDateTime!.difference(now) : Duration.zero;
    final progress = remaining.inSeconds > 0
        ? (remaining.inSeconds / totalDuration!.inSeconds).clamp(0.0, 1.0)
        : 0.0;

    return Column(
      children: [
        if (errorMessage != null ||
            prayerTimes.isEmpty ||
            currentPrayer == null)
          Center(
            child: Text(
              errorMessage ??
                  'কোনো ডাটা পাওয়া যায়নি। দয়া করে সময়গুলো সঠিকভাবে প্রদান করুন।',
              style: _getFontStyle(18),
              textAlign: TextAlign.center,
            ),
          )
        else
          Container(
            width: double.infinity,
            height: widget.containerHeight != null
                ? double.tryParse(widget.containerHeight!)
                : 250,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'বর্তমান ${currentPrayer!.name} এর নামাযের সময় চলছে',
                  style: TextFontStyle.textLine12w500Kalpurush.copyWith(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              width: widget.progressBarSize,
                              height: widget.progressBarSize,
                              child: CircularProgressIndicator(
                                value: progress,
                                strokeWidth: 10,
                                backgroundColor: widget
                                    .progressBarBackgroundColor
                                    .withOpacity(0.3),
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    widget.progressBarColor),
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  "সময়",
                                  style: TextFontStyle.textLine12w500Kalpurush
                                      .copyWith(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  '${remaining.inHours.toString().padLeft(2, '0')}:${(remaining.inMinutes % 60).toString().padLeft(2, '0')}:${(remaining.inSeconds % 60).toString().padLeft(2, '0')}',
                                  style: TextFontStyle.textLine12w500Kalpurush
                                      .copyWith(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "বাকি",
                                  style: TextFontStyle.textLine12w500Kalpurush
                                      .copyWith(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '📿 পরবর্তী নামাজ: ${getNextPrayer().name}',
                            style:
                                TextFontStyle.textLine12w500Kalpurush.copyWith(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '⏱️ ওয়াক্ত শুরু: ${currentPrayer!.endTime.format(context)}',
                            style:
                                TextFontStyle.textLine12w500Kalpurush.copyWith(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class PrayerTime {
  final String name;
  final TimeOfDay startTime;
  final TimeOfDay endTime;

  PrayerTime({
    required this.name,
    required this.startTime,
    required this.endTime,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'startTime': {'hour': startTime.hour, 'minute': startTime.minute},
        'endTime': {'hour': endTime.hour, 'minute': endTime.minute},
      };

  factory PrayerTime.fromJson(Map<String, dynamic> json) => PrayerTime(
        name: json['name'],
        startTime: TimeOfDay(
          hour: json['startTime']['hour'],
          minute: json['startTime']['minute'],
        ),
        endTime: TimeOfDay(
          hour: json['endTime']['hour'],
          minute: json['endTime']['minute'],
        ),
      );
}
