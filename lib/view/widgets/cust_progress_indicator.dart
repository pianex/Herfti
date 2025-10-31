import 'package:flutter/material.dart';

class CustProgressIndicator extends StatelessWidget {
  const CustProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator(color: Colors.white));
  }
}
