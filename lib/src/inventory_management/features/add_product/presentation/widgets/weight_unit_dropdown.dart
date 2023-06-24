import 'package:flutter/material.dart';

class WeightUnitDropdown extends StatelessWidget {
  const WeightUnitDropdown({
    required this.controller,
    required this.focusNode,
    super.key,
  });

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        dropdownColor: Colors.white,
        items: const [
          DropdownMenuItem(
            value: 'kg',
            child: Text('Kg'),
          ),
          DropdownMenuItem(
            value: 'g',
            child: Text('g'),
          ),
        ],
        onChanged: (value) {
          controller.text = value.toString();
          focusNode.requestFocus();
        },
      ),
    );
  }
}
