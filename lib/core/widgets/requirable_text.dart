import 'package:flutter/material.dart';

class RequirableText extends StatelessWidget {
  const RequirableText(this.text, {
    super.key,
    this.style,
    this.required = true,
  });

  final String text;
  final TextStyle? style;
  final bool required;

  @override
  Widget build(BuildContext context) {
    return required
        ? RichText(
            text: TextSpan(
              text: text,
              style: style ??
                  TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[500],
                  ),
              children: const [
                TextSpan(
                  text: ' *',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          )
        : Text(
            text,
            style: style ??
                TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[500],
                ),
          );
  }
}
