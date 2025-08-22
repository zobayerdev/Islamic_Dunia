import 'package:flutter/material.dart';
import 'package:islamic_dunia/common_widgets/custom_appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class TasbihHistoryPage extends StatefulWidget {
  @override
  _TasbihHistoryPageState createState() => _TasbihHistoryPageState();
}

class _TasbihHistoryPageState extends State<TasbihHistoryPage> {
  List<Map<String, dynamic>> _history = [];

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
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final historyString = prefs.getString('tasbih_history');
    if (historyString != null) {
      setState(() {
        _history = List<Map<String, dynamic>>.from(jsonDecode(historyString));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'তাসবিহ ইতিহাস',
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFDCE4E6).withOpacity(0.9),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: _history.isEmpty
              ? Center(
                  child: Text(
                    'কোনো হিস্টোরি নেই',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Kalpurush',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: _history.length,
                  itemBuilder: (context, index) {
                    final entry = _history[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${entry['dhikr']} - ${_toBanglaDigits(entry['count'].toString())} বার',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Kalpurush',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'তারিখঃ- ${entry['dateTime']}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Kalpurush',
                                    ),
                                  ),
                                  Text(
                                    'সময়ঃ- ${entry['jikirtime']}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Kalpurush',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
