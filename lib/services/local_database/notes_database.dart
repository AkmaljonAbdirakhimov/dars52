import 'package:dars52/models/note.dart';
import 'package:dars52/services/local_database/local_database.dart';

class NotesDatabase {
  final _localDatabase = LocalDatabase();

  void createDatabase() async {
    final db = await _localDatabase.database;
  }

  Future<void> addNote() async {
    final db = await _localDatabase.database;
    await db.insert("notes", {
      "title": "Bozorga borish kerak!",
      "content": "Mazza qilib aylanib chumilib kelamiz!",
      "created_time": DateTime.now().millisecond,
    });
  }

  Future<List<Note>> getNotes() async {
    final db = await _localDatabase.database;
    final rows = await db.query('notes');
    List<Note> notes = [];
    for (var row in rows) {
      notes.add(
        Note(
          id: row['id'] as int,
          title: row['title'] as String,
          content: row['content'] as String,
          created_time: DateTime.fromMillisecondsSinceEpoch(
            row['created_time'] as int,
          ),
        ),
      );
    }

    return notes;
  }
}
