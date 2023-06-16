import 'package:benaiah_admin_app/core/extensions/iterable_extensions.dart';
import 'package:benaiah_admin_app/core/widgets/input_field.dart';
import 'package:benaiah_admin_app/src/inventory_management/presentation/app/providers/category_controller.dart';
import 'package:benaiah_admin_app/src/inventory_management/presentation/widgets/add_category_dialog.dart';
import 'package:benaiah_admin_app/src/inventory_management/presentation/widgets/section.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class FirstColumn extends StatelessWidget {
  const FirstColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Section>[
        Section(
          title: 'Description',
          children: const [
            InputField(
              label: 'Product Name',
              hintText: 'Enter product name',
            ),
            InputField(
              label: 'Product Description',
              hintText: 'Enter product description',
              expandable: true,
            ),
          ].columnGap(20),
        ),
        Section(
          title: 'Categories',
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // I'm thinking onTap, we popup a menu with checkboxes, and
            // the user can select multiple categories, also add a button
            // for adding new categories
            TextButton.icon(
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColorLight,
              ),
              onPressed: () {
                final controller = context.read<CategoryController>();
                showGeneralDialog(
                  context: context,
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      ChangeNotifierProvider.value(
                    value: controller,
                    child: ScaleTransition(
                      scale: animation,
                      child: const AddCategoryDialog(),
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('Add Category'),
            ),
            const SizedBox(height: 10),
            ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: 400,
                maxWidth: 600,
              ),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: context
                    .watch<CategoryController>()
                    .selectedCategories
                    .map(
                      (category) => Chip(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(90),
                        ),
                        backgroundColor: Theme.of(context).primaryColor,
                        label: Text(category),
                        deleteIcon: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Icon(
                            Icons.close,
                            size: 15,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        onDeleted: () {
                          context
                              .read<CategoryController>()
                              .removeCategory(category);
                        },
                        labelStyle: const TextStyle(color: Colors.white),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
        Section(
          title: 'Inventory',
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InputField(
                  label: 'Quantity',
                  maxWidth: 200,
                  minWidth: 100,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
                const SizedBox(width: 20),
                Flexible(
                  child: InputField(
                    label: 'SKU(Optional)',
                    required: false,
                    maxWidth: 400,
                    minWidth: 100,
                    inputFormatters: [
                      // convert to uppercase
                      TextInputFormatter.withFunction((oldValue, newValue) {
                        return TextEditingValue(
                          text: newValue.text.toUpperCase(),
                          selection: newValue.selection,
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        Section(
          title: 'Availability',
          children: [
            SizedBox(
              width: 200,
              child: CheckboxListTile(
                value: false,
                onChanged: (value) {},
                title: const Text('In-Store Only'),
              ),
            ),
            SizedBox(
              width: 200,
              child: CheckboxListTile(
                value: false,
                onChanged: (value) {},
                title: const Text('Online Only'),
              ),
            ),
            SizedBox(
              width: 200,
              child: CheckboxListTile(
                value: false,
                onChanged: (value) {},
                title: const Text('In-Store and Online'),
              ),
            ),
          ],
        ),
      ].columnGap(35),
    );
  }
}
