import 'dart:ui';
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
    backgroundColor: Color(0xfffffdf4),
    builder: (context) {
      //to do: import images

      return Stack(
        children: [
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              child: Container(color: Colors.transparent),
            ),
          ),

          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xfffffdf4),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 20,
                    bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Form(
              key: formKey,
              child: Padding(
                padding: EdgeInsetsGeometry.only(
                  left: 25,
                  right: 25,
                  top: 20,
                  bottom: 20,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  spacing: 20,
                  children: [
                    Text(
                      "Create Note",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
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
                      maxLines: null,
                      minLines: 4,
                    ),

                    SizedBox(
                      height: 55,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xffe3a365),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(16),
                          ),
                        ),
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            Map<String, dynamic> data = {
                              'image': null,
                              'title': titleField.text,
                              'subtitle': subtitleField.text,
                              'content': contentField.text,
                              'last_modified': DateTime.now().toIso8601String(),
                            };

                            Notes note = Notes.fromMap(data);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${note.title} is added!'),
                              ),
                            );
                            await context.read<ListNotifier>().addNote(note);
                            Navigator.of(context).pop();
                          }
                        },
                        child: Text(
                          'Save',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}
