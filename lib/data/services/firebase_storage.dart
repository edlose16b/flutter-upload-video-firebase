import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FireBaseStorageService {
  StorageUploadTask uploadFile(String uniqueName, File file) {
    StorageReference reference =
        FirebaseStorage.instance.ref().child(uniqueName);

    return reference.putFile(file);
  }
}
