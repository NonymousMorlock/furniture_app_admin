import 'package:benaiah_admin_app/src/inventory_management/features/add_product/presentation/app/providers/images_controller.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/add_product/presentation/widgets/image_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Images extends StatefulWidget {
  const Images({super.key});

  @override
  State<Images> createState() => _ImagesState();
}

class _ImagesState extends State<Images> {
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Consumer<ImagesController>(
      builder: (_, controller, __) {
        return SizedBox(
          height: 150,
          child: Scrollbar(
            controller: scrollController,
            thumbVisibility: true,
            trackVisibility: true,
            child: ListView.builder(
              controller: scrollController,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: controller.images.length,
              itemBuilder: (_, index) => ImageCard(
                image: controller.images[index],
              ),
            ),
          ),
        );
      },
    );
  }
}
