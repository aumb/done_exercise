import 'package:flutter/material.dart';

class AnimatedProgressBar extends StatelessWidget {
  const AnimatedProgressBar({
    Key? key,
    required this.fraction,
  }) : super(key: key);

  final double fraction;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return AnimatedContainer(
      curve: Curves.easeInOut,
      color: Theme.of(context).accentColor,
      duration: const Duration(milliseconds: 300),
      height: 4,
      width: width * fraction,
    );
  }
}
