import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pos_system/controller/all_controller.dart';
import 'package:pos_system/controller/inventory_controller.dart';
import 'package:pos_system/views/widgets/inventory_piechart.dart';
import 'package:pos_system/views/widgets/inventory_widget/product_form.dart';

import '../../utils/theme.dart';

class InventoryManagement extends StatefulWidget {
  const InventoryManagement({Key? key}) : super(key: key);

  @override
  State<InventoryManagement> createState() => _InventoryManagementState();
}

class _InventoryManagementState extends State<InventoryManagement> {
  @override
  void initState() {
    Get.put(InventoryController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AllController _controller = Get.find();
    InventoryController _inController = Get.find();
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: appColor,
          title: const Text("Sales Analysis"),
          leading: const Icon(
            FontAwesomeIcons.boxes,
            color: Colors.white,
            size: 30,
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  _inController.pressAddProduct();
                  Get.defaultDialog(
                    confirm: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                      ),
                      onPressed: () => _inController.addProduct(),
                      child: const Text("Upload",
                          style: TextStyle(
                            color: Colors.black,
                          )),
                    ),
                    title: "Add New Product",
                    content: const ProductFormWidget(),
                  );
                },
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ))
          ],
        ),
        body: Obx(
          () => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 25,
                ),
                const InventoryPieChart(),
                const SizedBox(
                  height: 25,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20, bottom: 5),
                  child: Text(
                    "Stock Table",
                    style: TextStyle(
                      color: Color.fromARGB(255, 15, 70, 17),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.6,
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
                            DataColumn(label: customTableCell("Function")),
                            DataColumn(label: customTableCell("Code")),
                            DataColumn(label: customTableCell("Name")),
                            DataColumn(
                                label: customTableCell("Total Quantity")),
                            DataColumn(
                                label: customTableCell("Remain Quantity")),
                            DataColumn(label: customTableCell("Price")),
                            DataColumn(label: customTableCell("Cost")),
                          ],
                          rows: _controller.productList.map((item) {
                            return DataRow(
                                selected:
                                    _inController.currentProduct.value?.id ==
                                        item.id,
                                onSelectChanged: (value) =>
                                    _inController.changeCurrentProduct(item),
                                cells: <DataCell>[
                                  DataCell(Row(
                                    children: [
                                      //UpdateButton
                                      IconButton(
                                        onPressed: () {
                                          _inController
                                              .changeCurrentProduct(item);
                                          Get.defaultDialog(
                                            confirm: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors.green,
                                              ),
                                              onPressed: () =>
                                                  _inController.addProduct(),
                                              child: const Text("Update",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  )),
                                            ),
                                            title: "Edit Product",
                                            content: const ProductFormWidget(),
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.edit,
                                        ),
                                      ),
                                      //DeleteButton
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.delete,
                                        ),
                                      )
                                    ],
                                  )),
                                  DataCell(customTableCell(item.id)),
                                  DataCell(customTableCell(item.name)),
                                  DataCell(customTableCell("${item.quantity}")),
                                  DataCell(customTableCell(
                                      "${item.remainQuantity}")),
                                  DataCell(customTableCell("${item.price}ks")),
                                  DataCell(customTableCell(
                                      "${item.originalPrice}ks")),
                                ]);
                          }).toList(),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                //Product Name
                /*SizedBox(
                  height: 50,
                  width: size.width * 0.7,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Product Name: "),
                      SizedBox(
                        width: 150,
                        height: 50,
                        child: TextFormField(
                          controller: _inController.nameController,
                          maxLines: 1,
                          decoration: const InputDecoration(
                              //border: InputBorder.none,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                //Price
                SizedBox(
                  height: 50,
                  width: size.width * 0.7,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Price: "),
                      SizedBox(
                        width: 150,
                        height: 50,
                        child: TextFormField(
                          controller: _inController.priceController,
                          maxLines: 1,
                          decoration: const InputDecoration(
                              //border: InputBorder.none,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                //Quantity
                SizedBox(
                  height: 50,
                  width: size.width * 0.7,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Product Name: "),
                      SizedBox(
                        width: 150,
                        height: 50,
                        child: TextFormField(
                          controller: _inController.quantityController,
                          maxLines: 1,
                          decoration: const InputDecoration(
                              //border: InputBorder.none,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        //Update
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.yellow,
                          ),
                          onPressed: () => {},
                          child: const Text("Update",
                              style: TextStyle(
                                color: Colors.white,
                              )),
                        ),
                        //Delete
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                          ),
                          onPressed: () => {},
                          child: const Text("Delete",
                              style: TextStyle(
                                color: Colors.white,
                              )),
                        ),
                      ],
                    )),*/
              ],
            ),
          ),
        ));
  }
}

Widget customTableCell(String text) {
  return SizedBox(
      width: 100,
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ));
}
