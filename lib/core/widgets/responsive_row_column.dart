import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class VerticallyWrapColumnsRenderObject extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, _VerticalWrapParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, _VerticalWrapParentData> {
  VerticallyWrapColumnsRenderObject({
    required this.spacing,
    required this.screenWidth,
  });

  double spacing;
  double screenWidth;

  @override
  void performLayout() {
    final constraints = this.constraints;
    final columnWidth = constraints.maxWidth;
    final columnHeight = constraints.maxHeight;

    var currentX = 0.0;
    var currentY = 0.0;
    var maxChildHeight = 0.0;
    var maxColumnWidth = 0.0;

    var child = firstChild;
    var columnCount = 1;

    while (child != null) {
      child.layout(BoxConstraints(maxWidth: columnWidth), parentUsesSize: true);
      final childHeight = child.size.height;

      if (currentY + childHeight > columnHeight) {
        final newColumnWidth = maxColumnWidth + spacing + child.size.width;

        if (currentX + newColumnWidth > screenWidth) {
          // Exceeded the screen width, replace with a scrollable column
          final listViewChildren =
          getChildrenAsList().sublist(columnCount - 1).map<Widget>((box) {
            return RepaintBoundary(child: box as Widget);
          }).toList();

          final listView = RenderViewport(
            crossAxisDirection: AxisDirection.right,
            offset: ViewportOffset.zero(),
            children: listViewChildren.map<RenderSliver>((child) {
              return RenderSliverToBoxAdapter(child: child as RenderBox);
            }).toList(),
          );

          final listViewParentData = _VerticalWrapParentData();
          listView.parentData = listViewParentData;
          listViewParentData.offset = Offset.zero;

          // Replace the remaining children with the ListView
          while (child != null) {
            final nextChild = childAfter(child);
            dropChild(child);
            child = nextChild;
          }

          adoptChild(listView);
          break;
        } else {
          currentX += maxColumnWidth + spacing;
          currentY = 0;
          maxChildHeight = 0;
          maxColumnWidth = 0;
          columnCount++;
        }
      }

      final childParentData = (child.parentData! as _VerticalWrapParentData)
        ..offset = Offset(currentX, currentY);

      currentY += childHeight + spacing;
      maxChildHeight =
      maxChildHeight > childHeight ? maxChildHeight : childHeight;
      maxColumnWidth =
      maxColumnWidth > child.size.width ? maxColumnWidth : child.size.width;

      child = childParentData.nextSibling;
    }

    final contentWidth = currentX + maxColumnWidth;
    final contentHeight = columnHeight;

    size = constraints.constrain(Size(contentWidth, contentHeight));
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    defaultPaint(context, offset);
  }

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! _VerticalWrapParentData) {
      child.parentData = _VerticalWrapParentData();
    }
  }
}

class _VerticalWrapParentData extends ContainerBoxParentData<RenderBox> {}

class ResponsiveRowColumn extends MultiChildRenderObjectWidget {
  const ResponsiveRowColumn({
    required super.children,
    required this.spacing,
    required this.screenWidth,
    super.key,
  });

  final double spacing;
  final double screenWidth;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return VerticallyWrapColumnsRenderObject(
      spacing: spacing,
      screenWidth: screenWidth,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, VerticallyWrapColumnsRenderObject renderObject) {
    renderObject
      ..spacing = spacing
      ..screenWidth = screenWidth;
  }
}
