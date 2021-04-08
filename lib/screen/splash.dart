import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_twitter/blocs/splash/splash_bloc.dart';
import 'package:test_twitter/screen/home.dart';
import 'package:test_twitter/screen/login.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashBloc _bloc = SplashBloc();
  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer(
        bloc: _bloc,
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => HomePage()));
          }
          if (state is UnAuthenticated) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => Login()));
          }
        },
        builder: (context, state) {
          _bloc.add(IsAutheticated());
          return Container(
            child: Center(
              child: Text(
                "Twtitter client",
                style: TextStyle(fontSize: 20),
              ),
            ),
          );
        },
      ),
    );
  }
}
