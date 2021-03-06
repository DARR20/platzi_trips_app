import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:platzi_trips_app/user/bloc/bloc_user.dart';
import 'package:platzi_trips_app/user/model/user.dart' as Model;
import 'profile_header.dart';
import 'package:platzi_trips_app/user/ui/widgets/profile_places_list.dart';
import 'package:platzi_trips_app/user/ui/widgets/profile_background.dart';

class ProfileTrips extends StatelessWidget {
  //
  UserBloc userBloc;

  @override
  Widget build(BuildContext context) {
    //
    userBloc = BlocProvider.of<UserBloc>(context);

    return StreamBuilder(
      stream: userBloc.authStatus,
      // ignore: missing_return
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        //
        switch (snapshot.connectionState) {
          //
          case ConnectionState.waiting:
            return CircularProgressIndicator();

          case ConnectionState.none:
            return CircularProgressIndicator();

          case ConnectionState.active:
            return showProfileData(snapshot);

          case ConnectionState.done:
            return showProfileData(snapshot);

          default:
        }
      },
    );
  }

  Widget showProfileData(AsyncSnapshot snapshot) {
    //
    if (!snapshot.hasData || snapshot.hasError) {
      //

      Stack(
        children: <Widget>[
          ProfileBackground(),
          ListView(
            children: <Widget>[
              Text('Usuario no logeado. Haz Login'),
            ],
          ),
        ],
      );
    } else {
      var user = Model.User(
        uid: snapshot.data.uid,
        name: snapshot.data.displayName,
        email: snapshot.data.email,
        photoURL: snapshot.data.photoURL,
      );

      return Stack(
        children: <Widget>[
          ProfileBackground(),
          ListView(
            children: <Widget>[
              ProfileHeader(
                user: user,
              ),
              ProfilePlacesList(
                user: user,
              ),
            ],
          ),
        ],
      );
    }
  }
}
