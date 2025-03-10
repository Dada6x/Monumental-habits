// import 'dart:io';
// import 'package:image_picker/image_picker.dart';
// import 'package:flutter/material.dart';

// class ImagePickerService {
//   final ImagePicker _picker = ImagePicker();

//   Future<File?> pickImage(BuildContext context) async {
//     final XFile? pickedFile = await showModalBottomSheet<XFile?>(
//       context: context,
//       builder: (context) => _imagePickerOptions(context),
//     );

//     return pickedFile != null ? File(pickedFile.path) : null;
//   }

//   Widget _imagePickerOptions(BuildContext context) {
//     return Wrap(
//       children: [
//         ListTile(
//           leading: const Icon(Icons.camera),
//           title: const Text("Take Photo"),
//           onTap: () async {
//             final pickedFile = await _picker.pickImage(source: ImageSource.camera);
//             Navigator.pop(context, pickedFile);
//           },
//         ),
//         ListTile(
//           leading: const Icon(Icons.image),
//           title: const Text("Choose from Gallery"),
//           onTap: () async {
//             final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//             Navigator.pop(context, pickedFile);
//           },
//         ),
//       ],
//     );
//   }
// }
