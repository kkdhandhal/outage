import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:outage/api/intruptions/esdapi.dart';
import 'package:outage/model/api_gen_res.dart';

import 'package:outage/model/intruption/esd_model.dart';
import 'package:outage/pages/ESD/esdtabview.dart';
import 'package:outage/pages/Home.dart';
// import 'package:realm/realm.dart';

import '../../model/feeder.dart';
import '../../model/login/user.dart';

class EsdScreen extends StatefulWidget {
  final Users usr;
  final Feeder fdr;
  const EsdScreen({Key? key, required this.usr, required this.fdr})
      : super(key: key);

  @override
  _EsdscreenState createState() => _EsdscreenState();
}

class _EsdscreenState extends State<EsdScreen> {
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
  TextEditingController _actiontknController = TextEditingController();
  TextEditingController _lcbyController = TextEditingController();

  //APIError? result;
  Future<void> _showDialog(
      BuildContext context, final String dbmsg, int dbcode) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: dbcode < 0
                ? Text("Error - $dbcode")
                : Text("Information - $dbcode"),
            content: Text(dbmsg),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('OK'),
                onPressed: () {
                  if (dbcode == -1 || dbcode == -2 || dbcode == -3) {
                    Navigator.of(context).pop();
                  } else {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                HomePage(fdr: widget.fdr, usr: widget.usr)),
                        (route) => false);
                  }
                },
              ),
            ],
          );
        });
  }

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

      int tmp_duration = _enddate.difference(_stdate).inMinutes;
      print(
          "Start Date:$_stdate \n End Date:$_enddate \n duration:$tmp_duration\n");
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
    return Scaffold(
      backgroundColor: Colors.blue[800],
      // appBar: AppBar(
      //   title: const Text("IT Application"),
      //   backgroundColor: Colors.deepPurple,
      //   elevation: 0,
      // ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(top: 10, left: 8, bottom: 5, right: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.usr.usr_name} ",
                          //"${widget.usr.usr_nameinit} ${widget.usr.usr_firstname} ${widget.usr.usr_lastname}",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          "JP, Surendranagar Circle ${widget.usr.usr_loccode}",
                          style: const TextStyle(
                              color: Color.fromARGB(255, 119, 186, 241),
                              fontSize: 12,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.blue[600],
                        borderRadius: BorderRadius.circular(10)),
                    child: IconButton(
                      iconSize: 25,
                      icon: const Icon(
                        Icons.cancel,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(12),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32))),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Feeder Name: ${widget.fdr.FeederName}",
                                      style: const TextStyle(
                                        color: Colors.red,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Feeder Code: ${widget.fdr.FeederCode}",
                                      style: const TextStyle(
                                        color: Colors.red,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Category: ${widget.fdr.FeederCategory}",
                                      style: const TextStyle(
                                        color: Colors.red,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "ESD Duration: $duration min",
                                      style: const TextStyle(
                                        color: Colors.red,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Consumers: ${widget.fdr.fdr_cons}",
                                      style: const TextStyle(
                                        color: Colors.red,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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
                                      icon: Icon(Icons
                                          .calendar_today), //icon of text field
                                      labelText:
                                          "Enter Start Date", //label text of field
                                    ),
                                    readOnly:
                                        true, // when true user cannot edit text
                                    onTap: () async {
                                      //when click we have to show the datepicker
                                      DateTime? pickedDate =
                                          await showDatePicker(
                                              context: context,
                                              initialDate: DateTime
                                                  .now(), //get today's date
                                              firstDate: DateTime(
                                                  2000), //DateTime.now() - not to allow to choose before today.
                                              lastDate: DateTime(2101));
                                      if (pickedDate != null) {
                                        print(
                                            pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000

                                        String formattedDate =
                                            DateFormat('dd-MM-yyyy').format(
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
                                        if (kDebugMode) {
                                          print("Date is not selected");
                                        }
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
                                        icon: Icon(
                                            Icons.timer), //icon of text field
                                        labelText:
                                            "Start Time" //label text of field
                                        ),
                                    readOnly:
                                        true, // when true user cannot edit text
                                    onTap: () async {
                                      //when click we have to show the datepicker
                                      TimeOfDay? pickedTime =
                                          await showTimePicker(
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
                                        icon: Icon(Icons
                                            .calendar_today), //icon of text field
                                        labelText:
                                            "Enter End Date" //label text of field
                                        ),
                                    readOnly:
                                        true, // when true user cannot edit text
                                    onTap: () async {
                                      //when click we have to show the datepicker
                                      DateTime? pickedDate =
                                          await showDatePicker(
                                              context: context,
                                              initialDate:
                                                  _selectedStartDate, //get today's date
                                              firstDate:
                                                  _selectedStartDate, //DateTime(
                                              //d2000), //DateTime.now() - not to allow to choose before today.
                                              lastDate: DateTime(
                                                  _selectedStartDate.year + 1));
                                      if (pickedDate != null) {
                                        print(
                                            pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000

                                        String formattedDate =
                                            DateFormat('dd-MM-yyyy').format(
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
                                        icon: Icon(
                                            Icons.timer), //icon of text field
                                        labelText:
                                            "End Time" //label text of field
                                        ),
                                    readOnly:
                                        true, // when true user cannot edit text
                                    onTap: () async {
                                      //when click we have to show the datepicker
                                      TimeOfDay? pickedTime =
                                          await showTimePicker(
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
                                    icon: Icon(Icons
                                        .edit_document), //icon of text field
                                    labelText:
                                        "Enter Reason" //label text of field
                                    ),
                                // when true user cannot edit text
                                onTap: () {}),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.90,
                            child: TextField(
                                controller:
                                    _actiontknController, //editing controller of this TextField
                                decoration: const InputDecoration(
                                    icon: Icon(Icons
                                        .edit_document), //icon of text field
                                    labelText:
                                        "Action Taken" //label text of field
                                    ),
                                // when true user cannot edit text
                                onTap: () {}),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.90,
                            child: TextField(
                                controller:
                                    _lcbyController, //editing controller of this TextField
                                decoration: const InputDecoration(
                                    icon: Icon(Icons
                                        .edit_document), //icon of text field
                                    labelText:
                                        "LC Taken By " //label text of field
                                    ),
                                // when true user cannot edit text
                                onTap: () {}),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.90,
                            padding: const EdgeInsets.only(left: 20, top: 30),
                            child: ElevatedButton(
                              child: const Text("Submit"),
                              onPressed: () async {
                                if (_startdate.text.isEmpty ||
                                    _enddate.text.isEmpty ||
                                    _starttime.text.isEmpty ||
                                    _endtime.text.isEmpty ||
                                    _reasonController.text.isEmpty ||
                                    _actiontknController.text.isEmpty ||
                                    _lcbyController.text.isEmpty) {
                                  _showDialog(
                                      context, "All data are required", -2);
                                } else if (duration <= 0) {
                                  _showDialog(
                                      context,
                                      "End date and End Time must grater than Start date and Start time",
                                      -3);
                                } else {
                                  ESD esd = ESD(
                                      //esd_id: 0,
                                      API_KEY: "",
                                      USRCODE: widget.usr.usr_id,
                                      entry_type: 'ESD',
                                      FEEDERCD: widget.fdr.FeederCode,
                                      FEEDERCATEGORY: widget.fdr.FeederCategory,
                                      FEEDERNM: widget.fdr.FeederName,
                                      ESDDATE: DateFormat("dd-MM-yyyy")
                                          .parse(_startdate.text),
                                      ESDENDDATE: DateFormat("dd-MM-yyyy")
                                          .parse(_enddate.text),
                                      ESDFROMHH: _starttime.text,
                                      ESDFROMMM: _starttime.text,
                                      ESDTOHH: _endtime.text,
                                      ESDTOMM: _endtime.text,
                                      ESDDURATIONHH: duration,
                                      ESDDURATIONMM: duration,
                                      // esd_cons_affected: widget.fdr.fdr_cons,
                                      ESDREASON: _reasonController.text,
                                      ESDCORRECTACTION:
                                          _actiontknController.text,
                                      ESDLCTAKENBY: _lcbyController.text,
                                      ENTRYDATE: DateTime.now(),
                                      IPIMEI: widget.usr.usr_name);

                                  CircularProgressIndicator(
                                      backgroundColor: Colors.blue.shade800,
                                      color: Colors.white);
                                  APIResult result = await ESDAPI.entryESD(esd);
                                  _showDialog(context, result.db_msg,
                                      result.db_code as int);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    // return Scaffold(
    //   body: SingleChildScrollView(
    //     scrollDirection: Axis.vertical,
    //     child: Column(
    //       children: [
    //         Padding(
    //           padding: const EdgeInsets.all(10.0),
    //           child: SizedBox(
    //               width: MediaQuery.of(context).size.width,
    //               child: Text(
    //                 " ESD Duration is $duration hours and affect 0 Consumers",
    //                 style: const TextStyle(
    //                   color: Colors.red,
    //                   fontSize: 15,
    //                   fontWeight: FontWeight.bold,
    //                 ),
    //               )),
    //         ),
    //         Column(
    //           mainAxisAlignment: MainAxisAlignment.start,
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           mainAxisSize: MainAxisSize.max,
    //           children: [
    //             const SizedBox(height: 15),
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.start,
    //               mainAxisSize: MainAxisSize.max,
    //               children: [
    //                 SizedBox(
    //                   height: textboxHeight,
    //                   width: MediaQuery.of(context).size.width * 0.55,
    //                   child: TextField(
    //                       controller:
    //                           _startdate, //editing controller of this TextField
    //                       decoration: const InputDecoration(
    //                         icon:
    //                             Icon(Icons.calendar_today), //icon of text field
    //                         labelText: "Enter Start Date", //label text of field
    //                       ),
    //                       readOnly: true, // when true user cannot edit text
    //                       onTap: () async {
    //                         //when click we have to show the datepicker
    //                         DateTime? pickedDate = await showDatePicker(
    //                             context: context,
    //                             initialDate: DateTime.now(), //get today's date
    //                             firstDate: DateTime(
    //                                 2000), //DateTime.now() - not to allow to choose before today.
    //                             lastDate: DateTime(2101));
    //                         if (pickedDate != null) {
    //                           print(
    //                               pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000

    //                           String formattedDate = DateFormat('dd-MM-yyyy')
    //                               .format(
    //                                   pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
    //                           print(
    //                               formattedDate); //formatted date output using intl package =>  2022-07-04
    //                           //You can format date as per your need

    //                           setState(() {
    //                             _startdate.text =
    //                                 formattedDate; //set foratted date to TextField value.
    //                             _selectedStartDate = pickedDate;
    //                             _durationCalculate();
    //                           });
    //                         } else {
    //                           print("Date is not selected");
    //                         }
    //                       }),
    //                 ),
    //                 SizedBox(
    //                   height: textboxHeight,
    //                   width: MediaQuery.of(context).size.width * 0.35,
    //                   child: TextField(
    //                       controller:
    //                           _starttime, //editing controller of this TextField
    //                       decoration: const InputDecoration(
    //                           icon: Icon(Icons.timer), //icon of text field
    //                           labelText: "Start Time" //label text of field
    //                           ),
    //                       readOnly: true, // when true user cannot edit text
    //                       onTap: () async {
    //                         //when click we have to show the datepicker
    //                         TimeOfDay? pickedTime = await showTimePicker(
    //                           context: context,
    //                           initialTime: TimeOfDay.fromDateTime(
    //                               DateTime.now()), //get today's date
    //                           // firstDate: DateTime(
    //                           //     2000), //DateTime.now() - not to allow to choose before today.
    //                           // lastDate: DateTime(2101)
    //                         );
    //                         if (pickedTime != null) {
    //                           print(
    //                               pickedTime); //get the picked date in the format => 2022-07-04 00:00:00.000

    //                           // String formattedDate = TimeOfDayFormat.HH_colon_mm. ('hh:mm').format(
    //                           //     pickedTime); // format date in required form here we use yyyy-MM-dd that means time is removed
    //                           print(
    //                               pickedTime); //formatted date output using intl package =>  2022-07-04
    //                           //You can format date as per your need

    //                           setState(() {
    //                             _starttime.text = pickedTime.format(
    //                                 context); //set foratted date to TextField value.
    //                             _selectedStartTime = pickedTime;
    //                             _durationCalculate();
    //                           });
    //                         } else {
    //                           print("Date is not selected");
    //                         }
    //                       }),
    //                 ),
    //               ],
    //             ),
    //             const SizedBox(height: 5),
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.start,
    //               mainAxisSize: MainAxisSize.max,
    //               children: [
    //                 SizedBox(
    //                   height: textboxHeight,
    //                   width: MediaQuery.of(context).size.width * 0.55,
    //                   child: TextField(
    //                       controller:
    //                           _enddate, //editing controller of this TextField
    //                       decoration: const InputDecoration(
    //                           icon: Icon(
    //                               Icons.calendar_today), //icon of text field
    //                           labelText: "Enter End Date" //label text of field
    //                           ),
    //                       readOnly: true, // when true user cannot edit text
    //                       onTap: () async {
    //                         //when click we have to show the datepicker
    //                         DateTime? pickedDate = await showDatePicker(
    //                             context: context,
    //                             initialDate:
    //                                 _selectedStartDate, //get today's date
    //                             firstDate: _selectedStartDate, //DateTime(
    //                             //d2000), //DateTime.now() - not to allow to choose before today.
    //                             lastDate:
    //                                 DateTime(_selectedStartDate.year + 1));
    //                         if (pickedDate != null) {
    //                           print(
    //                               pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000

    //                           String formattedDate = DateFormat('dd-MM-yyyy')
    //                               .format(
    //                                   pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
    //                           print(
    //                               formattedDate); //formatted date output using intl package =>  2022-07-04
    //                           //You can format date as per your need

    //                           setState(() {
    //                             _enddate.text =
    //                                 formattedDate; //set foratted date to TextField value.
    //                             _selectedEndDate = pickedDate;
    //                             _durationCalculate();
    //                           });
    //                         } else {
    //                           print("Date is not selected");
    //                         }
    //                       }),
    //                 ),
    //                 SizedBox(
    //                   height: textboxHeight,
    //                   width: MediaQuery.of(context).size.width * 0.35,
    //                   child: TextField(
    //                       controller:
    //                           _endtime, //editing controller of this TextField
    //                       decoration: const InputDecoration(
    //                           icon: Icon(Icons.timer), //icon of text field
    //                           labelText: "End Time" //label text of field
    //                           ),
    //                       readOnly: true, // when true user cannot edit text
    //                       onTap: () async {
    //                         //when click we have to show the datepicker
    //                         TimeOfDay? pickedTime = await showTimePicker(
    //                           context: context,
    //                           initialTime:
    //                               _selectedStartTime, //TimeOfDay.fromDateTime(

    //                           //DateTime.now()), //get today's date
    //                           // firstDate: DateTime(
    //                           //     2000), //DateTime.now() - not to allow to choose before today.
    //                           // lastDate: DateTime(2101)
    //                         );
    //                         if (pickedTime != null) {
    //                           print(
    //                               pickedTime); //get the picked date in the format => 2022-07-04 00:00:00.000

    //                           // String formattedDate = TimeOfDayFormat.HH_colon_mm. ('hh:mm').format(
    //                           //     pickedTime); // format date in required form here we use yyyy-MM-dd that means time is removed
    //                           print(
    //                               pickedTime); //formatted date output using intl package =>  2022-07-04
    //                           //You can format date as per your need

    //                           setState(() {
    //                             _endtime.text = pickedTime.format(
    //                                 context); //set foratted date to TextField value.
    //                             _selectedEndTime = pickedTime;
    //                             _durationCalculate();
    //                           });
    //                         } else {
    //                           print("Date is not selected");
    //                         }
    //                       }),
    //                 ),
    //               ],
    //             ),
    //             SizedBox(
    //               height: textboxHeight,
    //               width: MediaQuery.of(context).size.width * 0.90,
    //               child: TextField(
    //                   controller:
    //                       _reasonController, //editing controller of this TextField
    //                   decoration: const InputDecoration(
    //                       icon: Icon(Icons.edit_document), //icon of text field
    //                       labelText: "Enter Reason" //label text of field
    //                       ),
    //                   // when true user cannot edit text
    //                   onTap: () {}),
    //             ),
    //             SizedBox(
    //               width: MediaQuery.of(context).size.width * 0.90,
    //               child: TextField(
    //                   controller:
    //                       _actiontknController, //editing controller of this TextField
    //                   decoration: const InputDecoration(
    //                       icon: Icon(Icons.edit_document), //icon of text field
    //                       labelText: "Action Taken" //label text of field
    //                       ),
    //                   // when true user cannot edit text
    //                   onTap: () {}),
    //             ),
    //             SizedBox(
    //               width: MediaQuery.of(context).size.width * 0.90,
    //               child: TextField(
    //                   controller:
    //                       _lcbyController, //editing controller of this TextField
    //                   decoration: const InputDecoration(
    //                       icon: Icon(Icons.edit_document), //icon of text field
    //                       labelText: "LC Taken By " //label text of field
    //                       ),
    //                   // when true user cannot edit text
    //                   onTap: () {}),
    //             ),
    //             Container(
    //               width: MediaQuery.of(context).size.width * 0.90,
    //               padding: const EdgeInsets.only(left: 20, top: 30),
    //               child: ElevatedButton(
    //                 child: Text("Submit"),
    //                 onPressed: () {},
    //               ),
    //             ),
    //           ],
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
