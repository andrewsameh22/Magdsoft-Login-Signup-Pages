// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magdsoft_flutter_structure/presentation/screens/Login/login_screen.dart';

import '../../../Reusable widgets.dart';
import '../../../business_logic/global_cubit/global_cubit.dart';

class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text('User Data'),
            centerTitle: true,
            backwardsCompatibility: false,
            backgroundColor: mainColor,
          ),
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Column(
              children: [
                SizedBox(
                  height: 25.0,
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name : $UserName',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Text(
                        'Email : $UserEmail',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Text(
                        'Phone : $UserNum',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      // SizedBox(
                      //   height: 250.0,
                      // ),
                    ],
                  ),
                ),
                Spacer(
                  flex: 1,
                ),
                defaultButton(
                  title: 'Logout',
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                        (Route<dynamic> route) => false);
                  },
                  color: Color(0xffAD002F),
                ),
                SizedBox(
                  height: 30.0,
                ),
              ],
            ),
          )),
    );
  }
}
