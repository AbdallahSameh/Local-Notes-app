import 'package:flutter/material.dart';
import 'package:local_notes/models/notes.dart';

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
    controller = TextEditingController(text: widget.note.content);

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.note.title.toString())),
      body: SafeArea(child: TextFormField(controller: controller)),
    );
  }
}
