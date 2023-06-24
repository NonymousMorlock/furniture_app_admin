import 'package:benaiah_admin_app/src/inventory_management/features/add_product/presentation/refactors/first_column.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/add_product/presentation/refactors/second_column.dart';
import 'package:flutter/material.dart';

class AddProductView extends StatelessWidget {
  const AddProductView({super.key});

  static const routeName = '/add-product';

  @override
  Widget build(BuildContext context) {
    // gridview arranges children vertically and if vertical space runs out,
    // it goes to the next column
    return ListView(
      padding: const EdgeInsets.all(20),
      shrinkWrap: true,
      children: const [
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: FirstColumn()),
              SizedBox(width: 20),
              Expanded(child: SecondColumn()),
            ],
          ),
        ),
      ],
    );
  }
}
