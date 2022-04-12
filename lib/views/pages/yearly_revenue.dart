import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_system/controller/sales_controller.dart';
import 'package:pos_system/views/widgets/sales_analysis/yearly_stack_area.dart';

import '../widgets/sales_analysis/custom_card.dart';
import 'daily_revenue.dart';

class YearlyRevenue extends StatelessWidget {
  const YearlyRevenue({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SalesController _controller = Get.find();
    return Column(
      children: [
        Row(
          children: [
            CustomCardForSales(
              headTitleText: "${DateTime.now().year}",
              color: Colors.red,
              total: "${_controller.getCurrentYearProfit()}ks",
            ),
            CustomCardForSales(
              headTitleText: "${DateTime.now().year}",
              color: Colors.green,
              total: "${_controller.getCurrentYearRevenue()}ks",
            ),
            CustomCardForSales(
              headTitleText: "${DateTime.now().year}",
              color: Colors.blue,
              total: "${_controller.getCurrentYearCost()}ks",
            ),
          ],
        ),
        const SizedBox(height: 15),
        //
        const StackedAreaCustomColorLineChart(),
        //Note For Yearly LineChart
        Row(
          children: [
            noteForDailyAnimateBarChart(color: Colors.red, text: "Profit"),
            noteForDailyAnimateBarChart(
                color: Colors.green, text: "Total Revenue"),
            noteForDailyAnimateBarChart(color: Colors.blue, text: "Total Cost"),
          ],
        ),
      ],
    );
  }
}
