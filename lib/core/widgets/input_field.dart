import 'package:benaiah_admin_app/core/widgets/requirable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputField extends StatelessWidget {
  const InputField({
    required this.label,
    super.key,
    this.labelStyle,
    this.minWidth,
    this.required = true,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.useLabelAsHint = false,
    this.expandable = false,
    this.controller,
    this.inputFormatters,
    this.maxWidth,
    this.prefixText,
    this.suffixText,
    this.focusNode,
  });

  final String label;
  final TextStyle? labelStyle;
  final TextEditingController? controller;
  final double? minWidth;
  final bool required;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool useLabelAsHint;
  final bool expandable;
  final List<TextInputFormatter>? inputFormatters;
  final double? maxWidth;
  final String? prefixText;
  final String? suffixText;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: RequirableText(
            label,
            required: required,
            style: labelStyle ??
                TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[500],
                ),
          ),
        ),
        const SizedBox(height: 5),
        ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: minWidth ?? 400,
            maxWidth: maxWidth ?? 600,
          ),
          child: TextFormField(
            minLines: expandable ? 1 : null,
            maxLines: expandable ? 5 : 1,
            controller: controller,
            focusNode: focusNode,
            decoration: InputDecoration(
              hintText: useLabelAsHint ? label : hintText,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Colors.grey[300]!,
                ),
              ),
              prefixText: prefixText,
              suffixText: suffixText,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Colors.grey[300]!,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            inputFormatters: inputFormatters,
            validator: (value) {
              if (required && value!.isEmpty) {
                return 'This field is required';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
