import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:outage/api/intruptions/esdapi.dart';
import 'package:outage/component/custdialog.dart';
import 'package:outage/component/dropdown_sqlite.dart';
import 'package:outage/model/feeder.dart';
import 'package:outage/model/intruption/esd_model.dart';
import 'package:outage/model/login/logreqmod.dart';
import 'package:outage/model/login/user.dart';
import 'package:outage/utils/constants.dart';

class EsdScreen extends StatefulWidget {
  final Users usr;
  final Feeder fdr;
  const EsdScreen({Key? key, required this.usr, required this.fdr})
      : super(key: key);

  @override
  _EsdscreenState createState() => _EsdscreenState();
}

class _EsdscreenState extends State<EsdScreen> {
  int getConfirm = 0;
  Feeder _selFdr = Feeder.initFeeder();
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

  int getHrsMin(String date, int mode) {
    int min = 0;
    int hrs = 0;
    if (mode == 1) //  1 - For Minute and 2- for  Hrs
    {
      date = date.replaceAll("AM", "").replaceAll("PM", "");
      var hrsList = date.split(":");
      min = int.parse(hrsList[1]);

      return min;
    } else if (mode == 2) {
      if (date.contains("PM")) {
        var hrsList = date.split(":");
        hrs = int.parse(hrsList[0]) + 12;
        if (hrs == 24) {
          hrs = 12;
        }
        return hrs;
      } else {
        var hrsList = date.split(":");
        hrs = int.parse(hrsList[0]);
        if (hrs == 12) {
          hrs = 0;
        }
        return hrs;
      }
    }
    return hrs;
  }

  @override
  void dispose() {
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

  @override
  void initState() {
    super.initState();
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding:
                      EdgeInsets.only(top: 15, left: 15, bottom: 5, right: 5),
                  child: Text(
                    "ESD Entry",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 15, left: 15, bottom: 5, right: 15),
                  child: Container(
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
                ),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 0, left: 20, bottom: 6, right: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
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
                        height: 5,
                      ),
                      Text(
                        "${widget.usr.usr_locname}, ${widget.usr.usr_loccode}",
                        style: const TextStyle(
                            color: Color.fromARGB(255, 119, 186, 241),
                            fontSize: 12,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 15, top: 1, bottom: 1, right: 15),
              child: DropDownSQLite(
                adm_sdn_code: widget.usr.usr_loccode,
                feeder_name: _selFdr.FeederName,
                // suggList: suggList, //suggList,
                OnSelect: ((fdr) {
                  // selectedFeeder = fdrtxt;
                  // selectedFeederCode = fdrcode;
                  // widget.OnSelect(fdr);
                  setState(() {
                    _selFdr = fdr;
                  });
                  //print(Selected_value);
                }),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Category: ${_selFdr.FeederCategory}",
                                      style: const TextStyle(
                                        color: Colors.red,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
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
                                if (_selFdr.FeederCode <= 0) {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return CustDialog(
                                            Dlg_title: "Information",
                                            msg: "Select Feeder First",
                                            fdr: _selFdr,
                                            usr: widget.usr,
                                            isConfirmDialog: false,
                                            onClose: (val) {},
                                            res_code: 101);
                                      });
                                } else if (_startdate.text.isEmpty ||
                                    _enddate.text.isEmpty ||
                                    _starttime.text.isEmpty ||
                                    _endtime.text.isEmpty ||
                                    _reasonController.text.isEmpty ||
                                    _actiontknController.text.isEmpty ||
                                    _lcbyController.text.isEmpty) {
                                  // _showDialog(
                                  //     context, "All data are required", -2);
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return CustDialog(
                                            isConfirmDialog: false,
                                            Dlg_title: "Information",
                                            msg: "All data are required",
                                            onClose: (val) {},
                                            res_code: 101);
                                      });
                                } else if (duration <= 0) {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return CustDialog(
                                            Dlg_title: "Information",
                                            isConfirmDialog: false,
                                            msg:
                                                "End date and End Time must grater than Start date and Start time",
                                            onClose: (val) {},
                                            res_code: 101);
                                      });
                                } else {
                                  ESD esd = ESD(
                                      //esd_id: 0,
                                      APIKEY: saveESD_APIKEY,
                                      USRCODE: widget.usr.usr_id,
                                      entry_type: 'ESD',
                                      FEEDERCD: _selFdr.FeederCode,
                                      FEEDERCATEGORY: _selFdr.FeederCategory,
                                      FEEDERNM: _selFdr.FeederName,
                                      ESDDATE: DateFormat("dd-MM-yyyy")
                                          .parse(_startdate.text),
                                      ESDENDDATE: DateFormat("dd-MM-yyyy")
                                          .parse(_enddate.text),
                                      ESDFROMHH: getHrsMin(_starttime.text, 2)
                                          .toString(),
                                      // ESDFROMHH: getHrsMin(_starttime.text, 2),
                                      ESDFROMMM: getHrsMin(_starttime.text, 1)
                                          .toString(),
                                      ESDTOHH: getHrsMin(_endtime.text, 2)
                                          .toString(),
                                      ESDTOMM: getHrsMin(_endtime.text, 1)
                                          .toString(),
                                      ESDDURATIONHH: (duration / 60).floor(),
                                      ESDDURATIONMM: (duration % 60),
                                      // esd_cons_affected: widget.fdr.fdr_cons,
                                      ESDREASON: _reasonController.text,
                                      ESDCORRECTACTION:
                                          _actiontknController.text,
                                      ESDLCTAKENBY: _lcbyController.text,
                                      ENTRYDATE: DateTime.now(),
                                      IPIMEI: widget.usr.IPIMEI);

                                  CircularProgressIndicator(
                                      backgroundColor: Colors.blue.shade800,
                                      color: Colors.white);

                                  await showDialog(
                                      context: context,
                                      builder: (context) {
                                        return CustDialog(
                                            Dlg_title: "Confirmation",
                                            isConfirmDialog: true,
                                            msg:
                                                "Are you sure you want to Save ESD entry, After confirmation you cannot delete Entry",
                                            fdr: _selFdr,
                                            usr: widget.usr,
                                            onClose: (val) {
                                              setState(() {
                                                getConfirm = val;
                                              });
                                            },
                                            res_code: 102);
                                      });
                                  if (getConfirm == 1) {
                                    LoginResponse result =
                                        await ESDAPI.entryESD(esd);
                                    // ignore: use_build_context_synchronously
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return CustDialog(
                                              Dlg_title: "Information",
                                              isConfirmDialog: false,
                                              msg: result.Status_message,
                                              fdr: _selFdr,
                                              usr: widget.usr,
                                              onClose: (val) {},
                                              res_code: result.Status);
                                        });
                                  }

                                  // _showDialog(context, result.Status_message,
                                  //     result.Status);
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
  }
}
