import 'package:benaiah_admin_app/core/widgets/requirable_text.dart';
import 'package:flutter/material.dart';

class InputDropdown<T> extends StatelessWidget {
  const InputDropdown({
    required this.items,
    required this.value,
    required this.label,
    this.controller,
    super.key,
    this.onChanged,
    this.labelStyle,
    this.minWidth,
    this.hint,
    this.required = true,
  });

  final TextEditingController? controller;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final T? value;
  final String label;
  final TextStyle? labelStyle;
  final double? minWidth;
  final Widget? hint;
  final bool required;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: RequirableText(
            label,
            style: labelStyle ??
                TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[500],
                ),
          ),
        ),
        const SizedBox(height: 8),
        ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: minWidth ?? 400,
            maxWidth: 600,
          ),
          child: DropdownButtonFormField<T>(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Colors.grey[300]!,
                ),
              ),
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
            hint: hint,

            dropdownColor: Colors.white,
            value: value,
            onChanged: (value) {
              if (T.runtimeType == String && value != null) {
                controller?.text = value as String;
              }
              onChanged?.call(value);
            },
            validator: (value) {
              if (required && value == null) {
                return 'This field is required';
              }
              return null;
            },
            items: items,
          ),
        ),
      ],
    );
  }
}
