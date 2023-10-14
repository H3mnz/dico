import 'package:flutter/material.dart';

enum Direction {
  vertical,
  horizontal,
}

class FadeSlideAnimation extends StatefulWidget {
  final Widget child;

  final double offset;

  final Curve curve;

  final Direction direction;
  final Duration animationDuration;

  const FadeSlideAnimation({
    required this.child,
    this.offset = 0.2,
    this.curve = Curves.easeIn,
    this.direction = Direction.vertical,
    this.animationDuration = const Duration(milliseconds: 500),
    Key? key,
  }) : super(key: key);

  @override
  _FadeSlideAnimationState createState() => _FadeSlideAnimationState();
}

class _FadeSlideAnimationState extends State<FadeSlideAnimation> with SingleTickerProviderStateMixin {
  late Animation<Offset> _animationSlide;

  AnimationController? _animationController;

  late Animation<double> _animationFade;

  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    if (_isDisposed) {
      return;
    } else {
      _animationController = AnimationController(
        vsync: this,
        duration: widget.animationDuration,
      );

      if (widget.direction == Direction.vertical) {
        _animationSlide = Tween<Offset>(begin: Offset(0, widget.offset), end: const Offset(0, 0)).animate(
          CurvedAnimation(
            curve: widget.curve,
            parent: _animationController!,
          ),
        );
        _animationController!.forward();
      } else {
        _animationSlide = Tween<Offset>(begin: Offset(widget.offset, 0), end: const Offset(0, 0)).animate(
          CurvedAnimation(
            curve: widget.curve,
            parent: _animationController!,
          ),
        );
        _animationController!.forward();
      }

      _animationFade = Tween<double>(begin: 0, end: 1.0).animate(
        CurvedAnimation(
          curve: widget.curve,
          parent: _animationController!,
        ),
      );
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationFade,
      child: SlideTransition(
        position: _animationSlide,
        child: widget.child,
      ),
    );
  }
}
