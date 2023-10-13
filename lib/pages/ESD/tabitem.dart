import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:outage/model/feeder.dart';
import 'package:outage/model/intruption/esd_model.dart';

class TabItem extends StatelessWidget {
  const TabItem({super.key, required this.tmpEsd, required this.feeder});
  final List<ESDList> tmpEsd;
  final Feeder feeder;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: feeder.FeederCode > 0
              ? Text("Total ${tmpEsd.length} ESD entry in current month")
              : const Text(""),
        ),
        Expanded(
          child: ListView.separated(
              itemCount: tmpEsd.length,
              separatorBuilder: ((context, index) {
                return const Divider(
                  height: 3.0,
                );
              }),
              itemBuilder: (BuildContext context, index) {
                return Container(
                  decoration: BoxDecoration(
                    // color: Colors.blue.shade400,
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(188, 30, 145, 240),
                        Color.fromARGB(255, 11, 140, 204)
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),

                    // color: Color.fromARGB(255, 14, 96, 151),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    leading:
                        const Icon(Icons.receipt_long, color: Colors.white),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Text(
                              "${tmpEsd[index].FeederCode}  -- ${tmpEsd[index].FeederName.characters.take(15).toString()}",
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 94, 9, 173),
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: [
                            Text(
                              DateFormat("dd-MM-yyyy hh:mm a")
                                  .format(tmpEsd[index].ESDFrom),
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),
                            const Text(
                              " To ",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                            Text(
                              DateFormat("dd-MM-yyyy hh:mm a")
                                  .format(tmpEsd[index].ESDTo),
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Icon(
                              Icons.people_alt,
                              size: 20,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              tmpEsd[index].ConsumersAffected.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(
                              width: 40,
                            ),
                            const Icon(
                              Icons.mail_rounded,
                              size: 20,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              tmpEsd[index].TotalSMSSent.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(
                              width: 40,
                            ),
                            const Icon(
                              Icons.timer,
                              size: 20,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "${(tmpEsd[index].ESDTo.difference(tmpEsd[index].ESDFrom).inMinutes / 60).floor().toString()}:${(tmpEsd[index].ESDTo.difference(tmpEsd[index].ESDFrom).inMinutes % 60).toString()}",
                              //      ESDDURATIONHH: (duration / 60).floor(),
                              // ESDDURATIONMM: (duration % 60),
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        // Row(
                        //   children: [
                        //     Text(
                        //       "Total SMS Sent. : ${tmpEsd[index].TotalSMSSent.toString()}",
                        //       style: const TextStyle(
                        //         color: Colors.white,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
