import 'package:flutter/material.dart';
import 'package:teju/cart_screen/cart_screen_view.dart';
import 'package:teju/utility/constants.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});
  static const routeName = '/home_screen';
  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        color: primaryColor,
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFE1785E)),
                    backgroundColor: const Color.fromARGB(255, 227, 85, 49),
                    minimumSize: const Size(double.infinity, 48)),
                onPressed: () {
                  Navigator.restorablePushNamed(
                    context,
                    CartScreenView.routeName,
                  );
                },
                child: const Text("CART")),
          ),
        ],
      ),
    );
  }
}
