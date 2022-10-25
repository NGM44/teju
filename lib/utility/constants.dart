import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:teju/cart_screen/cart_screen_viewmodel.dart';
import 'package:teju/home_screen/home_viewmodel.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

const Color primaryColor = Color.fromARGB(255, 227, 85, 49);
const Color textColor1 = Colors.black;
const Color backGroundColor = Color(0xFFF1F0F5);

const Color secondaryColor = Color(0xFF2A2D3E);
const Color bgColor = Color(0xFFF3E5F5);

final String baseUrl = dotenv.env['BASE_URL'] ?? "";
final String analyticsKey = dotenv.env['ANALYTICS_KEY'] ?? "";

var formatter = NumberFormat('#,##,###');

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (_) => HomeScreenViewModel()),
  ChangeNotifierProvider(create: (_) => CartScreenViewModel())
];
