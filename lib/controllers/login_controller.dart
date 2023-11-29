import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prova_flutter_target/screens/capturaInfo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final Dio dio;
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  LoginController(this.dio);

  Future<void> login() async {
    try {
      // url fake p/ exemplo
      var url = 'http://restapi.com/users/';
      Map body = {
        'user': userController.text,
        'password': passwordController.text
      };

      var response = await dio.post(
        url,
        data: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final body = response.data;

        if (body['code'] == 0) {
          var token = body['data']['token'];
          final SharedPreferences prefs = await _prefs;
          await prefs.setString('token', token);
          userController.clear();
          passwordController.clear();
          Get.off(() => const CapturaInfo());
        } else if (body['code'] == 1) {
          throw jsonDecode(response.data)['message'];
        }
      } else {
        throw jsonDecode(response.data)["message"] ?? "Unknown Error Occured";
      }
    } catch (error) {
      Get.back();
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: const Text('Algo deu errado!'),
              contentPadding: const EdgeInsets.all(20),
              children: [Text(error.toString())],
            );
          });
    }
  }
}
