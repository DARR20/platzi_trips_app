import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:platzi_trips_app/platzi_trips_cupertino.dart';
import 'package:platzi_trips_app/widgets/button_green.dart';
import 'package:platzi_trips_app/widgets/gradient_back.dart';
import 'package:platzi_trips_app/user/bloc/bloc_user.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:platzi_trips_app/user/model/user.dart' as Model;

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() {
    //

    return _SignInScreenState();
  }
}

class _SignInScreenState extends State<SignInScreen> {
  //

  UserBloc userBloc;
  double screenWith;

  @override
  Widget build(BuildContext context) {
    //

    screenWith = MediaQuery.of(context).size.width;

    userBloc = BlocProvider.of(context);

    return _handleCurrentSesion();
  }

  Widget _handleCurrentSesion() {
    //
    return StreamBuilder(
      stream: userBloc.authStatus,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        //snapshot - data - Object User
        if (!snapshot.hasData || snapshot.hasError) {
          return signInGoogleUI();
        } else {
          return PlatziTripsCupertino();
        }
      },
    );
  }

  Widget signInGoogleUI() {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          GradientBack(height: null),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Container(
                  width: screenWith,
                  margin: EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  child: Text(
                    'Welcome. \nThis is your Travel App',
                    style: TextStyle(
                      fontSize: 37.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              ButtonGreen(
                text: 'Login with Gmail',
                onPressed: () {
                  userBloc.singOut();
                  userBloc.signIn().then((value) {
                    userBloc.updateUserData(
                      Model.User(
                        uid: value.user.uid,
                        name: value.user.displayName,
                        email: value.user.email,
                        photoURL: value.user.photoURL,
                      ),
                    );
                  });
                },
                width: 300.0,
                height: 50.0,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
