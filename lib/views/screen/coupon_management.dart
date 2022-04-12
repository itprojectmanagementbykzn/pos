import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pos_system/controller/all_controller.dart';
import 'package:pos_system/controller/sales_controller.dart';
import 'package:pos_system/model/coupon.dart';

import '../../utils/theme.dart';
import '../widgets/inventory_widget/coupon_form.dart';
import 'inventory_management.dart';

class CouponManagement extends StatefulWidget {
  const CouponManagement({Key? key}) : super(key: key);

  @override
  State<CouponManagement> createState() => _CouponManagementState();
}

class _CouponManagementState extends State<CouponManagement> {
  @override
  void initState() {
    Get.put(SalesController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    SalesController _saleController = Get.find();
    AllController _controller = Get.find();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        title: const Text("Coupon Management"),
        leading: const Icon(
          FontAwesomeIcons.microchip,
          color: Colors.white,
          size: 30,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          //Text and Add Row
          Row(
            children: [
              const Text("Coupon Table",
                  style: TextStyle(
                    color: Color.fromARGB(255, 15, 70, 17),
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  )),
              //Space
              const SizedBox(width: 15),
              //Add Button
              ElevatedButton(
                onPressed: () {
                  Get.defaultDialog(
                    confirm: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                      ),
                      onPressed: () => _saleController.addCoupon(),
                      child: const Text("Upload",
                          style: TextStyle(
                            color: Colors.black,
                          )),
                    ),
                    title: "Add New Product",
                    content: const CouponFormWidget(),
                  );
                },
                child: const Text("Add New Coupon",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ],
          ),
          //Coupon Table
          SizedBox(
              height: size.height * 0.7,
              child: ListView(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      border: TableBorder.all(color: Colors.black),
                      headingTextStyle: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      showCheckboxColumn: false,
                      columns: <DataColumn>[
                        DataColumn(label: customTableCell("Delete")),
                        DataColumn(label: customTableCell("Discount Content")),
                        DataColumn(label: customTableCell("Code")),
                        DataColumn(label: customTableCell("Percentage")),
                        DataColumn(label: customTableCell("Start Date")),
                        DataColumn(label: customTableCell("Expire Date")),
                      ],
                      rows: _controller.couponList.map((item) {
                        return DataRow(cells: <DataCell>[
                          DataCell(
                            //UpdateButton
                            IconButton(
                              onPressed: () =>
                                  _controller.removeCoupon(item.documentID!),
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ),
                          DataCell(customTableCell(item.discountContent)),
                          DataCell(customTableCell(item.code)),
                          DataCell(customTableCell("${item.percentage}")),
                          DataCell(customTableCell("${item.startDate}")),
                          DataCell(customTableCell("${item.expireDate}")),
                        ]);
                      }).toList(),
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
