import 'package:flutter/material.dart';

class ForgotPass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: Center(
        child: Text(
            'Poyi umbada',
            style: TextStyle(
              fontSize : 50.0,
              fontWeight: FontWeight.w900,
            )
        ),
      ),
    );
  }
}
