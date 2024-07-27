import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({super.key, required this.onPickedImage});

  final void Function(File pickedImage) onPickedImage;

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImageFile;

  void _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
        maxWidth: 150,
        maxHeight: 150);

    if (pickedImage == null) {
      return;
    }

    setState(() {
      _pickedImageFile = File(pickedImage.path);
    });
    widget.onPickedImage(_pickedImageFile!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CircleAvatar(
        radius: 40,
        backgroundImage: const NetworkImage(
            'https://th.bing.com/th/id/OIP.TG24uFZXNv6edpv3lEnpIwAAAA?rs=1&pid=ImgDetMain/200/300'),
        foregroundImage:
            _pickedImageFile != null ? FileImage(_pickedImageFile!) : null,
      ),
      TextButton.icon(
        onPressed: () {
          _pickImage();
        },
        label: const Text(
          'Add Image',
          style: TextStyle(fontSize: 16, color: Colors.blue),
        ),
      )
    ]);
  }
}
