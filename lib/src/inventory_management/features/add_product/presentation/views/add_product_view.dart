import 'package:benaiah_admin_app/src/inventory_management/core/utils/inventory_utils.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/add_product/presentation/app/providers/add_product_controller.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/add_product/presentation/refactors/first_column.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/add_product/presentation/refactors/second_column.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddProductView extends StatefulWidget {
  const AddProductView({super.key});

  static const routeName = '/add-product';

  @override
  State<AddProductView> createState() => _AddProductViewState();
}

class _AddProductViewState extends State<AddProductView> {
  @override
  void initState() {
    super.initState();
    InventoryUtils.listen(context);
  }

  @override
  Widget build(BuildContext context) {
    // gridview arranges children vertically and if vertical space runs out,
    // it goes to the next column
    return ListView(
      padding: const EdgeInsets.all(20),
      shrinkWrap: true,
      children: [
        Center(
          child: Form(
            key: context.read<AddProductController>().formKey,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: FirstColumn()),
                SizedBox(width: 20),
                Expanded(child: SecondColumn()),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
