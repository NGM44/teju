import 'package:flutter/material.dart';

class ProductScreenView extends StatefulWidget {
  const ProductScreenView({super.key});

  @override
  State<ProductScreenView> createState() => _ProductScreenViewState();
}

class _ProductScreenViewState extends State<ProductScreenView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      width: MediaQuery.of(context).size.width,
      color: Colors.red,
      child: const Text("Product"),
    );
  }
}
