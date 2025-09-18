import 'package:flutter/material.dart';
import 'package:local_notes/listnotifier.dart';
import 'package:local_notes/models/notes.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  final Notes note;

  const DetailPage({super.key, required this.note});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late TextEditingController controller;
  @override
  void initState() {
    print("note: ${widget.note.title}");
    controller = TextEditingController(text: widget.note.content);

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    widget.note.content = controller.text;
    context.read<ListNotifier>().updateNote(widget.note);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.note.title.toString())),
      body: SafeArea(
        child: TextFormField(controller: controller, maxLines: null),
      ),
    );
  }
}
