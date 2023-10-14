import 'package:flutter/material.dart';

class CustomAnimatedSwitcher extends StatelessWidget {
  final Widget firstChild;
  final Widget secondChild;
  final bool toggle;
  const CustomAnimatedSwitcher({
    Key? key,
    required this.firstChild,
    required this.secondChild,
    required this.toggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      width: 36,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: toggle ? firstChild : secondChild,
        layoutBuilder: (Widget? currentChild, List<Widget> previousChildren) {
          return SizedBox(
            height: 36,
            width: 36,
            child: Center(
              child: Stack(
                children: <Widget>[
                  ...previousChildren,
                  if (currentChild != null) currentChild,
                ],
              ),
            ),
          );
        },
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: animation,
              child: child,
            ),
          );
        },
      ),
    );
  }
}
