import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_twitter/blocs/auth/auth_bloc.dart';
import 'package:test_twitter/screen/home.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthBloc _authBloc = AuthBloc();
  @override
  void dispose() {
    _authBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        bloc: _authBloc,
        listener: (context, state) {
          if (state is AuthSuccessful) {
            /// Show snackbar sucess
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Loggged in successfully'),
              backgroundColor: Colors.green,
            ));

            /// Push HomePage
            Future.delayed(Duration(milliseconds: 200), () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => HomePage()));
            });
          }
          if (state is AuthFailed) {
            /// Authentication failed
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Something went wrong, please try again later'),
              backgroundColor: Colors.red,
            ));
          }
        },
        builder: (context, state) {
          return Container(
            child: _buildLoginButton(),
          );
        },
      ),
    );
  }

  Center _buildLoginButton() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Welcome to the Twitter client app",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Divider(color: Colors.transparent, height: 100),
            Text(
              "⬤ scroll through your timeline 🚀 \n⬤ scroll through home timeline 🌟",
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
            Divider(color: Colors.transparent, height: 100),
            TextButton(
              onPressed: () => _authBloc.add(InitLogin()),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue[600], Colors.lightBlue[400]],
                  ),
                  border: Border.all(color: Colors.blueGrey),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Login with",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Image.asset(
                      "assets/twitter_icon.png",
                      scale: 20,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
