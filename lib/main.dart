import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_twitter/blocs/splash/splash_bloc.dart';
import 'package:test_twitter/screen/splash.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<SplashBloc>(create: (_) => SplashBloc()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}
