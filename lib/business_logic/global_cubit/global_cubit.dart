// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/remote/dio_helper.dart';

part 'global_state.dart';

class GlobalCubit extends Cubit<GlobalState> {
  GlobalCubit() : super(GlobalInitial());

  static GlobalCubit get(context) => BlocProvider.of(context);
  IconData Suffix = Icons.visibility_outlined;
  bool wrongCredentials = false;
  bool isPass = true;
  void changePasswordVisibility() {
    isPass = !isPass;
    Suffix = isPass ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(DangerChangePasswordVisibilityState());
  }

  bool isrePass = true;
  void changerePasswordVisibility() {
    isrePass = !isrePass;
    Suffix =
        isrePass ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(DangerChangePasswordVisibilityState());
  }

  // void userLogin({
  //   required String email,
  //   required String password,
  // }) {
  //   emit(LoginLoadingState());
  //   DioHelper.postData(
  //     url: 'https://magdsoft-internship.herokuapp.com/api/',
  //     body: {
  //       'email': email,
  //       'password': password,
  //     },
  //   ).then((value) {
  //     print(value.data);
  //     emit(LoginSuccessState());
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(LoginErrorState(error.toString()));
  //   });
  // }
  void userRegister({
    required String phone,
    required String name,
    required String email,
    required String password,
  }) {
    emit(RegisterLoadingState());
    DioHelper.postData(
      url: 'register/',
      body: {
        'email': email,
        'name': name,
        'phone': phone,
        'password': password,
      },
    ).then((value) {
      //print(value.data);
      emit(RegisterSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(RegisterErrorState(error.toString()));
    });
  }
}
