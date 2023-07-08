import 'package:benaiah_admin_app/src/dashboard/presentation/app/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

extension ContextExt on BuildContext {
  ResponsiveBreakpointsData get currentBreakpoint =>
      ResponsiveBreakpoints.of(this);

  Size get size => MediaQuery.of(this).size;

  double get width => size.width;

  double get height => size.height;

  TextTheme get textTheme => Theme.of(this).textTheme;

  DashboardController get navigator => read<DashboardController>();

  void push(String routeName, {Object? arguments}) =>
      navigator.push(routeName, arguments: arguments);

  void pop({Object? arguments}) => navigator.pop(arguments: arguments);
}
