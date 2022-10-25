import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teju/cart_screen/add_address_view.dart';
import 'package:teju/cart_screen/cart_screen_viewmodel.dart';
import 'package:teju/components/toast_message.dart';
import 'package:teju/home_screen/home_screen_model.dart';
import 'package:teju/utility/constants.dart';

import 'address_model.dart';

class CartScreenView extends StatefulWidget {
  const CartScreenView({super.key});
  static const routeName = "cart_screen";
  @override
  State<CartScreenView> createState() => _CartScreenViewState();
}

class _CartScreenViewState extends State<CartScreenView> {
  int total = 0;
  late CartScreenViewModel _cartViewmodel;
  final int _deliveryCharge = 40;

  AddressModel? _addressModel;

  void setAddress(AddressModel newAddress) {
    setState(() {
      _addressModel = newAddress;
    });
  }

  @override
  void initState() {
    super.initState();
    _cartViewmodel = context.read<CartScreenViewModel>();
  }

  int add(List<Product> cartProduct) {
    double totalValue = 0;
    for (var product in cartProduct) {
      totalValue += product.wholesale! * product.quantity!;
    }
    return totalValue.floor();
  }

  @override
  Widget build(BuildContext context) {
    CartScreenViewModel cartDetail = context.watch<CartScreenViewModel>();
    setState(() {
      total = add(cartDetail.cartProduct);
    });

    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "CART",
            style: TextStyle(fontWeight: FontWeight.w500, color: textColor1),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: const []),
      body: SingleChildScrollView(
          //  padding: EdgeInsets.all(24),
          child: Column(
        children: [
          CartProducts(cartDetail.cartProduct),
          cartDetail.cartProduct.length > 0
              ? OrderSummary(cartDetail.cartProduct)
              : Container(),
          cartDetail.cartProduct.length > 0 ? AddressComponent() : Container(),
          const SizedBox(
            height: 100,
          )
        ],
      )),
      floatingActionButton: Container(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 12),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                side: const BorderSide(color: Color(0xFFE1785E)),
                backgroundColor: const Color.fromARGB(255, 227, 85, 49),
                minimumSize: const Size(double.infinity, 48)),
            onPressed: () {
              ToastMessage("Order and Pay Successfull");
            },
            child: const Text("Order & Pay")),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  // ignore: non_constant_identifier_names
  Widget CartProducts(List<Product> cartProduct) {
    return Container(
      margin: const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 8),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(
              4.0,
              4.0,
            ),
            blurRadius: 1,
            spreadRadius: 1.0,
          ), //BoxShadow
          //BoxShadow
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Padding(
                padding: EdgeInsets.fromLTRB(16, 8, 0, 0),
                child: Text(
                  "Your Order",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: textColor1),
                ),
              ),
              SizedBox()
            ],
          ),
          cartProduct.length > 0
              ? productListView(cartProduct)
              : Container(
                  padding: EdgeInsets.all(32),
                  child: Center(child: const Text("No Item Found in Cart")))
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget OrderSummary(List<Product> cartProduct) {
    return Container(
      margin: const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 8),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(
              4.0,
              4.0,
            ),
            blurRadius: 1,
            spreadRadius: 1.0,
          ), //BoxShadow
          //BoxShadow
        ],
      ),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Padding(
              padding: EdgeInsets.fromLTRB(16, 8, 0, 0),
              child: Text(
                "Bill Summary",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: textColor1),
              ),
            ),
            SizedBox()
          ],
        ),
        orderListView(cartProduct)
      ]),
    );
  }

  Widget orderListView(List<Product> cartProduct) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Item Total',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: textColor1),
              ),
              Text(
                "₹ ${formatter.format(total)}",
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: textColor1),
              )
            ],
          ),
          const Divider(
            color: Color(0xFFDBDBEA),
            thickness: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Item Count',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: textColor1),
              ),
              Text(
                "${cartProduct.length}",
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: textColor1),
              )
            ],
          ),
          const Divider(
            color: Color(0xFFDBDBEA),
            thickness: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Delivery Charges',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: textColor1),
              ),
              Text(
                "₹ ${formatter.format(_deliveryCharge)}",
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: textColor1),
              )
            ],
          ),
          const Divider(
            color: Color(0xFFDBDBEA),
            thickness: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Grand Total',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: textColor1),
              ),
              Text(
                "₹ ${formatter.format(total + _deliveryCharge)}",
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: textColor1),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget productList(Product cartProduct) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cartProduct.productName!,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: textColor1),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text("${cartProduct.mrp}"),
                  Text("${cartProduct.wholesale}")
                ],
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(
                height: 12,
              ),
              Container(
                decoration: BoxDecoration(
                  color: backGroundColor,
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  border: Border.all(
                    width: 1,
                    color: primaryColor,
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      child: const Icon(
                        Icons.remove,
                        color: primaryColor,
                      ),
                      onTap: () {
                        _cartViewmodel.updateItemFromCart(cartProduct, "SUB");
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        cartProduct.quantity.toString(),
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor),
                      ),
                    ),
                    GestureDetector(
                        child: const Icon(
                          Icons.add,
                          color: primaryColor,
                        ),
                        onTap: () {
                          _cartViewmodel.updateItemFromCart(cartProduct, "ADD");
                        }),
                  ],
                ),
              ),
              Text(
                "₹ ${(cartProduct.wholesale ?? 0) * (cartProduct.quantity ?? 0)}",
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: textColor1),
              )
            ],
          )
        ],
      ),
    );
  }

  ListView productListView(List<Product> cartProduct) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 0),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cartProduct.length,
      shrinkWrap: true,
      itemBuilder: (context, index) =>
          GestureDetector(onTap: () {}, child: productList(cartProduct[index])),
    );
  }

  // ignore: non_constant_identifier_names
  Widget AddressComponent() {
    return Container(
      margin: const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(
              4.0,
              4.0,
            ),
            blurRadius: 1,
            spreadRadius: 1.0,
          ), //BoxShadow
          //BoxShadow
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Delivery Address",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: textColor1),
              ),
              GestureDetector(
                onTap: (() {
                  showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return AddAddressView(
                          onTap: setAddress,
                        );
                      });
                }),
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    color: Color.fromARGB(255, 227, 85, 49),
                  ),
                  padding: const EdgeInsets.all(4),
                  child: const Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 18.0,
                  ),
                ),
              )
            ],
          ),
          _addressModel != null
              ? Container(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                  child: Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _addressModel?.shopName ?? "",
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: textColor1),
                        ),
                        Text(
                          _addressModel?.completeAddress ?? "",
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ),
                )
              : Container(
                  padding: const EdgeInsets.all(8),
                  child: const Center(child: Text("Add Delivery Address"))),
        ],
      ),
    );
  }

  Widget addAddress() {
    return const ListTile(
      title: Text(
        "ADD NEW ADDRESS",
      ),
      leading: Icon(Icons.add),
      trailing: Icon(Icons.arrow_forward_ios),
    );
  }
}
