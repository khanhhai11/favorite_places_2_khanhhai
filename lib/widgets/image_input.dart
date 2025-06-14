import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:localstorage/localstorage.dart';
import 'package:dotted_border/dotted_border.dart';
class ImageInput extends StatefulWidget {
  const ImageInput({super.key});
  @override
  State<ImageInput> createState() => _ImageInputState();
}
class _ImageInputState extends State<ImageInput> {
  final LocalStorage storage = LocalStorage('image_storage');
  Widget content = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(Icons.camera, color: Color(0xFFB7A7E7)),
      SizedBox(width: 5),
      Text(
        'Take Picture',
        style: TextStyle(
          color: Color(0xFFB7A7E7),
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    ],
  );
  Uint8List? webImageBytes;
  @override
  void initState() {
    super.initState();
  }
  Future<void> loadImageFromLocalStorage(String name) async {
    await storage.ready;
    final base64String = storage.getItem(name);
    if (base64String != null) {
      setState(() {
        webImageBytes = base64Decode(base64String);
        content = Image.memory(webImageBytes!);
      });
    }
  }
  Future<File> saveImagePermanently(XFile image) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(image.path);
    final newPath = '${directory.path}/$name';
    return File(image.path).copy(newPath);
  }
  Future<void> pickAndSaveImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      if (kIsWeb) {
        final bytes = await pickedImage.readAsBytes();
        final base64String = base64Encode(bytes);
        await storage.ready;
        await storage.setItem(pickedImage.name, base64String);
        setState(() {
          webImageBytes = bytes;
          content = Image.memory(webImageBytes!);
        });
      } else {
        final savedImage = await saveImagePermanently(pickedImage);
        setState(() {
          content = Image.file(savedImage);
        });
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Stack(
        children: [
          DottedBorder(
            color: Color(0xFFDED9E1),
            strokeWidth: 2,
            borderType: BorderType.RRect,
            radius: Radius.circular(8),
            child: InkWell(
              onTap: () async {
                await pickAndSaveImage();
              },
              child: Container(
                child: content,
                height: 250,
                alignment: Alignment.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}