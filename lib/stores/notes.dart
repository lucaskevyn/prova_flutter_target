import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'notes.g.dart';

class Notes = _Notes with _$Notes;

abstract class _Notes with Store {
  late SharedPreferences prefs;

  _Notes() {
    loadPreferences();
  }

  @observable
  var notes = ObservableList<String>();

  @action
  void add(String item) {
    notes.add(item);
    saveData();
  }

  @action
  void delete(int index) {
    notes.removeAt(index);
    saveData();
  }

  @action
  void update(int index, String item) {
    notes[index] = item;
    saveData();
  }

  loadPreferences() async {
    prefs = await SharedPreferences.getInstance();
    notes = ObservableList<String>.of(prefs.getStringList("notes") ?? []);
  }

  void saveData() {
    prefs.setStringList("notes", notes);
  }
}
