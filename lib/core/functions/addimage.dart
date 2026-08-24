import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

Future<File?> uploadImage() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['svg', 'jpg', 'jpeg', 'png', 'gif'],
    allowMultiple: false,
  );

  if (result != null) {
    String? tempPath = result.files.single.path;
    if (tempPath != null) {
      File tempFile = File(tempPath);

      Directory appDocDir = await getApplicationDocumentsDirectory();
      String newPath = join(appDocDir.path, basename(tempPath));
      File copiedFile = await tempFile.copy(newPath);

      return copiedFile;
    }
  }

  return null;
}

Future<File?> pickImageFromCamera() async {
  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: ImageSource.camera);

  if (image != null) {
    return File(image.path);
  } else {
    return null;
  }
}

Future<File?> cropImageWithRatio(
    File file, double x, double y, String title) async {
  final croppedFile = await ImageCropper().cropImage(
    sourcePath: file.path,
    aspectRatio: CropAspectRatio(ratioX: x, ratioY: y),
    compressFormat: ImageCompressFormat.jpg,
    uiSettings: [
      AndroidUiSettings(
        toolbarTitle: title,
        lockAspectRatio: true,
      ),
      IOSUiSettings(
        title: title,
        aspectRatioLockEnabled: true,
      ),
    ],
  );

  if (croppedFile != null) {
    return File(croppedFile.path);
  }

  return null;
}
