import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:teju/home_screen/home_screen_model.dart';
import 'package:teju/utility/constants.dart';

class HomeScreenViewModel extends ChangeNotifier {
  HomeScreenDataModel _homeDataModel = HomeScreenDataModel(
      shopDetail: ShopDetail(
          shopName: "Teju Shop",  
          contactNumber: 9854898459,
          ownerName: "Teju gowda",
          shopTiming: "12am to 10pm(Mon-Fri)",
          shopCordinates: "1321321.123231,23423.34324",
          address: "Indira nagar bhadwane , ys colony, dharwad",
          shopImageUrl: ""),
      filterBrand: FilterBrand(
          brandName: ["Garnier", "Black", "Pink", "Nykaa", "bubble"]),
      product: [
        Product(
            productName: "Garnier1",
            review: 4.5,
            mrp: 932.3,
            wholesale: 324.5,
            description:
                "Lorem loasdo jkakcbk us Mudakavi ckjasjk cj njkjsd kjnb jk djk",
            stock: 10,
            quantity: 0,
            imageUrl:
                "https://www.bigbasket.com/media/uploads/p/l/40111644_5-himalaya-tan-removal-orange-face-wash.jpg"),
        Product(
            productName: "Patanjali",
            review: 4.5,
            mrp: 932.3,
            wholesale: 324.5,
            description:
                "Lorem loasdo jkakcbk us Nikhil ckjasjk cj njkjsd kjnb jk djk",
            stock: 10,
            quantity: 0,
            imageUrl:
                "https://www.bigbasket.com/media/uploads/p/l/40111644_5-himalaya-tan-removal-orange-face-wash.jpg")
      ]);

  HomeScreenDataModel get homeDataModel => _homeDataModel;

  setHomeScreenDataModel(homeDataModel) {
    _homeDataModel = homeDataModel;
    notifyListeners();
  }

  updateItemFromCart(Product product, String operation) {
    int index = _homeDataModel.product!.indexOf(product);
    operation == "ADD"
        ? _homeDataModel.product![index].quantity =
            _homeDataModel.product![index].quantity! + 1
        : _homeDataModel.product![index].quantity =
            _homeDataModel.product![index].quantity! - 1;
    if (_homeDataModel.product![index].quantity! <= 0) {
      _homeDataModel.product![index].quantity = 0;
    }

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
        _homeDataModel =
            HomeScreenDataModel.fromJson(jsonDecode(response.body));
        notifyListeners();
      } else {}
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
