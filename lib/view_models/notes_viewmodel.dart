import 'package:dars52/models/note.dart';
import 'package:dars52/services/local_database/notes_database.dart';

class NotesViewmodel {
  final _notesDatabase = NotesDatabase();
  List<Note> _list = [];

  Future<List<Note>> get list async {
    _list = await _notesDatabase.getNotes();
    return [..._list];
  }

  void createDatabase() async {
    _notesDatabase.createDatabase();
  }

  Future<void> addNote() async {
    await _notesDatabase.addNote();
  }
}
