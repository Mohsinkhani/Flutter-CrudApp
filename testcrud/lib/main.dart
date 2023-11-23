// main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testcrud/providers/books_provider.dart';
import 'package:testcrud/widgets/all_books.dart';
import 'package:testcrud/pages/create_book.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BooksProvider(),
      child: const MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Items'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add),
              tooltip: 'Add New Book',
              onPressed: () {
                // handle the press
                Navigator.push<void>(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => BookForm(),
                    ));
                // MaterialPageRoute(builder: (BuildContext context) => BookForm());
              },
            ),
          ],
        ),
        body: const SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [BooksList()],
          ),
        ));
  }
}
