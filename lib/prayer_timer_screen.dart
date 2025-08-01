import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

class PrayerTimer extends StatefulWidget {
  final String? apiUrl;
  final String city;
  final String country;
  final String date;
  final int method;
  final double progressBarSize;
  final Color progressBarColor;
  final Color progressBarBackgroundColor;
  final Color fontColor;
  final String? fontName;
  final String? containerHeight;

  const PrayerTimer({
    Key? key,
    this.apiUrl,
    required this.city,
    required this.country,
    this.method = 2,
    this.progressBarSize = 200.0,
    this.progressBarColor = Colors.green,
    this.progressBarBackgroundColor = Colors.grey,
    this.fontColor = Colors.black,
    this.fontName,
    this.containerHeight,
    required this.date,
  }) : super(key: key);

  @override
  _PrayerTimerState createState() => _PrayerTimerState();
}

class _PrayerTimerState extends State<PrayerTimer> {
  List<PrayerTime> prayerTimes = [];
  PrayerTime? currentPrayer;
  Duration? remainingTime;
  Duration? totalDuration;
  Timer? timer;
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    loadPrayerTimes();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (prayerTimes.isNotEmpty) {
          updateCurrentPrayer();
        }
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future<void> loadPrayerTimes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedPrayerTimes = prefs.getString(
      'prayer_times_${widget.city}_${widget.country}_${widget.date}',
    );

    if (savedPrayerTimes != null) {
      List<dynamic> decoded = jsonDecode(savedPrayerTimes);
      prayerTimes = decoded.map((e) => PrayerTime.fromJson(e)).toList();
      setState(() {
        isLoading = false;
        updateCurrentPrayer();
      });
    } else {
      await fetchPrayerTimesFromApi();
    }
  }

  Future<void> fetchPrayerTimesFromApi() async {
    try {
      final url = widget.apiUrl ??
          'https://api.aladhan.com/v1/timingsByAddress/${widget.date}?address=${widget.city},${widget.country}&method=1,';
      //'https://api.aladhan.com/v1/timingsByCity?city=${widget.city}&country=${widget.country}&method=${widget.method}';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data']['timings'];
        prayerTimes = [
          PrayerTime(
            name: 'ফজর',
            startTime: parseTime(data['Fajr']),
            endTime: parseTime(data['Dhuhr']),
          ),
          PrayerTime(
            name: 'যোহর',
            startTime: parseTime(data['Dhuhr']),
            endTime: parseTime(data['Asr']),
          ),
          PrayerTime(
            name: 'আসর',
            startTime: parseTime(data['Asr']),
            endTime: parseTime(data['Maghrib']),
          ),
          PrayerTime(
            name: 'মাগরিব',
            startTime: parseTime(data['Maghrib']),
            endTime: parseTime(data['Isha']),
          ),
          PrayerTime(
            name: 'এশা',
            startTime: parseTime(data['Isha']),
            endTime: parseTime(data['Fajr'], nextDay: true),
          ),
        ];

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString(
          'prayer_times_${widget.city}_${widget.country}',
          jsonEncode(prayerTimes.map((e) => e.toJson()).toList()),
        );

        setState(() {
          isLoading = false;
          updateCurrentPrayer();
        });
      } else {
        setState(() {
          isLoading = false;
          hasError = true;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        hasError = true;
      });
    }
  }

  TimeOfDay parseTime(String time, {bool nextDay = false}) {
    final parts = time.split(':');
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1]);
    return TimeOfDay(hour: hour, minute: minute);
  }

  void updateCurrentPrayer() {
    if (prayerTimes.isEmpty) return;

    final now = DateTime.now();
    final currentTime = TimeOfDay(hour: now.hour, minute: now.minute);

    for (var prayer in prayerTimes) {
      if (isTimeInRange(currentTime, prayer.startTime, prayer.endTime)) {
        currentPrayer = prayer;
        remainingTime = timeDifference(now, prayer.endTime);
        totalDuration = timeDifference(prayer.startTime, prayer.endTime);
        break;
      }
    }
  }

  bool isTimeInRange(TimeOfDay current, TimeOfDay start, TimeOfDay end) {
    final now = current.hour * 60 + current.minute;
    final startMinutes = start.hour * 60 + start.minute;
    var endMinutes = end.hour * 60 + end.minute;

    if (endMinutes < startMinutes) {
      endMinutes += 24 * 60;
    }

    return now >= startMinutes && now < endMinutes;
  }

  Duration timeDifference(dynamic start, TimeOfDay end) {
    final now = DateTime.now();
    var startDateTime = start is DateTime
        ? start
        : DateTime(now.year, now.month, now.day, start.hour, start.minute);
    var endDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      end.hour,
      end.minute,
    );

    if (end.hour * 60 + end.minute <
        startDateTime.hour * 60 + startDateTime.minute) {
      endDateTime = endDateTime.add(Duration(days: 1));
    }

    return endDateTime.difference(startDateTime);
  }

  TextStyle _getFontStyle(
    double fontSize, {
    FontWeight fontWeight = FontWeight.normal,
  }) {
    final fontName = widget.fontName ?? 'Noto Sans Bengali';
    return GoogleFonts.getFont(
      fontName,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: widget.fontColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (hasError || prayerTimes.isEmpty || currentPrayer == null) {
      return Center(
        child: Text(
          'কোনো ডাটা পাওয়া যায়নি। দয়া করে ইন্টারনেট সংযোগ পরীক্ষা করুন।',
          style: _getFontStyle(18),
          textAlign: TextAlign.center,
        ),
      );
    }

    final progress =
        (remainingTime!.inSeconds / totalDuration!.inSeconds).clamp(0.0, 1.0);

    return Container(
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
            style: _getFontStyle(20, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Left: Progress Indicator
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
                          backgroundColor: widget.progressBarBackgroundColor,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            widget.progressBarColor,
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            currentPrayer!.name,
                            style: _getFontStyle(
                              28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${remainingTime!.inHours.toString().padLeft(2, '0')}:${(remainingTime!.inMinutes % 60).toString().padLeft(2, '0')}:${(remainingTime!.inSeconds % 60).toString().padLeft(2, '0')}',
                            style: _getFontStyle(
                              20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(width: 20), // Space between columns
              // * Right: Prayer Info
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '📿 পরবর্তী নামাজ: ${getNextPrayer().name}',
                      style: _getFontStyle(16, fontWeight: FontWeight.w600),
                    ),
                    // Text(
                    //   'শুরু: ${currentPrayer!.startTime.format(context)}',
                    //   style: _getFontStyle(18, fontWeight: FontWeight.w600),
                    // ),
                    Text(
                      '⏱️ ${getNextPrayer().name} শুরুর সময়: ${currentPrayer!.endTime.format(context)}',
                      style: _getFontStyle(16, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  PrayerTime getNextPrayer() {
    final currentIndex = prayerTimes.indexOf(currentPrayer!);
    return prayerTimes[(currentIndex + 1) % prayerTimes.length];
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

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'startTime': {'hour': startTime.hour, 'minute': startTime.minute},
      'endTime': {'hour': endTime.hour, 'minute': endTime.minute},
    };
  }

  factory PrayerTime.fromJson(Map<String, dynamic> json) {
    return PrayerTime(
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
}
