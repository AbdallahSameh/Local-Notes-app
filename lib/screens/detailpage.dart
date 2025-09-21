import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  late ListNotifier notifier = context.read<ListNotifier>();

  @override
  void initState() {
    print("note: ${widget.note.title}");
    controller = TextEditingController(text: widget.note.content);
    notifier = context.read<ListNotifier>();
    super.initState();
  }

  @override
  void dispose() {
    widget.note.content = controller.text;
    widget.note.lastModified = DateFormat(
      'yyyy/MM/dd',
    ).add_jm().format(DateTime.now());
    notifier.updateNote(widget.note);
    controller.dispose();
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
