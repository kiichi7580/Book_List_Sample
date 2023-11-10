import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../domain/book.dart';

class BookListModel extends ChangeNotifier {

  List<Book>? books;

  void fetchBookList() async {
    final QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection('books').get();

    final List<Book> books = snapshot.docs.map((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        final String id = document.id;
        final String title = data['title'] as String;
        final String author = data['author'] as String;
        return Book(id, title, author);
      }).toList();

      this.books = books;
      notifyListeners();
  }
}
