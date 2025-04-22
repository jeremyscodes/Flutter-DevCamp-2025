import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlueGradientButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? text;
  final double? width;


  const BlueGradientButton({
    super.key,
    this.onPressed,
    this.text,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44.0,
      width: width ?? 300,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22.0),
          gradient: const LinearGradient(colors: [
            Color.fromRGBO(24, 96, 191, 1),
            Color.fromRGBO(26, 176, 222, 1)
          ])),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          foregroundColor: Colors.white,
          disabledBackgroundColor: Colors.grey,
        ),
        child: Text(text ?? 'button'),
      ),
    );
  }
}
