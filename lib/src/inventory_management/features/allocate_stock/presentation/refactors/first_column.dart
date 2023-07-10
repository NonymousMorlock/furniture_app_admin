
import 'package:benaiah_admin_app/core/extensions/double_extensions.dart';
import 'package:benaiah_admin_app/core/extensions/iterable_extensions.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/add_product/presentation/widgets/section.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/allocate_stock/entities/order.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/allocate_stock/presentation/widgets/order_details_table.dart';
import 'package:flutter/material.dart';

class FirstColumn extends StatelessWidget {
  const FirstColumn(this.order, {super.key});

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Section(
          title: 'Order Details',
          children: [OrderDetailsTable(order.products)],
        ),
        Section(
          title: 'Paid by Customer',

          children: [
            RichText(
              text: TextSpan(
                text: 'Total: ',
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
                children: [
                  TextSpan(
                    text: order.totalPrice.currencyFormat,
                    style: const TextStyle(
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                text: 'Paid: ',
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
                children: [
                  TextSpan(
                    text: 0.0.currencyFormat,
                    style: const TextStyle(
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                text: 'Due: ',
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
                children: [
                  TextSpan(
                    text: order.totalPrice.currencyFormat,
                    style: const TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ].columnGap(35),
    );
  }
}
