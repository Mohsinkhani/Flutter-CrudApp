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
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                _refreshBooks(context);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue, // Background color
                onPrimary: Colors.white, // Text color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              ),
              child: const Text(
                'Refresh',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            Consumer<BooksProvider>(
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
                                _editBook(context, booksProvider, book, index);
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
          ],
        ),
      ),
    );
  }

  void _editBook(BuildContext context, BooksProvider booksProvider, Books book,
      int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookForm(
          index: index,
          id: booksProvider.books[index].id,
          author: booksProvider.books[index].author,
          bookName: booksProvider.books[index].name,
          category: booksProvider.books[index].catogory,
          price: booksProvider.books[index].price,
        ),
      ),
    ).then((result) {
      if (result == true) {
        // Reload books after editing
        _refreshBooks(context);
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
                booksProvider.deleteBook(book.id);
                Navigator.pop(context, true);
                _refreshBooks(context);
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  void _refreshBooks(BuildContext context) {
    Provider.of<BooksProvider>(context, listen: false).fetchBooks();
  }
}
