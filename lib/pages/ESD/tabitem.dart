import 'package:flutter/material.dart';
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
                    color: Colors.blue.shade400,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    leading:
                        const Icon(Icons.receipt_long, color: Colors.white),
                    title: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "${tmpEsd[index].FeederCode}  -- ${tmpEsd[index].FeederName.characters.take(15).toString()}",
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Affected Cons. : ${tmpEsd[index].ConsumersAffected.toString()}    ",
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Total SMS Sent. : ${tmpEsd[index].TotalSMSSent.toString()}",
                              style: const TextStyle(
                                color: Colors.white,
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
