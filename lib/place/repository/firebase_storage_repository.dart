import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:platzi_trips_app/place/repository/firebase_storage_api.dart';

class FirebaseStorageRepository {
  //
  final Reference FirebaseStorageAPI = FirebaseStorage.instance.ref();

  Future<UploadTask> uploadFile(String path, File image) async {
    // path, directory where to save
    // image, real file to store

    return Future.value(FirebaseStorageAPI.child(path).putFile(image));
  }
}
