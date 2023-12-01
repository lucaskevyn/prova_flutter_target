import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:prova_flutter_target/stores/notes.dart';
import 'package:url_launcher/url_launcher_string.dart';

class CapturaInfo extends StatefulWidget {
  CapturaInfo({super.key});

  @override
  State<CapturaInfo> createState() => _CapturaInfoState();
}

class _CapturaInfoState extends State<CapturaInfo> {
  final _formKey = GlobalKey<FormState>();

  final noteStore = Notes();

  final noteController = TextEditingController();

  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();

    _focusNode = FocusNode();
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    _focusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xFF1e4e62), Color(0xFF2b958f)],
              begin: Alignment.topCenter)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: SafeArea(
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 400,
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 8.0),
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.horizontal(
                                    left: Radius.elliptical(10, 60),
                                    right: Radius.elliptical(10, 60))),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Observer(
                                      builder: (_) => ListView.builder(
                                            itemCount: noteStore.notes.length,
                                            itemBuilder: (context, index) {
                                              var note = noteStore.notes[index];
                                              return savedText(note);
                                            },
                                          )),
                                ),
                              ],
                            ),
                          ),
                          Form(
                            key: _formKey,
                            child: TextFormField(
                                controller: noteController,
                                focusNode: _focusNode,
                                onFieldSubmitted: (value) {
                                  if (_formKey.currentState!.validate()) {
                                    noteStore.add(value);
                                    noteController.clear();
                                    _focusNode.requestFocus();
                                  }
                                },
                                validator: (value) => validateTextField(value),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.black),
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0))),
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 15.0),
                                  label: Center(
                                    child: Text(
                                      'Digite seu texto',
                                    ),
                                  ),
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  errorStyle: TextStyle(color: Colors.white),
                                )),
                          ),
                        ],
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
        ),
      ),
    );
  }

  Widget savedText(String item) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Text(
                item,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            IconButton(
                onPressed: () => {},
                icon: const Icon(
                  Icons.border_color,
                  size: 36,
                )),
            IconButton(
                onPressed: () => {},
                icon: Icon(
                  Icons.cancel,
                  color: Colors.red.shade800,
                  size: 36,
                ))
          ],
        ),
        const Divider()
      ],
    );
  }

  String? validateTextField(String? value) {
    if (value == null || value.isEmpty) {
      return '* Preencha o campo';
    }
    return null;
  }
}
