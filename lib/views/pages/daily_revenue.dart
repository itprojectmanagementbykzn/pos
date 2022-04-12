import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_system/controller/sales_controller.dart';
import 'package:pos_system/views/widgets/sales_analysis/animate_bar.dart';

import '../widgets/sales_analysis/custom_card.dart';

class DailyRevenue extends StatelessWidget {
  const DailyRevenue({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    SalesController _controller = Get.find();
    return Obx(() => !(_controller.dailySplayTreeMapList.value == null) &&
            (_controller.dailySplayTreeMapList.value!.isNotEmpty)
        ? SingleChildScrollView(
            child: Column(
              children: [
                //Top Daily Row
                Row(
                  children: [
                    CustomCardForSales(
                      headTitleText: "Today",
                      color: Colors.red,
                      total: _controller.todayProfit(),
                    ),
                    CustomCardForSales(
                      headTitleText: "Today",
                      color: Colors.green,
                      total: "${_controller.todayRevenue()}",
                    ),
                    CustomCardForSales(
                      headTitleText: "Today",
                      color: Colors.blue,
                      total: "${_controller.todayOriginalRevenue()}",
                    ),
                  ],
                ),
                //DailyBarChart
                Center(
                    child: SizedBox(
                        height: size.height * 0.6,
                        child: const SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: BarChartSample1()))),

                //Note For AnimateBarChart
                Row(
                  children: [
                    noteForDailyAnimateBarChart(
                        color: Colors.red, text: "Profit"),
                    noteForDailyAnimateBarChart(
                        color: Colors.green, text: "Total Revenue"),
                    noteForDailyAnimateBarChart(
                        color: Colors.blue, text: "Total Cost"),
                  ],
                ),
              ],
            ),
          )
        : const Center(
            child: SizedBox(
                height: 50, width: 50, child: CircularProgressIndicator())));
  }
}

Widget noteForDailyAnimateBarChart({
  required Color color,
  required String text,
}) {
  return Row(
    children: [
      const SizedBox(width: 20),
      CircleAvatar(
        radius: 10,
        backgroundColor: color,
      ),
      const SizedBox(width: 10),
      Text(text),
    ],
  );
}
