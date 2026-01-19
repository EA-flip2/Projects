import 'dart:io';
import 'package:assets/models/asset_object.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageBox extends StatefulWidget {
  const ImageBox({
    required this.description,
    required this.mapKey,
    required this.passImage,
    super.key,
  });

  final String description;
  final String mapKey;
  final void Function(String mapKey, AssetDataObject asset) passImage;

  @override
  State<ImageBox> createState() => _ImageBoxState();
}

class _ImageBoxState extends State<ImageBox> {
  File? _selectedImage;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: source,
      maxWidth: 600,
    );

    if (pickedImage == null) return;

    setState(() {
      _selectedImage = File(pickedImage.path);
    });

    widget.passImage(
      widget.mapKey,
      AssetDataObject(image: _selectedImage!, description: widget.description),
    );
  }

  void _showImageSourcePicker() {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Take photo'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Choose from gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showImageSourcePicker,
      child: Container(
        padding: EdgeInsets.all(16),
        height: 220,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: _selectedImage == null
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.camera_alt, size: 32),
                  const SizedBox(height: 8),
                  Text(widget.description),
                ],
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(
                  _selectedImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
      ),
    );
  }
}


  // Future<void> _takePicture() async {
  //   final picker = ImagePicker();
  //   final pickedImage = await picker.pickImage(
  //     source: ImageSource.camera,
  //     maxWidth: 600,
  //   );

  //   if (pickedImage == null) return;

  //   setState(() {
  //     _selectedImage = File(pickedImage.path);
  //   });
  //   widget.passImage(
  //     widget.mapKey,
  //     AssetDataObject(image: _selectedImage!, description: widget.description),
  //   );
  // }