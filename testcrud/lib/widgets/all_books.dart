import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testcrud/models/books_model.dart';
import 'package:testcrud/providers/books_provider.dart';
import '../pages/create_book.dart';

class BooksList extends StatefulWidget {
  const BooksList({Key? key}) : super(key: key);

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
            if (!booksProvider.isLoading && booksProvider.books.isEmpty) {
              // Fetch data only if the list is empty and not already loading
              booksProvider.fetchBooks();
            }

            if (booksProvider.isLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (booksProvider.error.isNotEmpty) {
              return Center(child: Text('Error: ${booksProvider.error}'));
            } else if (booksProvider.books.isEmpty) {
              return Center(child: Text('No books available.'));
            } else {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: booksProvider.books.length,
                itemBuilder: (context, index) {
                  final book = booksProvider.books[index];

                  return ListTile(
                    title: Text(book.name),
                    subtitle: Text(
                      'Price: \$${book.price.toStringAsFixed(2)}',
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            _editBook(context, booksProvider, book);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _deleteBook(context, booksProvider, book);
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  void _editBook(
      BuildContext context, BooksProvider booksProvider, Books book) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookForm(),
      ),
    ).then((result) {
      if (result == true) {
        // Reload books after editing
        booksProvider.fetchBooks();
      }
    });
  }

  void _deleteBook(
      BuildContext context, BooksProvider booksProvider, Books book) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Warning'),
          content: Text('Are you sure you want to delete ${book.name}?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                booksProvider.deleteBook(book.name as int);
                Navigator.pop(
                    context, true); // Signal deletion to refresh the list
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}
