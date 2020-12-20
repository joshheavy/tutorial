import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:leta_sasa/helpers/screen_navigation.dart';
import 'package:leta_sasa/screens/home.dart';
import 'package:leta_sasa/services/auth_service.dart';
import 'package:leta_sasa/utils/app_colors.dart';
import 'package:leta_sasa/screens/Authentication/authentication.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  bool loading = false;

  toggleLoading() {
    setState(() {
      loading = !loading;
    });
  }

  @override
  Widget build(BuildContext context) {
    AuthService _auth = AuthService();
    return FormBuilder(
        key: _formKey,
        child: Scaffold(
          backgroundColor: AppColors.appBarColor,
          body: loading
              ? Center(child: CircularProgressIndicator())
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Create Account',
                      style: TextStyle(
                        color: AppColors.textColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: FormBuilderTextField(
                        name: 'first_name',
                        validator: FormBuilderValidators.required(context),
                        decoration: InputDecoration(
                            hintText: 'First Name',
                            icon: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.person),
                            )),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: FormBuilderTextField(
                        name: 'last_name',
                        validator: FormBuilderValidators.required(context),
                        decoration: InputDecoration(
                            hintText: 'Last Name',
                            icon: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.person),
                            )),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: FormBuilderTextField(
                        name: 'email',
                        validator: FormBuilderValidators.email(context),
                        decoration: InputDecoration(
                            hintText: 'Enter an Email',
                            icon: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.mail),
                            )),
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
                            hintText: 'Enter your Password',
                            icon: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.lock),
                            )),
                      ),
                    ),
                    MaterialButton(
                      color: Color(0xff24d875),
                      height: 50,
                      minWidth: 200,
                      child: Text(
                        "Register",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState.saveAndValidate())
                          toggleLoading();
                        _auth
                            .createWithEmailandPassword(
                                email: _formKey.currentState.value['email'],
                                password:
                                    _formKey.currentState.value['password'])
                            .then((value) async {
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(value.user.uid)
                              .set(_formKey.currentState.value);
                          toggleLoading();
                          ChangeScreen(
                              context,
                              MyHomePage(
                                user: value,
                              ));
                        });
                      },
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(height: 150),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account?",
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 22,
                              ),
                            ),
                            FlatButton(
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                  color: AppColors.textColor,
                                  fontSize: 22,
                                ),
                              ),
                              onPressed: () async {
                                ChangeScreen(context, AuthenticationScreen());
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
        ));
  }
}
