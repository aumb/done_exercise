import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    Key? key,
    required this.onPressed,
    required this.label,
    this.borderColor,
  }) : super(key: key);

  final Function() onPressed;
  final String label;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          color: borderColor ?? Colors.grey,
          width: borderColor != null ? 2 : 1,
        ),
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
