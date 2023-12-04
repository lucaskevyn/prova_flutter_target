import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:prova_flutter_target/stores/notes.dart';
import 'package:url_launcher/url_launcher_string.dart';

class CapturaInfo extends StatefulWidget {
  const CapturaInfo({super.key});

  @override
  State<CapturaInfo> createState() => _CapturaInfoState();
}

class _CapturaInfoState extends State<CapturaInfo> {
  final _formKey = GlobalKey<FormState>();
  final noteStore = Notes();
  final noteController = TextEditingController();
  late FocusNode _focusNode;
  bool isEditing = false;
  late int editingIndex;

  @override
  void initState() {
    super.initState();

    // Node para controlar o foco do textfield
    _focusNode = FocusNode();
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
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
                                              return savedText(index, note);
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
                                  // Verificar se botão de edição foi acionado
                                  if (isEditing) {
                                    // Validar e editar texto
                                    if (_formKey.currentState!.validate()) {
                                      noteStore.update(editingIndex, value);
                                      noteController.clear();
                                      isEditing = false;
                                      _focusNode.requestFocus();
                                    }
                                  } else {
                                    // Validar e adicionar texto
                                    if (_formKey.currentState!.validate()) {
                                      noteStore.add(value);
                                      noteController.clear();
                                      _focusNode.requestFocus();
                                    }
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

  // Widget dos itens de textos salvos
  Widget savedText(int index, String item) {
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
                onPressed: () {
                  noteController.text = item;
                  isEditing = true;
                  editingIndex = index;
                },
                icon: const Icon(
                  Icons.border_color,
                  size: 36,
                )),
            IconButton(
                onPressed: () => {showRemoveDialog(index)},
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

  // Modal de confirmação de exclusão
  showRemoveDialog(int index) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Remover'),
            content: const Text('Deseja remover este item?'),
            surfaceTintColor: Colors.white,
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancelar')),
              TextButton(
                  onPressed: () {
                    noteStore.delete(index);
                    Navigator.of(context).pop();
                  },
                  child: const Text('Remover'))
            ],
          );
        });
  }

  // Validar campo de texto
  String? validateTextField(String? value) {
    if (value == null || value.isEmpty) {
      _focusNode.requestFocus();
      return '* Preencha o campo';
    }
    return null;
  }
}
