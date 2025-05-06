import 'package:image_picker/image_picker.dart';

Future<XFile?> getImageFromGallery() async {
  return await ImagePicker().pickImage(source: ImageSource.gallery);
}
