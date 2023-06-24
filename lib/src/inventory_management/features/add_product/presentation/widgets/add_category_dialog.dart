import 'package:benaiah_admin_app/core/components/category.dart';
import 'package:benaiah_admin_app/core/extensions/context_extensions.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/add_product/presentation/app/providers/category_controller.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/add_product/presentation/widgets/select_category_chip.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddCategoryDialog extends StatelessWidget {
  const AddCategoryDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      type: MaterialType.transparency,
      child: Stack(
        children: [
          Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: context.width * 0.5,
                maxHeight: context.height * 0.5,
              ),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: allCategory.map(SelectCategoryChip.new).toList(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Done'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                        },
                        child: const Text('Add Category'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton.outlined(
              onPressed: () {
                context.read<CategoryController>().clear();
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close, color: Colors.white, size: 50),
            ),
          ),
        ],
      ),
    );
  }
}
