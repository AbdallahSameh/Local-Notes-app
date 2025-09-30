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
  late ListNotifier notifier;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.note.content);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    notifier = context.read<ListNotifier>();
  }

  @override
  void dispose() {
    widget.note.content = controller.text;
    widget.note.lastModified = DateTime.now().toIso8601String();
    notifier.updateNote(widget.note);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffcf9f0),
      appBar: AppBar(
        title: Text(
          widget.note.title.toString(),
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 30),
        ),
        centerTitle: true,
        backgroundColor: Color(0xfff0d0ae),
        toolbarHeight: 100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.vertical(
            bottom: Radius.circular(10),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 20),
            child: Hero(
              tag: widget.note.id.toString(),
              child: Container(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height - 190,
                ),
                padding: EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 20,
                  bottom: 20,
                ),
                decoration: BoxDecoration(
                  color: Color(0xFFFFFEFA),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: TextFormField(
                    controller: controller,
                    maxLines: null,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
