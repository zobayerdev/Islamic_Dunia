import 'package:flutter/material.dart';
import 'package:islamic_dunia/assets_helper/app_lottie.dart';
import 'package:islamic_dunia/common_widgets/custom_appbar.dart';
import 'package:islamic_dunia/features/explore/presentation/tashbih/tashbih_history_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:ripple_wave/ripple_wave.dart';
import 'package:vibration/vibration.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class TasbihHomePage extends StatefulWidget {
  @override
  _TasbihHomePageState createState() => _TasbihHomePageState();
}

class _TasbihHomePageState extends State<TasbihHomePage> {
  int _counter = 0;
  String _selectedDhikr = 'আলহামদুলিল্লাহ';
  String _vibrationMode = 'Normal';

  final List<String> _dhikrOptions = [
    'আলহামদুলিল্লাহ',
    'সুবহানাল্লাহ',
    'আস্তাগফিরুল্লাহ',
    'লা ইলাহা ইল্লাল্লাহ'
  ];

  final List<String> _vibrationModes = ['Normal', 'Medium', 'High'];

  // Helper function to convert English digits to Bangla digits
  String _toBanglaDigits(String input) {
    const englishDigits = '0123456789';
    const banglaDigits = '০১২৩৪৫৬৭৮৯';
    return input.split('').map((char) {
      int index = englishDigits.indexOf(char);
      return index != -1 ? banglaDigits[index] : char;
    }).join('');
  }

  @override
  void initState() {
    super.initState();
  }

  void _incrementCounter() async {
    setState(() {
      _counter++;
    });
    await _triggerVibration();
  }

  Future<void> _triggerVibration() async {
    if (await Vibration.hasVibrator() ?? false) {
      int duration;
      switch (_vibrationMode) {
        case 'Medium':
          duration = 100;
          break;
        case 'High':
          duration = 200;
          break;
        default:
          duration = 50; // Normal
      }
      Vibration.vibrate(duration: duration);
    }
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  void _saveToHistory() async {
    if (_counter > 0) {
      final now = DateTime.now();
      final dateFormat = DateFormat('dd-MM-yyyy');
      final timeFormat = DateFormat('h:mm a');
      final formattedDate = _toBanglaDigits(dateFormat.format(now));
      final formattedTime = _toBanglaDigits(timeFormat.format(now));
      final formattedDateTime = '$formattedDate';
      final entry = {
        'dhikr': _selectedDhikr,
        'count': _counter,
        'dateTime': formattedDateTime,
        'jikirtime': formattedTime,
      };

      final prefs = await SharedPreferences.getInstance();
      List<Map<String, dynamic>> history = [];
      final historyString = prefs.getString('tasbih_history');
      if (historyString != null) {
        history = List<Map<String, dynamic>>.from(jsonDecode(historyString));
      }
      history.insert(0, entry);

      setState(() {
        _counter = 0;
      });

      await prefs.setString('tasbih_history', jsonEncode(history));
    }
  }

  void _navigateToHistory() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TasbihHistoryPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'ডিজিটাল তাসবিহ',
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFDCE4E6).withOpacity(0.9),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Dhikr Selection
              DropdownButtonFormField<String>(
                value: _selectedDhikr,
                decoration: InputDecoration(
                  labelText: 'নির্বাচন করুন',
                  labelStyle: TextStyle(fontSize: 18, fontFamily: 'Kalpurush'),
                  border: OutlineInputBorder(),
                ),
                items: _dhikrOptions.map((String dhikr) {
                  return DropdownMenuItem<String>(
                    value: dhikr,
                    child: Text(
                      dhikr,
                      style: TextStyle(fontSize: 18, fontFamily: 'Kalpurush'),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedDhikr = newValue!;
                  });
                },
              ),
              SizedBox(height: 16),
              // Vibration Mode Selection
              DropdownButtonFormField<String>(
                value: _vibrationMode,
                decoration: InputDecoration(
                  labelText: 'ভাইব্রেশন মোড',
                  labelStyle: TextStyle(fontSize: 18, fontFamily: 'Kalpurush'),
                  border: OutlineInputBorder(),
                ),
                items: _vibrationModes.map((String mode) {
                  return DropdownMenuItem<String>(
                    value: mode,
                    child: Text(
                      mode,
                      style: TextStyle(fontSize: 16, fontFamily: 'Poppins'),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _vibrationMode = newValue!;
                  });
                },
              ),
              SizedBox(height: 16),
              // Counter Display
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'Kalpurush',
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(text: 'আপনি '),
                    TextSpan(
                      text:
                          '$_selectedDhikr ${_toBanglaDigits(_counter.toString())}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: ' পড়েছেন বার'),
                  ],
                ),
              ),
              SizedBox(height: 90),
              GestureDetector(
                onTap: _incrementCounter,
                child: Padding(
                  padding: const EdgeInsets.all(45.0),
                  child: RippleWave(
                    color: Colors.green,
                    repeat: true,
                    child: Lottie.asset(
                      AppLottie.handTap,
                      width: 100,
                      height: 100,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 90),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: _resetCounter,
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(150, 50),
                      textStyle: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Kalpurush',
                        color: Colors.white,
                      ),
                    ),
                    child: Text('রিসেট'),
                  ),
                  ElevatedButton(
                    onPressed: _saveToHistory,
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(150, 50),
                      textStyle: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Kalpurush',
                        color: Colors.white,
                      ),
                    ),
                    child: Text('সেভ'),
                  ),
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _navigateToHistory,
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(150, 50),
                  textStyle: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Kalpurush',
                    color: Colors.white,
                  ),
                ),
                child: Text('হিস্টোরি দেখুন'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
