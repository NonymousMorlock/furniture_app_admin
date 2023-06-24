import 'package:benaiah_admin_app/src/inventory_management/features/add_product/presentation/app/providers/category_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectCategoryChip extends StatelessWidget {
  const SelectCategoryChip(this.category, {super.key});

  final String category;

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryController>(
      builder: (_, controller, __) {
        return ActionChip(
          label: Text(category),
          avatar: controller.selectedCategories.contains(category)
              ? const Icon(Icons.check, color: Colors.white)
              : const Icon(Icons.add, color: Colors.black),
          backgroundColor: controller.selectedCategories.contains(category)
              ? Colors.blue
              : Colors.grey[300],
          labelStyle: TextStyle(
            color: controller.selectedCategories.contains(category)
                ? Colors.white
                : Colors.black,
          ),
          onPressed: () => controller.toggleCategory(category),
        );
      },
    );
  }
}
