
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class imagePicker extends GetxController {
  RxString imagePath = ''.obs;

  Future getImage() async {
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      imagePath.value = image.path.toString();
      return image;
    }
  }
}