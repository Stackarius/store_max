import 'package:image_picker/image_picker.dart';

class ImageHelper {
  final ImagePicker _picker = ImagePicker();

  Future<String?> pickImageFromCamera() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 70,
    );

    return image?.path;
  }

  Future<String?> pickImageFromGallery() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );
    return image?.path;
  }
}
