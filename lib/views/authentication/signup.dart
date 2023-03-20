// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gateprep/services/auth.dart';
import 'package:gateprep/views/App%20view/home.dart';
import 'package:gateprep/views/authentication/signin.dart';

import '../../widgets/widgets.dart';

class SignUp extends StatefulWidget {
  final Function toggleView;

  SignUp({required this.toggleView});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  late String name, email, password, error;
  final AuthService _auth = AuthService();

  bool _isLoading = false;
  // signUp() async {
  //   if (_formKey.currentState!.validate()) {
  //     setState(() {
  //       _isLoading = true;
  //     });

  //     await authService
  //         .signUpWithEmailAndPassword(email, password)
  //         .then((value) {
  //       if (value != null) {
  //         setState(() {
  //           _isLoading=false;
  //         });
  //         Navigator.pushReplacement(
  //             context, MaterialPageRoute(builder: (context) => Home()));
  //       }
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: _isLoading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : Form(
              key: _formKey,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: Column(children: [
                  Spacer(),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    cursorColor: Colors.amber,
                    validator: (val) => val!.isEmpty ? "Enter Name" : null,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.amber), //<-- SEE HERE
                      ),
                      hintText: "Name",
                    ),
                    onChanged: (val) {
                      setState(() => name = val);
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    cursorColor: Colors.amber,
                    validator: (val) => val!.isEmpty ? "Enter Email Id " : null,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.amber), //<-- SEE HERE
                      ),
                      hintText: "Email",
                    ),
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    cursorColor: Colors.amber,
                    obscureText: true,
                    validator: (val) => val!.length < 7
                        ? "Password length must be grater than 6 "
                        : null,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.amber), //<-- SEE HERE
                      ),
                      hintText: "Password",
                    ),
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                  ),
                  SizedBox(height: 25),
                  GestureDetector(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _isLoading = true;
                          });
                          dynamic result = await _auth
                              .signUPWithEmailAndPassword(email, password);

                          if (result == null) {
                            setState(() => _isLoading = false);
                          }
                        }
                      },
                      child: amberButton(context: context, lable: "Sign Up")),
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account! ",
                          style: TextStyle(color: Colors.black, fontSize: 20)),
                      GestureDetector(
                          onTap: () {
                            widget.toggleView();
                            // Navigator.pushReplacement(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => SignIn(),
                            //     ));
                          },
                          child: Text("Sign In.",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                decoration: TextDecoration.underline,
                              ))),
                    ],
                  ),
                  SizedBox(
                    height: 80,
                  )
                ]),
              ),
            ),
    );
    ;
  }
}
