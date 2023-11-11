import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../domain/book.dart';

class BookListModel extends ChangeNotifier {
  final Stream<QuerySnapshot> _usersStream =
  FirebaseFirestore.instance.collection('books').snapshots();

  List<Book>? books;

  void fetchBookList() {
    _usersStream.listen((QuerySnapshot snapshot) {
      final List<Book> books = snapshot.docs.map((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
        final String id = document.id;
        final String title = data['title'] as String;
        final String author = data['author'] as String;
        final String? imgURL = data['imgURL'] as String;
        return Book(id, title, author, imgURL);
      }).toList();

      this.books = books;
      notifyListeners();
    }
    );
  }
  Future delete (Book book) {
    return FirebaseFirestore.instance.collection('books').doc(book.id).delete();
  }
}
