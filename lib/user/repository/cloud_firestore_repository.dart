import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:platzi_trips_app/place/model/place.dart';
import 'package:platzi_trips_app/user/model/user.dart';
import 'package:platzi_trips_app/user/repository/cloud_firestore_api.dart';
import 'package:platzi_trips_app/user/ui/widgets/profile_place.dart';

class CloudFirestoriRepository {
  //
  final _cloudFirestoreAPI = CloudFirestoreAPI();

  void updateUserDataFirestore(User user) =>
      _cloudFirestoreAPI.updateUserData(user);

  Future<void> updatePlaceData(Place place) =>
      _cloudFirestoreAPI.updatePlaceData(place);

  List<ProfilePlace> buildPlaces(List<DocumentSnapshot> placesListSnapshot) =>
      _cloudFirestoreAPI.buildPlaces(placesListSnapshot);
}
