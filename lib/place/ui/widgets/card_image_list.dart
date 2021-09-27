import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:platzi_trips_app/user/bloc/bloc_user.dart';
import 'card_image.dart';

class CardImageList extends StatelessWidget {
  //

  UserBloc userBloc;

  @override
  Widget build(BuildContext context) {
    //
    userBloc = BlocProvider.of<UserBloc>(context);

    return Container(
      height: 350.0,
      child: StreamBuilder(
        stream: userBloc.placesStream,
        // ignore: missing_return
        builder: (context, AsyncSnapshot snapshot) {
          //
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            case ConnectionState.none:
              return CircularProgressIndicator();
            case ConnectionState.active:
              return listViewPlaces(userBloc.buildPlaces(snapshot.data.docs));
            case ConnectionState.done:
              return listViewPlaces(userBloc.buildPlaces(snapshot.data.docs));

            default:
          }
        },
      ),
    );
  }

  Widget listViewPlaces(List<CardImage> placesCard) {
    //
    return ListView(
      padding: EdgeInsets.all(25.0),
      scrollDirection: Axis.horizontal,
      children: placesCard,
    );
  }
}
