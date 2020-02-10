import 'package:flutter/material.dart';

class BottomAddButton extends StatelessWidget {
  final Function onPressed;

  const BottomAddButton({Key key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: Size.fromHeight(100),
      child: Align(
        alignment: Alignment.center,
        child: SizedBox.fromSize(
          size: Size.fromHeight(50),
          child: IconButton(
            onPressed: this.onPressed,
            icon: Icon(
              Icons.add_circle,
              size: 50,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
