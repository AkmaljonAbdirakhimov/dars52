import 'package:dars52/view_models/notes_viewmodel.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final notesViewModel = NotesViewmodel();
  String data = "Ma'lumot yo'q";

  @override
  void initState() {
    super.initState();

    notesViewModel.createDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bosh Sahifa"),
        actions: [
          IconButton(
            onPressed: () async {
              await notesViewModel.addNote();
              data = "Ma'lumot qo'shildi";
              setState(() {});
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: notesViewModel.list,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final notes = snapshot.data;
          return notes == null || notes.isEmpty
              ? const Center(
                  child: Text("Ma'lumot yo'q"),
                )
              : ListView.builder(
                  itemCount: notes.length,
                  itemBuilder: (ctx, index) {
                    return ListTile(
                      title: Text(notes[index].title),
                      subtitle: Text(notes[index].content),
                      trailing: Text(notes[index].created_time.toString()),
                    );
                  },
                );
        },
      ),
    );
  }
}
