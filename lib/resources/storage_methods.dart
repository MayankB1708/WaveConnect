import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //add image to firebase storage
  Future<String> uploadImagetoStorage(
      String childname, Uint8List file, bool isPost) async {
    Reference ref =
        _storage.ref().child(childname).child(_auth.currentUser!.uid);

    // with this uploadtask we have the ability to control how the file is being uploaded to the firebase storage.
    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snap = await uploadTask;
    Future<String> downloadurl = snap.ref.getDownloadURL(); // this will fetch the download url to the file which is being uploaded
    //the url will be stored in the  firestore database

    return downloadurl;
  }
}
