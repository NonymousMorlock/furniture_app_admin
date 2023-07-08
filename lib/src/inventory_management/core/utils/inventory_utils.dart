import 'package:benaiah_admin_app/core/extensions/context_extensions.dart';
import 'package:benaiah_admin_app/core/utils/core_utils.dart';
import 'package:benaiah_admin_app/src/inventory_management/core/app/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InventoryUtils {
  const InventoryUtils._();

  static bool showingDialog = false;

  static void listen(BuildContext context, {String? successMessage}) {
    final provider = context.read<ProductProvider>();
    provider.addListener(() {
      if (provider.isLoading) {
        showingDialog = true;
        showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      } else {
        if(showingDialog) {
          Navigator.of(context).pop();
          showingDialog = false;
        }
        if (provider.productAdded) {
          CoreUtils.showSuccessAlert(
            message: successMessage ?? 'Product added successfully',
          ).then((_) {
            context.pop();
            return;
          });
        }
      }
      if (provider.errorMessage != null) {
        CoreUtils.showErrorAlert(message: provider.errorMessage!);
        provider.resetError();
      }
    });
  }
}
