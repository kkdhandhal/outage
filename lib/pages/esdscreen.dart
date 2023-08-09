import 'package:flutter/material.dart';

class Esdscreen extends StatefulWidget {
  const Esdscreen({Key? key}) : super(key: key);

  @override
  _EsdscreenState createState() => _EsdscreenState();
}

class _EsdscreenState extends State<Esdscreen> {
  DateTime? _selectedStartDate;
  TimeOfDay? _selectedStartTime;
  TextEditingController _startdatetime = TextEditingController();

  void _showDatetimePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2023),
            lastDate: DateTime(2024))
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedStartDate = pickedDate;
      });
    });
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(DateTime.now()),
    ).then((pickedTime) {
      if (pickedTime == null) {
        return;
      }
      setState(() {
        _selectedStartTime = pickedTime;
        _startdatetime.text = "$_selectedStartDate - $_selectedStartTime";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextFormField(
            controller: _startdatetime,
            decoration: InputDecoration(
              hintText: "Select Start Date and Time",
              suffixIcon: Icon(
                Icons.calendar_month,
              ),
            ),
            onTap: () {
              _showDatetimePicker();
            },
          ),
        ],
      ),
    );
  }
}
