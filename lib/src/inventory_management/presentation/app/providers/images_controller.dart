import 'dart:io';

import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class ImagesController extends ChangeNotifier {
  final List<File> _images = [];

  List<File> get images => _images;

  bool _isDragging = false;

  bool get isDragging => _isDragging;

  void dragging() {
    _isDragging = true;
    notifyListeners();
  }

  void notDragging() {
    _isDragging = false;
    notifyListeners();
  }

  void add(XFile image) {
    final file = File(image.path);
    if(!imageExtensions.contains(file.path.split('.').last)) return;
    if(_images.length < 5) {
      if(!_images.any((element) => element.path == file.path)) {
        _images.add(file);
      }
    }
    notifyListeners();
  }

  void remove(File image) {
    _images.removeWhere((file) => file.path == image.path);
    notifyListeners();
  }

  Future<void> replace(File oldImage) async {
    final newImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(newImage == null) return;
    final file = File(newImage.path);
    _images[_images.indexWhere((element) => element.path == oldImage.path)] =
        file;
    notifyListeners();
  }

  void clear() {
    _images.clear();
    notifyListeners();
  }
  
  void processDroppedImages(DropDoneDetails details) {
    for (final image in details.files) {
      if (_images.length < 5) {
        add(image);
      } else {
        break;
      }
    }
  }

  Future<void> pickImages() async {
    final images = await ImagePicker().pickMultiImage();
    for (final image in images) {
      if (_images.length < 5) {
        add(image);
      } else {
        break;
      }
    }
  }

  static const imageExtensions = [
    'jpg',
    'jpeg',
    'png',
    'gif',
    'webp',
    'bmp',
    'wbmp',
    'svg',
    'svgz',
  ];
}
