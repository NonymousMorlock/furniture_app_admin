import 'package:benaiah_admin_app/core/extensions/enum_extensions.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/add_product/presentation/app/providers/add_product_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          context.read<AddProductController>().weightUnit = value!.weightUnit;
          focusNode.requestFocus();
        },
      ),
    );
  }
}
