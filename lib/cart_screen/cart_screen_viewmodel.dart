import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:teju/cart_screen/address_model.dart';
import 'package:teju/home_screen/home_screen_model.dart';
import 'package:teju/utility/constants.dart';

class CartScreenViewModel extends ChangeNotifier {
  final List<Product> _cartProduct = [
    // Product(
    //     productName: "Patanjali",
    //     review: 4.5,
    //     mrp: 932.3,
    //     wholesale: 324.5,
    //     description:
    //         "Lorem loasdo jkakcbk us Nikhil ckjasjk cj njkjsd kjnb jk djk",
    //     stock: 10,
    //     quantity: 0,
    //     imageUrl:
    //         "https://www.bigbasket.com/media/uploads/p/l/40111644_5-himalaya-tan-removal-orange-face-wash.jpg"),
    // Product(
    //     productName: "Patanjali",
    //     review: 4.5,
    //     mrp: 932.3,
    //     wholesale: 324.5,
    //     description:
    //         "Lorem loasdo jkakcbk us Nikhil ckjasjk cj njkjsd kjnb jk djk",
    //     stock: 10,
    //     quantity: 0,
    //     imageUrl:
    //         "https://www.bigbasket.com/media/uploads/p/l/40111644_5-himalaya-tan-removal-orange-face-wash.jpg")
  ];

  final List<AddressModel> _addressList = [];

  List<AddressModel> get addressList => _addressList;
  List<Product> get cartProduct => _cartProduct;

  addToCart(Product newProduct) {
    _cartProduct.add(newProduct);
    notifyListeners();
  }

  addToAddress(AddressModel newaddress) {
    _addressList.add(newaddress);

    notifyListeners();
  }

  removeAddress(AddressModel newAddress) {
    _addressList.remove(newAddress);
    notifyListeners();
  }

  removeFromCart(newProduct) {
    _cartProduct.remove(newProduct);
    notifyListeners();
  }

  updateItemFromCart(Product product, String operation) {
    int index = _cartProduct.indexOf(product);
    operation == "ADD"
        ? _cartProduct[index].quantity = _cartProduct[index].quantity! + 1
        : _cartProduct[index].quantity = _cartProduct[index].quantity! - 1;
    if (_cartProduct[index].quantity! <= 0) _cartProduct.remove(product);

    notifyListeners();
  }

  Future<void> getHomeDataModel(
    BuildContext context,
  ) async {
    try {
      http.Response response = await http.get(
        Uri.parse("${baseUrl}endpoints"),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: "application/json",
          'x-user-token': "xUserToken",
        },
      );
      if (response.statusCode == 200) {
        // _homeDataModel =
        //     HomeScreenDataModel.fromJson(jsonDecode(response.body));
        notifyListeners();
      } else {}
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
