import 'package:flutter/material.dart';

class FadeWidget extends StatefulWidget {
  final Widget child;
  const FadeWidget({super.key, required this.child});

  @override
  State<FadeWidget> createState() => _FadeWidgetState();
}

class _FadeWidgetState extends State<FadeWidget> with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> _fadeIn;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeIn = Tween<double>(begin: 0.0, end: 1).animate(animationController);

    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeIn,
      child: widget.child,
    );
  }
}
