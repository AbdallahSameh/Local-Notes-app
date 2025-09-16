import 'package:flutter/material.dart';
import 'package:local_notes/listnotifier.dart';
import 'package:local_notes/models/notes.dart';
import 'package:local_notes/shared/custom_form_field.dart';
import 'package:provider/provider.dart';

Future<void> addNoteBottomSheet(context) {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController titleField = TextEditingController(),
      subtitleField = TextEditingController(),
      contentField = TextEditingController();
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      //to do: import images

      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomFormField(
                controller: titleField,
                label: 'Title',
                hint: 'Title',
              ),
              CustomFormField(
                controller: subtitleField,
                label: 'Subtitle',
                hint: 'Subtitle',
              ),
              CustomFormField(
                controller: contentField,
                label: 'Content',
                hint: 'Content',
              ),

              ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    Map<String, dynamic> data = {
                      'image': null,
                      'title': titleField.text,
                      'subtitle': subtitleField.text,
                      'content': contentField.text,
                      'last_modified': DateTime.now().toIso8601String(),
                    };

                    var note = Notes.fromMap(data);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Form is valid!')),
                    );
                    await context.read<ListNotifier>().addNote(note);
                    Navigator.of(context).pop();
                  }
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      );
    },
  );
}
