import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:platzi_trips_app/place/model/place.dart';
import 'package:platzi_trips_app/user/model/user.dart' as Model;
import 'package:platzi_trips_app/user/ui/widgets/profile_place.dart';

class CloudFirestoreAPI {
  //
  final String USERS = "users";
  final String PLACES = "places";

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> updateUserData(Model.User user) async {
    DocumentReference ref = _db.collection(USERS).doc(user.uid);
    return await ref.set({
      'uid': user.uid,
      'name': user.name,
      'email': user.email,
      'photoURL': user.photoURL,
      'myPlaces': user.myPlaces,
      'myFavoritePlaces': user.myFavoritePlaces,
      'lastSignIn': DateTime.now()
    }, SetOptions(merge: true));
  }

  Future<void> updatePlaceData(Place place) async {
    CollectionReference refPlaces = _db.collection(PLACES);
    String uid = (await _auth.currentUser).uid;
    await refPlaces.add({
      'name': place.name,
      'description': place.description,
      'likes': place.likes,
      'userOwner': _db.doc("$USERS/$uid"), //reference
      'urlImage': place.urlImage,
    }).then((DocumentReference dr) {
      dr.get().then((DocumentSnapshot snapshot) {
        snapshot.id; // ID place REFERENCIA ARRAY
        DocumentReference refUsers = _db.collection(USERS).doc(uid);
        refUsers.update({
          'myPlaces': FieldValue.arrayUnion([_db.doc("$USERS/${snapshot.id}")]),
        });
      });
    });
  }

  List<ProfilePlace> buildPlaces(List<DocumentSnapshot> placesListSnapshot) {
    //
    List<ProfilePlace> profilePlaces = [];

    placesListSnapshot.forEach((p) {
      //
      profilePlaces.add(
        ProfilePlace(
          Place(
            name: p['name'],
            description: p['description'],
            urlImage: p['urlImage'],
          ),
        ),
      );
    });

    return profilePlaces;
  }
}
