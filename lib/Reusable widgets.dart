// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

var mainColor = Color(0xff005DA3);
var UserName = '';
var UserEmail = '';
var UserNum = '';
Widget TxtFld({
  required TextEditingController controller,
  required TextInputType keyType,
  required String label,
  IconButton? sicon,
  bool isPassword = false,
  onSubmit,
  validator,
}) =>
    TextFormField(
      validator: validator,
      controller: controller,
      obscureText: isPassword,
      keyboardType: keyType,
      onFieldSubmitted: onSubmit,
      decoration: InputDecoration(
        isDense: true,
        labelText: label,
        fillColor: Color(0xffECECEC),
        filled: true,
        suffixIcon: sicon != null ? sicon : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Color(0xff707070),
          ),
        ),
      ),
    );

Widget defaultButton(
        {required String title, required onPressed, required color}) =>
    MaterialButton(
      onPressed: onPressed,
      height: 60.0,
      minWidth: 140.0,
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'Segoe-UI',
          fontSize: 18,
        ),
      ),
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
