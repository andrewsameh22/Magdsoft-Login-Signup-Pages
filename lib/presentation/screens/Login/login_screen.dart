// ignore_for_file: prefer_const_constructors, unnecessary_new, non_constant_identifier_names

import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magdsoft_flutter_structure/Reusable%20widgets.dart';
import 'package:magdsoft_flutter_structure/presentation/screens/user/user_profile.dart';

import '../../../business_logic/global_cubit/global_cubit.dart';
import '../../widget/toast.dart';
import '../Register/register_screen.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  Future SendPost({
    required email,
    required password,
  }) async {
    Response response;
    BaseOptions options = new BaseOptions(
      baseUrl: "https://magdsoft-internship.herokuapp.com/api/",
      connectTimeout: 6000,
      receiveTimeout: 3000,
    );
    Dio dio = new Dio(options);

    FormData formData = new FormData.fromMap({
      "email": email,
      "password": password,
    });

    try {
      response = await dio.post("register/", data: formData);
      return response;
    } catch (e) {
      print('Error: $e');
    }
  }

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
                    // fit: StackFit.expand,
                    children: [
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset('assets/images/flutter_logo.png'),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 50.0,
                                  left: 15.0,
                                  right: 20.0,
                                  bottom: 15.0,
                                ),
                                child: MaterialButton(
                                  onPressed: () {},
                                  height: 30.0,
                                  minWidth: 80.0,
                                  child: Text(
                                    'عربي',
                                    style: TextStyle(
                                        color: mainColor,
                                        fontFamily: 'Segoe UI'),
                                  ),
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 250.0),
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
                                height: 100.0,
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
                                    } else if (cubit.wrongCredentials == true) {
                                      return 'Wrong username or password.';
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
                                    } else if (cubit.wrongCredentials == true) {
                                      return 'Wrong username or password.';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 150.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  defaultButton(
                                    title: 'Register',
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              RegistrationScreen(),
                                        ),
                                        //(Route<dynamic> route) => false);
                                      );
                                    },
                                    color: mainColor,
                                  ),
                                  SizedBox(
                                    width: 25.0,
                                  ),
                                  defaultButton(
                                    title: 'Login',
                                    onPressed: () async {
                                      if (formKey.currentState!.validate()) {
                                        try {
                                          final url = Uri.parse(
                                              'https://magdsoft-internship.herokuapp.com/api/login');
                                          http
                                              .post(
                                            url,
                                            headers: {
                                              'Content-Type': 'application/json'
                                            },
                                            body: json.encode({
                                              "email": emailController.text,
                                              "password":
                                                  passwordController.text
                                            }),
                                          )
                                              .then((value) {
                                            log("value: " +
                                                value.body.toString());
                                            //andrewsamehtest@gmail.com
                                            final extractedData =
                                                json.decode(value.body);

                                            String testError =
                                                extractedData["message"] ?? "";

                                            if (testError.isNotEmpty) {
                                              cubit.wrongCredentials = true;
                                              return 'Wrong username or password.';
                                            } else {
                                              cubit.wrongCredentials = false;

                                              UserName =
                                                  extractedData["account"][0]
                                                      ["name"];

                                              UserEmail =
                                                  extractedData["account"][0]
                                                          ["email"]
                                                      .toString();

                                              UserNum = extractedData["account"]
                                                  [0]["phone"];
                                              Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          UserProfile()),
                                                  (Route<dynamic> route) =>
                                                      false);
                                            }
                                          });
                                        } catch (e) {
                                          log(e.toString());
                                        }
                                      }

                                      // cubit.userLogin(
                                      //     email: emailController.text,
                                      //     password: passwordController.text);

                                      // SendPost(
                                      //   password: passwordController.text,
                                      //   email: emailController.text,
                                      // );
                                    },
                                    color: mainColor,
                                  ),
                                ],
                              ),
                            ],
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
