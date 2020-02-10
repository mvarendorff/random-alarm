import 'package:flutter/material.dart';

class DefaultContainer extends StatelessWidget {
  final Widget child;

  DefaultContainer({this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          bottom: 15,
          left: 15,
          right: 15,
          top: 50,
        ),
        child: this.child,
      ),
      appBar: null,
    );
  }
}
