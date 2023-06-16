
import 'package:benaiah_admin_app/src/inventory_management/presentation/app/providers/images_controller.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImageReceiver extends StatelessWidget {
  const ImageReceiver({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ImagesController>(
      builder: (_, controller, __) {
        final colour = controller.isDragging ? Theme.of(context)
            .primaryColorLight : Colors.grey;
        return DropTarget(
          onDragEntered: (_) => controller.dragging(),
          onDragExited: (_) => controller.notDragging(),
          onDragDone: controller.processDroppedImages,
          child: Container(
            color: controller.isDragging ? colour.withOpacity(.2) : null,
            height: 150,
            width: 150,
            child: DottedBorder(
              borderType: BorderType.RRect,
              radius: const Radius.circular(10),
              dashPattern: const [5, 5],
              color: colour,
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly,
                  children: [
                    const Icon(
                      Icons.add_photo_alternate_outlined,
                      size: 30,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 5),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'Click to upload ',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          decoration: TextDecoration.underline,
                        ),
                        mouseCursor: SystemMouseCursors.click,
                        recognizer: TapGestureRecognizer()
                          ..onTap = controller.pickImages,
                        children: const [
                          TextSpan(
                            text: 'or drag and drop',
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

