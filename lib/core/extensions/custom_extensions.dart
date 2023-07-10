
import 'dart:ui';

import 'package:benaiah_admin_app/core/enums/order_status_enum.dart';

extension OrderStatusExt on OrderStatus {
  Color get colour {
    switch(this) {
      case OrderStatus.pending:
        return const Color(0xFF9E9E9E);
      case OrderStatus.processing:
        return const Color(0xFF2563EB);
      case OrderStatus.shipped:
        return const Color(0xFFFBBF24);
      case OrderStatus.delivered:
        return const Color(0xFF10B981);
      case OrderStatus.outForDelivery:
        return const Color(0xFF7C3AED);
      case OrderStatus.cancelled:
        return const Color(0xFFEF4444);
    }
  }

  Color get colourLight {
    switch(this) {
      case OrderStatus.pending:
        return const Color(0xFFE0E0E0);
      case OrderStatus.processing:
        return const Color(0xFFD1E3FE);
      case OrderStatus.shipped:
        return const Color(0xFFFFF3C4);
      case OrderStatus.delivered:
        return const Color(0xFFD1FAE5);
      case OrderStatus.outForDelivery:
        return const Color(0xFFEDE9FE);
      case OrderStatus.cancelled:
        return const Color(0xFFFEE2E2);
    }
  }
}
