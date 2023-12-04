// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notes.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$Notes on _Notes, Store {
  late final _$notesAtom = Atom(name: '_Notes.notes', context: context);

  @override
  ObservableList<String> get notes {
    _$notesAtom.reportRead();
    return super.notes;
  }

  @override
  set notes(ObservableList<String> value) {
    _$notesAtom.reportWrite(value, super.notes, () {
      super.notes = value;
    });
  }

  late final _$_NotesActionController =
      ActionController(name: '_Notes', context: context);

  @override
  void add(String item) {
    final _$actionInfo =
        _$_NotesActionController.startAction(name: '_Notes.add');
    try {
      return super.add(item);
    } finally {
      _$_NotesActionController.endAction(_$actionInfo);
    }
  }

  @override
  void delete(int index) {
    final _$actionInfo =
        _$_NotesActionController.startAction(name: '_Notes.delete');
    try {
      return super.delete(index);
    } finally {
      _$_NotesActionController.endAction(_$actionInfo);
    }
  }

  @override
  void update(int index, String item) {
    final _$actionInfo =
        _$_NotesActionController.startAction(name: '_Notes.update');
    try {
      return super.update(index, item);
    } finally {
      _$_NotesActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
notes: ${notes}
    ''';
  }
}
