import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' as gt;
import 'package:mocktail/mocktail.dart';
import 'package:prova_flutter_target/controllers/login_controller.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MockDio extends Mock implements Dio {}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final mockDio = MockDio();

  @override
  void initState() {
    super.initState();
    // Configurando mock da api
    when(() => mockDio.post(any(), data: any(named: 'data')))
        .thenAnswer((_) async => Response(
            statusCode: 200,
            data: {
              'code': 0,
              'message': 'Logado com sucesso!',
              'data': {'token': '12345abcd'}
            },
            requestOptions: RequestOptions()));
  }

  @override
  Widget build(BuildContext context) {
    return gt.GetBuilder<LoginController>(
        init: LoginController(mockDio),
        builder: (loginController) {
          return Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xFF1e4e62), Color(0xFF2b958f)],
                    begin: Alignment.topCenter)),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: SafeArea(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: Text(
                                  'Usuário',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      height: 2),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: Container(
                                  decoration: const BoxDecoration(boxShadow: [
                                    BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 20,
                                        offset: Offset(0, 10))
                                  ]),
                                  child: TextFormField(
                                    validator: (value) => validateUser(value),
                                    controller: loginController.userController,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(20),
                                    ],
                                    decoration: const InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      prefixIcon: Icon(Icons.person),
                                      prefixIconConstraints:
                                          BoxConstraints(minWidth: 60.0),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8.0))),
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 15.0),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8.0))),
                                      errorStyle:
                                          TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: Text(
                                  'Senha',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      height: 2),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 40.0),
                                child: Container(
                                  decoration: const BoxDecoration(boxShadow: [
                                    BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 20,
                                        offset: Offset(0, 10))
                                  ]),
                                  child: TextFormField(
                                    validator: (value) =>
                                        validatePassword(value),
                                    controller:
                                        loginController.passwordController,
                                    obscureText: true,
                                    enableSuggestions: false,
                                    autocorrect: false,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[\s\A-Za-z0-9]')),
                                      LengthLimitingTextInputFormatter(20)
                                    ],
                                    decoration: const InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      prefixIcon: Icon(Icons.lock),
                                      prefixIconConstraints:
                                          BoxConstraints(minWidth: 60.0),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8.0))),
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 15.0),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8.0))),
                                      errorStyle:
                                          TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: Container(
                                  decoration: const BoxDecoration(boxShadow: [
                                    BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 10,
                                        offset: Offset(0, 5))
                                  ]),
                                  child: TextButton(
                                      onPressed: () => {
                                            if (_formKey.currentState!
                                                .validate())
                                              {
                                                loginController.login(),
                                              },
                                          },
                                      style: const ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  Color(0xFF44bd6e)),
                                          fixedSize: MaterialStatePropertyAll(
                                              Size.fromWidth(170)),
                                          padding: MaterialStatePropertyAll(
                                              EdgeInsets.symmetric(
                                                  vertical: 12))),
                                      child: const Text(
                                        'Entrar',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () =>
                            launchUrlString('https://www.google.com'),
                        child: const Text(
                          'Política de Privacidade',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  // Validar campo usuário
  String? validateUser(String? value) {
    if (value == null || value.isEmpty) {
      return '* Preencha o campo Usuário';
    }
    if (value.endsWith(' ')) {
      return '* Este campo não pode terminar com o caractere espaço';
    }
    return null;
  }

  // Validar campo senha
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return '* Preencha o campo Senha';
    } else if (value.length < 2) {
      return '* A senha deve ter pelo menos 2 caracteres';
    } else if (value.endsWith(' ')) {
      return '* Este campo não pode terminar com o caractere espaço';
    }
    return null;
  }
}
