import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pos_system/controller/sales_controller.dart';
import 'package:pos_system/utils/theme.dart';

import '../pages/daily_revenue.dart';
import '../pages/monthly_revenue.dart';
import '../pages/yearly_revenue.dart';

class SalesAnalysis extends StatefulWidget {
  const SalesAnalysis({Key? key}) : super(key: key);

  @override
  State<SalesAnalysis> createState() => _SalesAnalysisState();
}

class _SalesAnalysisState extends State<SalesAnalysis> {
  @override
  void initState() {
    Get.put(SalesController());
    super.initState();
  }

  @override
  void dispose() {
    Get.delete();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appColor,
          title: const Text("Sales Analysis"),
          leading: const Icon(
            FontAwesomeIcons.coins,
            color: Colors.white,
            size: 30,
          ),
          centerTitle: true,
          bottom: const TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.black26,
            labelPadding: EdgeInsets.all(8),
            indicatorColor: Colors.blue,
            indicatorWeight: 5,
            tabs: [
              Text(
                "Daily",
              ),
              Text(
                "Monthly",
              ),
              Text("Yearly"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            DailyRevenue(),
            MonthlyRevenue(),
            YearlyRevenue(),
          ],
        ),
      ),
    );
  }
}
