import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_system/controller/sales_controller.dart';
import 'package:pos_system/views/widgets/sales_analysis/weekly_bar_chart.dart';

import '../widgets/sales_analysis/custom_card.dart';
import 'daily_revenue.dart';

class MonthlyRevenue extends StatelessWidget {
  const MonthlyRevenue({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    SalesController _controller = Get.find();
    return !(_controller.dailySplayTreeMapList.value == null) &&
            (_controller.dailySplayTreeMapList.value!.isNotEmpty)
        ? Column(
            children: [
              Row(
                children: [
                  CustomCardForSales(
                    headTitleText: _controller
                        .getMonthName(_controller.getCurrentMonthDateTime()),
                    color: Colors.red,
                    total: "${_controller.monthlyProfit()}ks",
                  ),
                  CustomCardForSales(
                    headTitleText: _controller
                        .getMonthName(_controller.getCurrentMonthDateTime()),
                    color: Colors.green,
                    total: "${_controller.monthlyRevenue()}ks",
                  ),
                  CustomCardForSales(
                    headTitleText: _controller
                        .getMonthName(_controller.getCurrentMonthDateTime()),
                    color: Colors.blue,
                    total: "${_controller.monthlyOriginalRevenue()}ks",
                  ),
                ],
              ),
              const SizedBox(height: 15),

              const WeeklyBarChart(),

              //Note For Monthly LineChart
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
          )
        : const CircularProgressIndicator();
  }
}
