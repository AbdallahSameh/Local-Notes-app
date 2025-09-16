import 'package:flutter/material.dart';
import 'package:local_notes/listnotifier.dart';
import 'package:local_notes/utility_functions/bottom_sheet.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notes = context.watch<ListNotifier>().notes;
    return Scaffold(
      appBar: AppBar(title: Text('Notes'), centerTitle: true),
      body: SafeArea(
        child: ListView.separated(
          itemBuilder: (context, index) {
            return Dismissible(
              key: ValueKey(notes[index].id),
              onDismissed: (direction) {
                context.read<ListNotifier>().deleteNote(notes[index].id);
              },
              child: ListTile(
                title: Text(notes[index].title.toString()),
                subtitle: Text(notes[index].subtitle.toString()),
                trailing: Text(notes[index].lastModified.toString()),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(height: 10);
          },
          itemCount: notes.length,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addNoteBottomSheet(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
