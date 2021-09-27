import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:platzi_trips_app/place/model/place.dart';
import 'package:platzi_trips_app/place/ui/widgets/card_image.dart';
import 'package:platzi_trips_app/place/ui/widgets/title_input_location.dart';
import 'package:platzi_trips_app/user/bloc/bloc_user.dart';
import 'package:platzi_trips_app/widgets/button_purple.dart';
import 'package:platzi_trips_app/widgets/gradient_back.dart';
import 'package:platzi_trips_app/widgets/text_input.dart';
import 'package:platzi_trips_app/widgets/title_header.dart';

class AddPlaceScreen extends StatefulWidget {
  //
  File image;

  AddPlaceScreen({
    Key key,
    this.image,
  });

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  //

  final _controllerTitlePlace = TextEditingController();
  final _controllerDescriptionPlace = TextEditingController();

  VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    //
    UserBloc userBloc = BlocProvider.of<UserBloc>(context);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          GradientBack(
            height: 300.0,
          ),
          Row(
            //App Bar
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                  top: 25.0,
                  left: 5.0,
                ),
                child: SizedBox(
                  height: 45.0,
                  width: 45.0,
                  child: IconButton(
                    icon: Icon(
                      Icons.keyboard_arrow_left,
                      color: Colors.white,
                      size: 45.0,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              Flexible(
                child: Container(
                  padding: EdgeInsets.only(
                    top: 45.0,
                    left: 10.0,
                    right: 10.0,
                  ),
                  child: TitleHeader(title: "Add a new Place"),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(
              top: 120.0,
              bottom: 20.0,
            ),
            child: ListView(
              children: <Widget>[
                Container(
                  //Foto
                  alignment: Alignment.center,
                  child: CardImage(
                    pathImage: widget.image?.path ??
                        "https://www.segelectrica.com.co/wp-content/themes/consultix/images/no-image-found-360x250.png",
                    iconData: Icons.camera_alt,
                    height: 200.0,
                    width: 350.0,
                    onPressedfabIcon: onPressed,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    bottom: 20.0,
                  ),
                  child: TextInput(
                    hintText: "Tittle",
                    inputType: null,
                    controller: _controllerTitlePlace,
                    maxLines: 1,
                  ),
                ),
                TextInput(
                  hintText: "Description",
                  inputType: TextInputType.multiline,
                  controller: _controllerDescriptionPlace,
                  maxLines: 4,
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 20.0,
                  ),
                  child: TextInputLocation(
                    hintText: "Add Location",
                    iconData: Icons.location_on_outlined,
                  ),
                ),
                Container(
                  width: 70.0,
                  child: ButtonPurple(
                    buttonText: "Add Place",
                    onPressed: () {
                      //ID del usuario logeado actualmente
                      userBloc.currentUser.then((User user) {
                        if (user != null) {
                          String uid = user.uid;
                          String path =
                              '${uid}/${DateTime.now().toString()}.jpg';
                          //1. Firebase Storage
                          //url -
                          userBloc
                              .uploadFile(path, widget.image)
                              .then((UploadTask storageUploadTask) async {
                            await storageUploadTask
                                .then((TaskSnapshot snapshot) {
                              snapshot.ref.getDownloadURL().then((urlImage) {
                                //2. Cloud Firestore
                                userBloc
                                    .updatePlaceData(
                                  Place(
                                    name: _controllerTitlePlace.text,
                                    description:
                                        _controllerDescriptionPlace.text,
                                    urlImage: urlImage,
                                    likes: 0,
                                  ),
                                )
                                    .whenComplete(() {
                                  Navigator.pop(context);
                                });
                              });
                            });
                          });
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
