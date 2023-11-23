import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testcrud/providers/books_provider.dart';

class BooksList extends StatefulWidget {
  const BooksList({super.key});

  @override
  State<BooksList> createState() => _BooksListState();
}

class _BooksListState extends State<BooksList> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Consumer<BooksProvider>(
          builder: (context, booksProvider, _) {
            if (booksProvider.books.isEmpty) {
              // Fetch data only if the list is empty and not already loading
              booksProvider.fetchBooks();
            } else {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: booksProvider.books.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(booksProvider.books[index].name),
                    subtitle: Text(
                        'Price: \$${booksProvider.books[index].price.toStringAsFixed(2)}'),
                  );
                },
              );
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
