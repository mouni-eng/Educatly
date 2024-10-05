import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class FileService {
  uploadFile({
    required File image,
    required String header,
  }) async {
    var ref = FirebaseStorage.instanceFor(bucket: "gs://educatly-d6fbc.appspot.com")
        .ref()
        .child('$header/${Uri.file(image.path).pathSegments.last}');
    await ref.putFile(image);
    String imageUrl = await ref.getDownloadURL();
    return imageUrl;
  }

  uploadMultipleFile({
    required List<File> images,
    required String header,
  }) async {
    List<String> imagesUrl = [];
    for (var image in images) {
      var ref = FirebaseStorage.instance
          .ref()
          .child('$header/${Uri.file(image.path).pathSegments.last}');
      await ref.putFile(image);
      String imageUrl = await ref.getDownloadURL();
      imagesUrl.add(imageUrl);
    }
    return imagesUrl;
  }
}
