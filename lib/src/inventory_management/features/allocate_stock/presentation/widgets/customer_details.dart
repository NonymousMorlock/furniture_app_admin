import 'package:benaiah_admin_app/core/extensions/iterable_extensions.dart';
import 'package:benaiah_admin_app/core/extensions/string_extensions.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/add_product/presentation/widgets/section.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/allocate_stock/entities/order.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/allocate_stock/presentation/widgets/column_pair.dart';
import 'package:flutter/material.dart';

class CustomerDetails extends StatefulWidget {
  const CustomerDetails(this.order, {super.key});

  final Order order;

  @override
  State<CustomerDetails> createState() => _CustomerDetailsState();
}

class _CustomerDetailsState extends State<CustomerDetails> {
  @override
  Widget build(BuildContext context) {
    return Section(
      title: 'Customer Details',
      children: [
        ColumnPair(top: 'Name', bottom: widget.order.customerName),
        ColumnPair(top: 'Email', bottom: widget.order.customerName.email),
        ColumnPair(
          top: 'Shipping address',
          bottom: widget.order.deliveryAddress,
        ),
        const ColumnPair(
          top: 'Billing address',
          bottom: 'Same as shipping address',
        ),
        ColumnPair(top: 'Payment', bottom: widget.order.paymentMethod),
      ].columnGap(20),
    );
    /*return FutureBuilder<Either<String, Customer>>(
      future: context.read<AllocateStockProvider>().getCustomerById(
            widget.order.customerId,
          ),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return snapshot.data!.fold(
            Text.new,
            (customer) => Section(
              children: [
                ColumnPair(top: 'Name', bottom: widget.order.customerName),
                ColumnPair(top: 'Email', bottom: customer.email),
                ColumnPair(
                  top: 'Shipping address',
                  bottom: widget.order.deliveryAddress,
                ),
                ColumnPair(
                  top: 'Billing address',
                  bottom: customer.billingAddress,
                ),
                ColumnPair(top: 'Payment', bottom: widget.order.paymentMethod),
              ].columnGap(20),
            ),
          );
        } else if (snapshot.hasError) {
          return const Text('Error');
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );*/
  }
}
