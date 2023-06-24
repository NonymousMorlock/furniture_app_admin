import 'package:benaiah_admin_app/core/extensions/custom_extensions.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/add_product/presentation/widgets/section.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/allocate_stock/entities/order.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/allocate_stock/presentation/widgets/customer_details.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/allocate_stock/presentation/widgets/order_details_table.dart';
import 'package:flutter/material.dart';

class FulfillOrderView extends StatelessWidget {
  const FulfillOrderView(this.order, {super.key});

  static const routeName = '/fulfill-order';

  final Order order;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(50),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Section(
              children: [
                RichText(
                  text: TextSpan(
                    text: 'Status: ',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                    children: [
                      TextSpan(
                        text: '⚫ ${order.status.value}',
                        style: TextStyle(
                          color: order.status.colour,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Section(
                children: [OrderDetailsTable(order.products)],
              ),
            ),
            Expanded(child: CustomerDetails(order)),
          ],
        ),
      ],
    );
  }
}
