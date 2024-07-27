import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.onPickImage});

  final void Function(File image) onPickImage;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage;
  void _takeImage() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedImage == null) {
      return;
    }
    setState(() {
      _selectedImage = File(pickedImage.path);
    });
    widget.onPickImage(_selectedImage!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
        onPressed: _takeImage,
        icon: const Icon(Icons.camera),
        label: const Text('Add Image'),
        style: TextButton.styleFrom(
            iconColor: const Color.fromARGB(255, 255, 255, 255)));

    if (_selectedImage != null) {
      content = Container(
        decoration: BoxDecoration(
            border:
                Border.all(width: 10, color: const Color.fromARGB(0, 0, 0, 0)),
            borderRadius: BorderRadius.circular(60)),
        child: Image.file(
          _selectedImage!,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black.withOpacity(0.3),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      height: 300,
      alignment: Alignment.center,
      child: content,
    );
  }
}
