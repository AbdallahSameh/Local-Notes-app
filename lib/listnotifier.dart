import 'package:flutter/material.dart';
import 'package:local_notes/database/local_database.dart';
import 'package:local_notes/models/notes.dart';
import 'package:sqflite/sqflite.dart';

class ListNotifier extends ChangeNotifier {
  late Database db;
  late LocalDatabase ldb;
  List<Notes> notes = [];
  bool isLoading = true;

  ListNotifier() {
    Future.microtask(() => init());
  }

  Future<void> init() async {
    ldb = LocalDatabase();
    db = await LocalDatabase.open();
    notes = await ldb.getAll(db);
    isLoading = false;
    notifyListeners();
  }

  Future<void> addNote(Notes note) async {
    await ldb.insert(db, note);
    notes = await ldb.getAll(db);
    notifyListeners();
  }

  Future<void> updateNote(Notes note) async {
    await ldb.update(db, note);
    notes = await ldb.getAll(db);
    notifyListeners();
  }

  Future<void> deleteNote(int id) async {
    await ldb.delete(db, id);
    notes = await ldb.getAll(db);
    if (notes.isEmpty) {
      ldb.resetCounter(db);
    }
    notifyListeners();
  }
}
