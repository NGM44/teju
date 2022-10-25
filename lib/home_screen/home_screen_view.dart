import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';
import 'package:teju/cart_screen/cart_screen_view.dart';
import 'package:teju/cart_screen/cart_screen_viewmodel.dart';
import 'package:teju/home_screen/component/product_view.dart';
import 'package:teju/home_screen/component/shop_view.dart';
import 'package:teju/home_screen/home_screen_model.dart';
import 'package:teju/home_screen/home_viewmodel.dart';
import 'package:teju/product_page/product_screen_view.dart';
import 'package:provider/provider.dart';
import 'package:teju/utility/constants.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = 'home_screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController controller = TextEditingController();

  late HomeScreenDataModel? _product;

  List<Product> _showingproduct = [];

  @override
  void initState() {
    super.initState();
    _product = context.read<HomeScreenViewModel>().homeDataModel;
    _product?.product?.forEach((element) {
      _showingproduct.add(element);
    });
  }

  @override
  Widget build(BuildContext context) {
    final _cartViewModel = context.read<CartScreenViewModel>();
    print(_cartViewModel.cartProduct);
    return DraggableHome(
      // leading: const Icon(Icons.arrow_back_ios),
      title: _buildSearchBox(),
      // actions: [
      //   IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
      // ],
      headerWidget: ShopView(_product?.shopDetail),
      headerBottomBar: _buildSearchBox(),
      headerExpandedHeight: 0.3,
      floatingActionButton: _cartViewModel.cartProduct.length > 0
          ? Container(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 12),
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
            )
          : Container(),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: [
        listView(_showingproduct),
      ],
      backgroundColor: backGroundColor,
      appBarColor: const Color.fromARGB(255, 227, 85, 49),
    );
  }

  onSearchTextChanged(String searchedText) async {
    List<Product> listProduct = [];
    if (searchedText == "") {
      setState(() {
        _showingproduct = _product?.product ?? [];
      });
      return;
    }
    _product?.product?.forEach((product) {
      if (product.productName!
              .toLowerCase()
              .contains(searchedText.toLowerCase()) ||
          product.description!
              .toLowerCase()
              .contains(searchedText.toLowerCase())) {
        listProduct.add(product);
      }
    });
    setState(() {
      _showingproduct = listProduct;
    });
  }

  Widget _buildSearchBox() {
    return Card(
      color: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10)),
          side: BorderSide(width: 1, color: Colors.grey)),
      shadowColor: Colors.black,
      elevation: 10,
      child: ListTile(
        leading: const Icon(Icons.search),
        title: TextField(
          controller: controller,
          decoration: const InputDecoration(
              fillColor: Colors.amber,
              hintText: 'Search',
              border: InputBorder.none),
          onChanged: onSearchTextChanged,
        ),
        trailing: IconButton(
          icon: const Icon(Icons.cancel),
          onPressed: () {
            controller.clear();
            onSearchTextChanged('');
          },
        ),
      ),
    );
  }

  ListView listView(List<Product> product) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 0),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: product.length,
      shrinkWrap: true,
      itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
            showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                builder: (context) {
                  return const ProductScreen();
                });
          },
          child: ProductView(product[index])),
    );
  }
}
