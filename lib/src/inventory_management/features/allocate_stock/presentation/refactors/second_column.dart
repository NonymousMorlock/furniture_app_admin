
import 'package:benaiah_admin_app/core/extensions/iterable_extensions.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/allocate_stock/entities/order.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/allocate_stock/presentation/widgets/customer_details.dart';
import 'package:flutter/material.dart';

class SecondColumn extends StatelessWidget {
  const SecondColumn(this.order, {super.key});

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomerDetails(order),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColorDark,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {},
          child: const Text('Fulfill Order'),
        ),
      ].columnGap(35),
    );
  }
}
