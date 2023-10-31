// main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testcrud/providers/books_provider.dart';
import 'package:testcrud/widgets/create_book.dart';

import 'models/books_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BooksProvider(),
      child: MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Items'),
      ),
      body: Container(
        color: Colors.amber,
        child: Column(
          children: [
            Consumer<BooksProvider>(
              builder: (context, booksProvider, _) {
                if (booksProvider.books.isEmpty) {
                  // Fetch data only if the list is empty and not already loading
                  booksProvider.fetchBooks();
                } else {
                  return Padding(
                    padding: EdgeInsets.all(10),
                    child: DataTable(
                      columns: [
                        DataColumn(label: Text('Book Name')),
                        DataColumn(label: Text('Price')),
                        DataColumn(label: Text('Category')),
                        DataColumn(label: Text('Author')),
                      ],
                      rows: booksProvider.books
                          .map(
                            (book) => DataRow(
                              cells: [
                                DataCell(Text(book.name)),
                                DataCell(Text(book.price.toString())),
                                DataCell(Text(book.catogory)),
                                DataCell(Text(book.author)),
                              ],
                            ),
                          )
                          .toList(),
                    ),
                  );
                }
                return CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}
