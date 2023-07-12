import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

mixin PickMediaMixin {
  final ImagePicker _imagePicker = ImagePicker();
  Future<Uint8List?> pickSingleImage(ImageSource imageSource) async {
    try {
      final result = await _imagePicker.pickImage(
          source: imageSource, maxWidth: 420, maxHeight: 186);

      if (result == null) {
        return null;
      } else {
        return result.readAsBytes();
      }
    } on PlatformException catch (err) {
      print(err);
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<List<Uint8List>?> pickMultiImage() async {
    try {
      final result = await _imagePicker.pickMultiImage();

      if (result.isEmpty) {
        return null;
      } else if (result.isNotEmpty) {
        return List<Uint8List>.from(result.map((e) => e.readAsBytes()));
      }
    } on PlatformException catch (err) {
      print(err);
    } catch (e) {
      print(e);
    }
    return null;
  }
}
