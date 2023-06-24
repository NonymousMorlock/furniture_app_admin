import 'dart:io';

import 'package:benaiah_admin_app/src/inventory_management/features/add_product/presentation/app/providers/images_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({
    required this.image,
    super.key,
  });

  final File image;

  @override
  Widget build(BuildContext context) {
    return Consumer<ImagesController>(
      builder: (_, controller, __) {
        return Container(
          margin: const EdgeInsets.only(right: 10),
          height: 150,
          width: 150,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(image, fit: BoxFit.cover),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  color: Colors.black.withOpacity(.5),
                ),
              ),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Theme.of(context).primaryColor,
                      ),
                      onPressed: () => controller.replace(image),
                      child: const Text('Replace'),
                    ),
                    const SizedBox(height: 5),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Theme.of(context).primaryColor,
                      ),
                      onPressed: () => controller.remove(image),
                      child: const Text('Remove'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
