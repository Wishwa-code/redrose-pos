import 'package:flutter/material.dart';

class CashierPage extends StatelessWidget {
  const CashierPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Hello Cashier!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
