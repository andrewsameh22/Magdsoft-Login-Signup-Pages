// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magdsoft_flutter_structure/presentation/screens/user/user_profile.dart';
import 'package:magdsoft_flutter_structure/presentation/widget/toast.dart';

import '../../../Reusable widgets.dart';
import '../../../business_logic/global_cubit/global_cubit.dart';
import '../Login/login_screen.dart';
import 'package:http/http.dart' as http;

class RegistrationScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var fullnameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneNumController = TextEditingController();
  var passwordController = TextEditingController();
  var repasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => GlobalCubit(),
      child: BlocConsumer<GlobalCubit, GlobalState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = GlobalCubit.get(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: Color(0xff005DA3),
              body: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/flutter_logo.png'),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 250.0),
                        child: SingleChildScrollView(
                          child: Container(
                            height: 525,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(45),
                                topRight: Radius.circular(45),
                              ),
                            ),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 70.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 50.0),
                                  child: TxtFld(
                                    controller: fullnameController,
                                    keyType: TextInputType.text,
                                    label: 'Full Name',
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'please enter your full name';
                                      } else if (cubit.wrongCredentials ==
                                          true) {
                                        return 'Email already exists';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 50.0),
                                  child: TxtFld(
                                    controller: emailController,
                                    keyType: TextInputType.emailAddress,
                                    label: 'Email',
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'please enter your email address';
                                      } else if (cubit.wrongCredentials ==
                                          true) {
                                        return 'Email already exists';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 50.0),
                                  child: TxtFld(
                                    controller: phoneNumController,
                                    keyType: TextInputType.number,
                                    label: 'Phone',
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'please enter your phone';
                                      } else if (cubit.wrongCredentials ==
                                          true) {
                                        return 'Email already exists';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 50.0),
                                  child: TxtFld(
                                    controller: passwordController,
                                    keyType: TextInputType.text,
                                    isPassword: cubit.isPass,
                                    sicon: IconButton(
                                      onPressed: () {
                                        cubit.changePasswordVisibility();
                                      },
                                      icon: Icon(cubit.Suffix),
                                    ),
                                    label: 'Password',
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'password is too short';
                                      } else if (cubit.wrongCredentials ==
                                          true) {
                                        return 'Email already exists';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 50.0),
                                  child: TxtFld(
                                    controller: repasswordController,
                                    keyType: TextInputType.text,
                                    isPassword: cubit.isrePass,
                                    sicon: IconButton(
                                      onPressed: () {
                                        cubit.changerePasswordVisibility();
                                      },
                                      icon: Icon(cubit.Suffix),
                                    ),
                                    label: 'Confirm Password',
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'please confirm your new password';
                                      } else if (value !=
                                          passwordController.text) {
                                        return 'Passwords doesn\'t match';
                                      } else if (cubit.wrongCredentials ==
                                          true) {
                                        return 'Email already exists';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 30.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    defaultButton(
                                        color: mainColor,
                                        title: 'Register',
                                        onPressed: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            try {
                                              final url = Uri.parse(
                                                  'https://magdsoft-internship.herokuapp.com/api/register');

                                              http
                                                  .post(
                                                url,
                                                headers: {
                                                  'Content-Type':
                                                      'application/json'
                                                },
                                                body: json.encode({
                                                  "email": emailController.text,
                                                  "name":
                                                      fullnameController.text,
                                                  "phone":
                                                      phoneNumController.text,
                                                  "password":
                                                      passwordController.text
                                                }),
                                              )
                                                  .then((value) {
                                                log("value: " +
                                                    value.body.toString());

                                                final extractedData =
                                                    json.decode(value.body);

                                                if (extractedData["message"]
                                                        .toString() !=
                                                    'Account Created Successfully') {
                                                  cubit.wrongCredentials = true;
                                                  return 'Email already exists.';
                                                  //not logged

                                                } else {
                                                  // showToast(
                                                  //     'Account Created Successfully you can login now');
                                                  Navigator.pushAndRemoveUntil(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              LoginScreen()),
                                                      (Route<dynamic> route) =>
                                                          false);
                                                }
                                              });
                                            } catch (e) {
                                              log(e.toString());
                                            }
                                            // cubit.userRegister(
                                            //   email: emailController.text,
                                            //   password: passwordController.text,
                                            //   name: fullnameController.text,
                                            //   phone: phoneNumController.text,
                                            // );
                                          }
                                        }),
                                    SizedBox(
                                      width: 25.0,
                                    ),
                                    defaultButton(
                                        color: mainColor,
                                        title: 'Login',
                                        onPressed: () {
                                          Navigator.pop(context);
                                        }),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
