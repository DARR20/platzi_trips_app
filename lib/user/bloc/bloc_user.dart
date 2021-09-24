import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:platzi_trips_app/place/model/place.dart';
import 'package:platzi_trips_app/place/repository/firebase_storage_repository.dart';
import 'package:platzi_trips_app/user/model/user.dart' as Model;
import 'package:platzi_trips_app/user/repository/auth_repository.dart';
import 'package:platzi_trips_app/user/repository/cloud_firestore_api.dart';
import 'package:platzi_trips_app/user/repository/cloud_firestore_repository.dart';
import 'package:platzi_trips_app/user/ui/widgets/profile_place.dart';

class UserBloc implements Bloc {
//

  final _auth_repository = AuthRepository();
  FirebaseAuth auth;

  //Flujo de  datos - Streams
  //Stream - Firebase
  Stream<User> streamFirebase = FirebaseAuth.instance.authStateChanges();

  Stream<User> get authStatus => streamFirebase;

  Future<User> get currentUser async => await FirebaseAuth.instance.currentUser;

  //Casos de uso
  //1. SignIn a la aplicación Google
  Future<UserCredential> signIn() => _auth_repository.signInFirebase();

  //2. Registrar usuario en base de datos
  final _cloudFirestoreRepository = CloudFirestoriRepository();

  void updateUserData(Model.User user) =>
      _cloudFirestoreRepository.updateUserDataFirestore(user);

  Future<void> updatePlaceData(Place place) =>
      _cloudFirestoreRepository.updatePlaceData(place);

  Stream<QuerySnapshot> placesListStream = FirebaseFirestore.instance
      .collection(CloudFirestoreAPI().PLACES)
      .snapshots();
  Stream<QuerySnapshot> get placesStream => placesListStream;

  List<ProfilePlace> buildPlaces(List<DocumentSnapshot> placesListSnapshot) =>
      _cloudFirestoreRepository.buildPlaces(placesListSnapshot);

  final _firebaseStorageRepository = FirebaseStorageRepository();

  Future<UploadTask> uploadFile(String path, File image) =>
      _firebaseStorageRepository.uploadFile(path, image);

  singOut() {
    _auth_repository.signOut();
  }

  @override
  void dispose() {
    //
  }
}
