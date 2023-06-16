import 'package:flutter/material.dart';

class ConditionalCenter extends StatelessWidget {
  const ConditionalCenter({
    required this.center,
    required this.child,
    super.key,
  });

  final bool center;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return center ? Center(child: child) : child;
  }
}
