import 'package:flutter/material.dart';

class FliterView extends StatelessWidget {
  const FliterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: const Text("SEARCH"),
    );
  }
}
