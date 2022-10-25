import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teju/cart_screen/add_address_screen.dart';
import 'package:teju/cart_screen/address_model.dart';
import 'package:teju/cart_screen/cart_screen_viewmodel.dart';
import 'package:teju/utility/constants.dart';

// ignore: must_be_immutable
class AddAddressView extends StatefulWidget {
  ValueChanged<AddressModel> onTap;
  AddAddressView({super.key, required this.onTap});

  @override
  State<AddAddressView> createState() => _AddAddressViewState();
}

class _AddAddressViewState extends State<AddAddressView> {

  @override
  Widget build(BuildContext context) {
    CartScreenViewModel cartDetail = context.watch<CartScreenViewModel>();
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(32, 24, 12, 12),
            child: const Text(
              "Delivery Address",
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w700, color: textColor1),
            ),
          ),
          listView(cartDetail),
          addAddress()
        ],
      ),
    );
  }

  Widget addAddress() {
    return GestureDetector(
      onTap: (() {
        Navigator.restorablePushNamed(
          context,
          AddAddressScreen.routeName,
        );
      }),
      child: Container(
        padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
        child: const ListTile(
          title: Text(
            "ADD NEW ADDRESS",
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
          ),
          leading: Icon(
            Icons.add,
            color: primaryColor,
          ),
          trailing: Icon(Icons.arrow_forward_ios, color: primaryColor),
        ),
      ),
    );
  }

  ListView listView(CartScreenViewModel cartDetail) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 0),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cartDetail.addressList.length,
      shrinkWrap: true,
      itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            widget.onTap(cartDetail.addressList[index]);
            Navigator.pop(context);
          },
          child: ListTile(
              title: Text(
                cartDetail.addressList[index].shopName ?? "",
              ),
              subtitle: Text(
                cartDetail.addressList[index].completeAddress ?? "",
              ),
              leading: const Icon(
                Icons.navigation,
                color: primaryColor,
              ),
              trailing: GestureDetector(
                onTap: () {
                  cartDetail.removeAddress(cartDetail.addressList[index]);
                },
                child: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ))),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
