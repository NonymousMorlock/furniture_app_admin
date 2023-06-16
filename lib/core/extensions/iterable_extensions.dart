import 'package:flutter/material.dart';

extension WidgetListExt on List<Widget> {
  List<Widget> columnGap(double gap) {
    final list = <Widget>[];
    for (var i = 0; i < length; i++) {
      if (i > 0) {
        list.add(SizedBox(height: gap));
      }
      list.add(this[i]);
    }
    return list;
  }

  List<Widget> rowGap(double gap) {
    final list = <Widget>[];
    for (var i = 0; i < length; i++) {
      if (i > 0) {
        list.add(SizedBox(width: gap));
      }
      list.add(this[i]);
    }
    return list;
  }

  List<Widget> get splitColumn {
    // insert a divider between each item
    final list = <Widget>[];
    for (var i = 0; i < length; i++) {
      if (i > 0) {
        list.add(const Divider(indent: 16, endIndent: 16));
      }
      list.add(this[i]);
    }
    return list;
  }

  List<Widget> get splitRow {
    // insert a divider between each item
    final list = <Widget>[];
    for (var i = 0; i < length; i++) {
      if (i > 0) {
        list.add(const VerticalDivider(indent: 16, endIndent: 16));
      }
      list.add(this[i]);
    }
    return list;
  }
}
