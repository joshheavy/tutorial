import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:leta_sasa/helpers/screen_navigation.dart';
import 'package:leta_sasa/screens/Authentication/register.dart';
import 'package:leta_sasa/screens/home.dart';
import 'package:leta_sasa/services/auth_service.dart';
import 'package:leta_sasa/utils/app_colors.dart';

class AuthenticationScreen extends StatefulWidget {
  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  AuthService _auth = AuthService();

  bool loading = false;

  toggleLoading() {
    setState(() {
      loading = !loading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.appBarColor,
          elevation: 0.0,
        ),
        backgroundColor: AppColors.appBarColor,
        body: loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : FormBuilder(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'LETASASa',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          child: FormBuilderTextField(
                            name: 'email',
                            validator: FormBuilderValidators.email(context),
                            decoration: InputDecoration(
                                icon: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.mail),
                                ),
                                hintText: 'Enter an email'),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          child: FormBuilderTextField(
                            name: 'password',
                            validator: FormBuilderValidators.required(context),
                            obscureText: true,
                            decoration: InputDecoration(
                                icon: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.lock),
                                ),
                                hintText: 'Enter your password'),
                          ),
                        ),
                        MaterialButton(
                          color: Color(0xff24d875),
                          height: 50,
                          minWidth: 200,
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                            ),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState.saveAndValidate()) {
                              toggleLoading();
                              UserCredential user = await _auth
                                  .signInWithEmailandPassword(
                                      email:
                                          _formKey.currentState.value['email'],
                                      password: _formKey
                                          .currentState.value['password'])
                                  .then((value) {
                                toggleLoading();
                                ChangeScreenReplacement(
                                    context,
                                    MyHomePage(
                                      user: value,
                                    ));
                                return value;
                              });
                            }
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 22,
                          ),
                        ),
                        FlatButton(
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              color: AppColors.textColor,
                              fontSize: 22,
                            ),
                          ),
                          onPressed: () async {
                            ChangeScreen(context, RegisterPage());
                          },
                        )
                      ],
                    ),
                  ],
                )));
  }
}
