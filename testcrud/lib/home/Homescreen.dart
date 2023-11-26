// import 'package:flutter/material.dart';
// import 'package:flutter_http_example/src/providers/books_provider.dart';
// import 'package:flutter_http_example/src/ui/forms/book_form.dart';
// import 'package:provider/provider.dart';
// import 'package:testcrud/pages/create_book.dart';
// import 'package:testcrud/providers/books_provider.dart';

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   late BooksProvider booksProvider;

//   @override
//   void initState() {
//     super.initState();
//     booksProvider = BooksProvider();
//     booksProvider.fetchBooks(); // Fetch books when the screen initializes
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Book List'),
//       ),
//       body: Consumer<BooksProvider>(
//         builder: (context, booksProvider, _) {
//           if (booksProvider.isLoading) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (booksProvider.error != null) {
//             return Center(
//               child: Text("Error: ${booksProvider.error}"),
//             );
//           } else if (booksProvider.books.isEmpty) {
//             return Center(
//               child: Text("No books available."),
//             );
//           } else {
//             return _buildListView(booksProvider.books);
//           }
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           _showBookForm(context);
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }

//   Widget _buildListView(List<Book> books) {
//     return ListView.builder(
//       itemCount: books.length,
//       itemBuilder: (context, index) {
//         Book book = books[index];
//         return ListTile(
//           title: Text(book.name),
//           onTap: () {
//             _showBookForm(context, book);
//           },
//           trailing: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               IconButton(
//                 icon: Icon(Icons.edit),
//                 onPressed: () {
//                   _showBookForm(context, book);
//                 },
//               ),
//               IconButton(
//                 icon: Icon(Icons.delete),
//                 onPressed: () {
//                   _showDeleteDialog(book);
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   void _showDeleteDialog(Book book) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text("Warning"),
//           content: Text("Are you sure you want to delete ${book.name}?"),
//           actions: <Widget>[
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text("No"),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pop(context);
//                 booksProvider.deleteBook(book.id);
//               },
//               child: Text("Yes"),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _showBookForm(BuildContext context, [Book? book]) {
//     showModalBottomSheet(
//       context: context,
//       builder: (context) {
//         return BookForm(Book: book);
//       },
//     );
//   }
// }

// class Book {
//   get name => null;
// }
