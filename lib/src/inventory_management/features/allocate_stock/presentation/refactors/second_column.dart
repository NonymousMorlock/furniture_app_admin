import 'package:benaiah_admin_app/core/enums/order_status_enum.dart';
import 'package:benaiah_admin_app/core/extensions/context_extensions.dart';
import 'package:benaiah_admin_app/core/extensions/iterable_extensions.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/allocate_stock/entities/order.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/allocate_stock/models/order_model.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/allocate_stock/presentation/app/allocate_stock_provider.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/allocate_stock/presentation/views/fulfill_order_view.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/allocate_stock/presentation/widgets/customer_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SecondColumn extends StatelessWidget {
  const SecondColumn(this.order, {super.key});

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomerDetails(order),
        if (order.status == OrderStatus.pending)
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
            onPressed: () {
              final newOrder = (order as OrderModel)
                  .copyWith(status: OrderStatus.outForDelivery);
              context
                  .read<AllocateStockProvider>()
                  .fulfillOrder(order as OrderModel);

              context.pushReplacement(
                FulfillOrderView.routeName,
                arguments: newOrder,
              );
            },
            child: const Text('Fulfill Order'),
          )
      ].columnGap(35),
    );
  }
}
