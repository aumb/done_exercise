import 'package:flutter/material.dart';

class AnimatedForm extends StatefulWidget {
  const AnimatedForm({
    Key? key,
    required this.child,
    this.shouldReset = true,
  }) : super(key: key);

  final Widget child;
  final bool shouldReset;

  @override
  _AnimatedFormState createState() => _AnimatedFormState();
}

class _AnimatedFormState extends State<AnimatedForm>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

    _animationController.forward();
  }

  @override
  void didUpdateWidget(covariant AnimatedForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.shouldReset) {
      _animationController
        ..reset()
        ..forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (_, __) {
        return Opacity(
          opacity: _animation.value,
          child: widget.child,
        );
      },
    );
  }
}
