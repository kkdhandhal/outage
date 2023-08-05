import 'package:flutter/material.dart';
import '../component/dropdown.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[800],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Hi, Mr. Krushna Dhandhal",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "JP, Surendranagar Town 1 S/Dn",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.purple[200],
                        ),
                      )
                    ],
                  ),
                  Container(
                    child: Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              SizedBox(height: 20),
              // Container(
              //   decoration: BoxDecoration(
              //       color: Colors.purple[600],
              //       borderRadius: BorderRadius.circular(12)),
              //   padding: EdgeInsets.all(12),
              //   child: Row(
              //     children: [
              //       Icon(
              //         Icons.search,
              //         color: Colors.white,
              //       ),
              //       SizedBox(
              //         width: 20,
              //       ),
              DropDownSearch(
                PrimaryColor: Color.fromARGB(255, 142, 36, 170),
                SecondaryColor: Color.fromARGB(255, 142, 36, 170),
                FontColor: Colors.white,
                autoCompleteList: const [
                  "Feeder1",
                  "Feeder2",
                  "XYZFEEDER",
                  "ABCFeeder",
                  "Feeder1",
                  "Feeder2",
                  "XYZFEEDER",
                  "ABCFeeder",
                  "Feeder1",
                  "Feeder2",
                  "XYZFEEDER",
                  "ABCFeeder",
                  "Feeder1",
                  "Feeder2",
                  "XYZFEEDER",
                  "ABCFeeder",
                  "Feeder1",
                  "Feeder2",
                  "XYZFEEDER",
                  "ABCFeeder",
                  "Feeder1",
                  "Feeder2",
                  "XYZFEEDER",
                  "ABCFeeder",
                  "Feeder1",
                  "Feeder2",
                  "XYZFEEDER",
                  "ABCFeeder",
                  "Feeder1",
                  "Feeder2",
                  "XYZFEEDER",
                  "ABCFeeder",
                  "Feeder1",
                  "Feeder2",
                  "XYZFEEDER",
                  "ABCFeeder",
                  "Feeder1",
                  "Feeder2",
                  "XYZFEEDER",
                  "ABCFeeder",
                  "Feeder1",
                  "Feeder2",
                  "XYZFEEDER",
                  "ABCFeeder",
                ],
              ),
              // Expanded(
              //   child: TextFormField(
              //     initialValue: null,
              //     decoration: InputDecoration.collapsed(
              //       hintText: "Select Feeder",
              //       hintStyle: TextStyle(color: Colors.white),
              //       filled: true,
              //       fillColor: Colors.purple[600],
              //       hoverColor: Colors.purple[600],
              //     ),
              //     style: TextStyle(
              //       height: 1.5,
              //       color: Colors.white,
              //       fontSize: 14,
              //       fontWeight: FontWeight.bold,
              //     ),
              //     onFieldSubmitted: (value) {},
              //   ),
              // ),
              // ],
              //),
              //)
            ],
          ),
        ),
      ),
    );
  }
}
