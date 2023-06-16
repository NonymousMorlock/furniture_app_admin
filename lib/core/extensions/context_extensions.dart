
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

extension ContextExt on BuildContext {
  ResponsiveBreakpointsData get currentBreakpoint =>
      ResponsiveBreakpoints.of(this);

  Size get size => MediaQuery.of(this).size;

  double get width => size.width;

  double get height => size.height;

  TextTheme get textTheme => Theme.of(this).textTheme;
}
