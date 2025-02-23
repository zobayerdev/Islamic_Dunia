import 'package:flutter/material.dart';

class DefaultDatePicker extends StatefulWidget {
  @override
  _DefaultDatePickerState createState() => _DefaultDatePickerState();
}

class _DefaultDatePickerState extends State<DefaultDatePicker> {
  final TextEditingController _dateController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Set the initial date
      firstDate: DateTime(2000), // Earliest date the picker allows
      lastDate: DateTime(2100), // Latest date the picker allows
    );

    if (pickedDate != null) {
      setState(() {
        _dateController.text = "${pickedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextField(
          controller: _dateController,
          decoration: InputDecoration(
            hintText: "Enter your date",
            border: OutlineInputBorder(),
            suffixIcon: Icon(Icons.calendar_today),
          ),
          readOnly: true,
          onTap: () => _selectDate(context),
      ),
    );
  }
}