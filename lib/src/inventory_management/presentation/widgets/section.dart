import 'package:benaiah_admin_app/core/widgets/border_box.dart';
import 'package:flutter/material.dart';

class Section extends StatelessWidget {
  const Section({
    required this.title,
    required this.children,
    super.key,
    this.crossAxisAlignment,
    this.padding,
  });

  final String title;
  final List<Widget> children;
  final CrossAxisAlignment? crossAxisAlignment;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 10),
        BorderBox(
          padding: padding ?? const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
            children: children,
          ),
        ),
      ],
    );
  }
}
