import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teju/cart_screen/cart_screen_viewmodel.dart';
import 'package:teju/home_screen/home_screen_model.dart';
import 'package:teju/home_screen/home_viewmodel.dart';

import '../../utility/constants.dart';

// ignore: must_be_immutable
class ProductView extends StatelessWidget {
  Product? productDetail;
  ProductView(this.productDetail, {super.key});

  @override
  Widget build(BuildContext context) {
    HomeScreenViewModel cartDetail = context.watch<HomeScreenViewModel>();
    CartScreenViewModel cartDataDetail = context.watch<CartScreenViewModel>();
    return Card(
      color: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(10),
            bottomLeft: Radius.circular(10)),
      ),
      elevation: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      "${productDetail?.productName}",
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    Row(
                      children: [
                        Text(
                          "${productDetail?.mrp}",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[600]),
                        ),
                        Text(
                          "${productDetail?.wholesale}",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[600]),
                        ),
                        Text(
                          "(Save ${((productDetail?.mrp ?? 0) / (productDetail?.wholesale ?? 0)).floor()}%)",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[600]),
                        ),
                      ],
                    ),
                    Text(
                      "${productDetail?.quantity}",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[600]),
                    ),
                  ]),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 120,
                          height: 95,
                          color: Colors.white,
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                          child: Container(
                            width: 120,
                            height: 80,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              color: Colors.red,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 20,
                          child: (productDetail!.quantity ?? 0) > 0
                              ? Container(
                                  width: 80,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      width: 1,
                                      color: primaryColor,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      GestureDetector(
                                        child: Container(
                                          color: Colors.red,
                                          padding: const EdgeInsets.all(8),
                                          child: const Icon(
                                            Icons.remove,
                                            color: primaryColor,
                                            size: 12,
                                          ),
                                        ),
                                        onTap: () {
                                          cartDetail.updateItemFromCart(
                                              productDetail!, "SUB");
                                          cartDataDetail
                                              .removeFromCart(productDetail!);
                                        },
                                      ),
                                      Text(
                                        productDetail!.quantity.toString(),
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor),
                                      ),
                                      GestureDetector(
                                          child: Container(
                                            color: Colors.red,
                                            padding: const EdgeInsets.all(8),
                                            child: const Icon(
                                              Icons.add,
                                              color: primaryColor,
                                              size: 12,
                                            ),
                                          ),
                                          onTap: () {
                                            cartDetail.updateItemFromCart(
                                                productDetail!, "ADD");
                                            cartDataDetail
                                                .addToCart(productDetail!);
                                          }),
                                    ],
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    cartDetail.updateItemFromCart(
                                        productDetail!, "ADD");
                                  },
                                  child: Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    width: 80,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        width: 1,
                                        color: primaryColor,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    child: const Center(child: Text("ADD")),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ]),
            ),
          )
        ],
      ),
    );
  }
}
