import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:local_notes/listnotifier.dart';
import 'package:local_notes/models/notes.dart';
import 'package:local_notes/screens/detailpage.dart';
import 'package:local_notes/utility_functions/bottom_sheet.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notes = context.watch<ListNotifier>().notes;
    return Scaffold(
      backgroundColor: Color(0xfffcf9f0),
      appBar: AppBar(
        title: Text(
          'Notes',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 30),
        ),
        centerTitle: true,
        toolbarHeight: 100,
        backgroundColor: Color(0xfff0d0ae),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.vertical(
            bottom: Radius.circular(10),
          ),
        ),
      ),
      body: notes.isEmpty
          ? Center(child: Text('No notes yet, tap + to add one'))
          : SafeArea(
              child: Padding(
                padding: EdgeInsetsGeometry.only(
                  left: 10,
                  right: 10,
                  top: 20,
                  bottom: 20,
                ),
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: ValueKey(notes[index].id),
                      confirmDismiss: (value) async {
                        bool delete = true;
                        var snackbar = ScaffoldMessenger.of(context)
                            .showSnackBar(
                              SnackBar(
                                content: Text(
                                  '${notes[index].title} is deleted',
                                ),
                                duration: Duration(seconds: 3),
                                action: SnackBarAction(
                                  label: 'Undo',
                                  onPressed: () {
                                    delete = false;
                                  },
                                ),
                              ),
                            );
                        await snackbar.closed;
                        return delete;
                      },
                      onDismissed: (direction) {
                        context.read<ListNotifier>().deleteNote(
                          notes[index].id,
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFFFFEFA),
                          borderRadius: BorderRadiusGeometry.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ListTile(
                          title: Text(
                            notes[index].title.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            ),
                          ),
                          subtitle: Text(
                            notes[index].subtitle.toString(),
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          trailing: Text(
                            DateFormat('yyyy/MM/dd').add_jm().format(
                              DateTime.parse(
                                notes[index].lastModified.toString(),
                              ),
                            ),
                            style: TextStyle(color: Colors.grey[500]),
                          ),
                          onTap: () {
                            Notes note = notes[index];
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailPage(note: note),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 13);
                  },
                  itemCount: notes.length,
                ),
              ),
            ),
      floatingActionButton: SizedBox(
        width: 70,
        height: 70,
        child: FloatingActionButton(
          backgroundColor: Color(0xffe3a365),
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(35),
          ),
          onPressed: () {
            addNoteBottomSheet(context);
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
