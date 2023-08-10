import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

class Esdscreen extends StatefulWidget {
  const Esdscreen({Key? key}) : super(key: key);

  @override
  _EsdscreenState createState() => _EsdscreenState();
}

class _EsdscreenState extends State<Esdscreen> {
  DateTime _selectedStartDate = DateTime.now();
  TimeOfDay _selectedStartTime = TimeOfDay.now();
  DateTime? _selectedEndDate;
  TimeOfDay? _selectedEndTime;
  int duration = 0;
  TextEditingController _startdate = TextEditingController();
  TextEditingController _starttime = TextEditingController();
  TextEditingController _enddate = TextEditingController();
  TextEditingController _endtime = TextEditingController();

  TextEditingController _reasonController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    //importFeeder();

    super.dispose();
  }

  void _durationCalculate() {
    if (_selectedEndDate != null && _selectedEndTime != null) {
      DateTime _enddate = DateTime(
        _selectedEndDate!.year,
        _selectedEndDate!.month,
        _selectedEndDate!.day,
        _selectedEndTime!.hour,
        _selectedEndTime!.minute,
      );
      DateTime _stdate = DateTime(
        _selectedStartDate.year,
        _selectedStartDate.month,
        _selectedStartDate.day,
        _selectedStartTime.hour,
        _selectedStartTime.minute,
      );

      int tmp_duration = _enddate.difference(_stdate).inHours;
      setState(() {
        duration = tmp_duration;
      });
    }
  }

  double textboxHeight = 55;
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
        _startdate.text = "$_selectedStartDate - $_selectedStartTime";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  " ESD Duration is $duration hours and affect 0 Consumers",
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                )),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: textboxHeight,
                    width: MediaQuery.of(context).size.width * 0.55,
                    child: TextField(
                        controller:
                            _startdate, //editing controller of this TextField
                        decoration: const InputDecoration(
                          icon: Icon(Icons.calendar_today), //icon of text field
                          labelText: "Enter Start Date", //label text of field
                        ),
                        readOnly: true, // when true user cannot edit text
                        onTap: () async {
                          //when click we have to show the datepicker
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(), //get today's date
                              firstDate: DateTime(
                                  2000), //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2101));
                          if (pickedDate != null) {
                            print(
                                pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000

                            String formattedDate = DateFormat('dd-MM-yyyy').format(
                                pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                            print(
                                formattedDate); //formatted date output using intl package =>  2022-07-04
                            //You can format date as per your need

                            setState(() {
                              _startdate.text =
                                  formattedDate; //set foratted date to TextField value.
                              _selectedStartDate = pickedDate;
                              _durationCalculate();
                            });
                          } else {
                            print("Date is not selected");
                          }
                        }),
                  ),
                  SizedBox(
                    height: textboxHeight,
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: TextField(
                        controller:
                            _starttime, //editing controller of this TextField
                        decoration: const InputDecoration(
                            icon: Icon(Icons.timer), //icon of text field
                            labelText: "Start Time" //label text of field
                            ),
                        readOnly: true, // when true user cannot edit text
                        onTap: () async {
                          //when click we have to show the datepicker
                          TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(
                                DateTime.now()), //get today's date
                            // firstDate: DateTime(
                            //     2000), //DateTime.now() - not to allow to choose before today.
                            // lastDate: DateTime(2101)
                          );
                          if (pickedTime != null) {
                            print(
                                pickedTime); //get the picked date in the format => 2022-07-04 00:00:00.000

                            // String formattedDate = TimeOfDayFormat.HH_colon_mm. ('hh:mm').format(
                            //     pickedTime); // format date in required form here we use yyyy-MM-dd that means time is removed
                            print(
                                pickedTime); //formatted date output using intl package =>  2022-07-04
                            //You can format date as per your need

                            setState(() {
                              _starttime.text = pickedTime.format(
                                  context); //set foratted date to TextField value.
                              _selectedStartTime = pickedTime;
                              _durationCalculate();
                            });
                          } else {
                            print("Date is not selected");
                          }
                        }),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: textboxHeight,
                    width: MediaQuery.of(context).size.width * 0.55,
                    child: TextField(
                        controller:
                            _enddate, //editing controller of this TextField
                        decoration: const InputDecoration(
                            icon:
                                Icon(Icons.calendar_today), //icon of text field
                            labelText: "Enter End Date" //label text of field
                            ),
                        readOnly: true, // when true user cannot edit text
                        onTap: () async {
                          //when click we have to show the datepicker
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate:
                                  _selectedStartDate, //get today's date
                              firstDate: _selectedStartDate, //DateTime(
                              //d2000), //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(_selectedStartDate.year + 1));
                          if (pickedDate != null) {
                            print(
                                pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000

                            String formattedDate = DateFormat('dd-MM-yyyy').format(
                                pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                            print(
                                formattedDate); //formatted date output using intl package =>  2022-07-04
                            //You can format date as per your need

                            setState(() {
                              _enddate.text =
                                  formattedDate; //set foratted date to TextField value.
                              _selectedEndDate = pickedDate;
                              _durationCalculate();
                            });
                          } else {
                            print("Date is not selected");
                          }
                        }),
                  ),
                  SizedBox(
                    height: textboxHeight,
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: TextField(
                        controller:
                            _endtime, //editing controller of this TextField
                        decoration: const InputDecoration(
                            icon: Icon(Icons.timer), //icon of text field
                            labelText: "End Time" //label text of field
                            ),
                        readOnly: true, // when true user cannot edit text
                        onTap: () async {
                          //when click we have to show the datepicker
                          TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime:
                                _selectedStartTime, //TimeOfDay.fromDateTime(

                            //DateTime.now()), //get today's date
                            // firstDate: DateTime(
                            //     2000), //DateTime.now() - not to allow to choose before today.
                            // lastDate: DateTime(2101)
                          );
                          if (pickedTime != null) {
                            print(
                                pickedTime); //get the picked date in the format => 2022-07-04 00:00:00.000

                            // String formattedDate = TimeOfDayFormat.HH_colon_mm. ('hh:mm').format(
                            //     pickedTime); // format date in required form here we use yyyy-MM-dd that means time is removed
                            print(
                                pickedTime); //formatted date output using intl package =>  2022-07-04
                            //You can format date as per your need

                            setState(() {
                              _endtime.text = pickedTime.format(
                                  context); //set foratted date to TextField value.
                              _selectedEndTime = pickedTime;
                              _durationCalculate();
                            });
                          } else {
                            print("Date is not selected");
                          }
                        }),
                  ),
                ],
              ),
              SizedBox(
                height: textboxHeight,
                width: MediaQuery.of(context).size.width * 0.90,
                child: TextField(
                    controller:
                        _reasonController, //editing controller of this TextField
                    decoration: const InputDecoration(
                        icon: Icon(Icons.edit_document), //icon of text field
                        labelText: "Enter Reason" //label text of field
                        ),
                    // when true user cannot edit text
                    onTap: () {}),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.90,
                child: TextField(
                    controller:
                        _reasonController, //editing controller of this TextField
                    decoration: const InputDecoration(
                        icon: Icon(Icons.edit_document), //icon of text field
                        labelText: "Action Taken" //label text of field
                        ),
                    // when true user cannot edit text
                    onTap: () {}),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.90,
                child: TextField(
                    controller:
                        _reasonController, //editing controller of this TextField
                    decoration: const InputDecoration(
                        icon: Icon(Icons.edit_document), //icon of text field
                        labelText: "LC Taken By " //label text of field
                        ),
                    // when true user cannot edit text
                    onTap: () {}),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.90,
                padding: const EdgeInsets.only(left: 20, top: 30),
                child: ElevatedButton(
                  child: Text("Submit"),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
