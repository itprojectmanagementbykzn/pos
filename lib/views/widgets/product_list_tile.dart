import 'package:flutter/material.dart';

class ProductListTile extends StatefulWidget {
  final bool isLoading;
  const ProductListTile({Key? key, required this.isLoading}) : super(key: key);

  @override
  State<ProductListTile> createState() => _ProductListTileState();
}

class _ProductListTileState extends State<ProductListTile> {
  @override
  Widget build(BuildContext context) {
    return widget.isLoading
        ? Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(16),
            ),
            )
        : ListTile(
            title: Text("Product name"),
            subtitle: Text("8"),
            trailing: ElevatedButton(
              onPressed: () {
                //TODO: DO SOMETHING
              },
              child: Text("Order Now"),
            ));
  }
}
