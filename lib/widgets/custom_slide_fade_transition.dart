import 'package:flutter/material.dart';

class CustomSlideFadeTransition extends StatelessWidget {
  const CustomSlideFadeTransition({
    Key? key,
    required AnimationController animationController,
    required this.child,
  })  : _animationController = animationController,
        super(key: key);

  final AnimationController _animationController;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.0, 0.4),
          end: const Offset(0.0, 0.0),
        ).animate(CurvedAnimation(
          parent: _animationController,
          curve: Curves.fastOutSlowIn,
        )),
        child: FadeTransition(
          opacity: CurvedAnimation(
            parent: _animationController,
            curve: Curves.fastOutSlowIn,
          ),
          child: child,
        ));
  }
}
