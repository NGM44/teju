import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';
import 'package:teju/cart_screen/address_model.dart';
import 'package:teju/cart_screen/cart_screen_viewmodel.dart';
import 'package:teju/components/toast_message.dart';

class AddAddressScreen extends StatefulWidget {
  static const routeName = "addAddressScreen";

  const AddAddressScreen({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final TextEditingController _shopName = TextEditingController();
  final TextEditingController _shopAddress = TextEditingController();
  final TextEditingController _shopNumber = TextEditingController();
  final TextEditingController _shopLandmark = TextEditingController();
  @override
  Widget build(BuildContext context) {
    CartScreenViewModel cartDetail = context.watch<CartScreenViewModel>();

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: Container(
        padding: const EdgeInsets.fromLTRB(48, 0, 24, 12),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                side: const BorderSide(color: Color(0xFFE1785E)),
                backgroundColor: const Color.fromARGB(255, 227, 85, 49),
                minimumSize: const Size(double.infinity, 48)),
            onPressed: () {
              if (formkey.currentState!.validate()) {
                cartDetail.addToAddress(AddressModel(
                    shopName: _shopName.text,
                    completeAddress: _shopAddress.text,
                    nearbyLandMark: _shopLandmark.text,
                    phoneNumber: _shopNumber.text));
                Navigator.pop(context);
              } else {
                ToastMessage("Please Fill The Feilds Properly");
              }
            },
            child: const Text(
              "Add Address",
              style: TextStyle(
                fontSize: 18,
              ),
            )),
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 227, 85, 49),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: const Text("Add Address"),
      ),
      body: Form(
        autovalidateMode:
            AutovalidateMode.disabled, //check for validation while typing
        key: formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextFormField(
                      controller: _shopName,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Name',
                          hintText: 'Enter Full Name / Shop Name'),
                      validator: MultiValidator([
                        RequiredValidator(errorText: "*Name is Required"),
                      ])),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 0, bottom: 0),
                  child: TextFormField(
                      controller: _shopAddress,
                      maxLines: 3,
                      keyboardType: TextInputType.streetAddress,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Address',
                          hintText: 'Enter Full Address'),
                      validator: MultiValidator([
                        RequiredValidator(errorText: "*Address is Required"),
                      ])
                      //validatePassword,        //Function to check validation
                      ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0),
                  child: TextFormField(
                      controller: _shopNumber,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Contact Number',
                          hintText: 'Enter you contact number'),
                      validator: MultiValidator([
                        RequiredValidator(
                            errorText: "*Contact Number is Required"),
                      ])),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0),
                  child: TextFormField(
                    controller: _shopLandmark,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Landmark(OPTIONAL)',
                        hintText: 'nearby landmark(OPTIONAL)'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
