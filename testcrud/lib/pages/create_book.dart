import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testcrud/widgets/all_books.dart';

import '../models/books_model.dart';
import '../providers/books_provider.dart';
//import 'books_list.dart'; // Import the book list screen

class BookForm extends StatefulWidget {
  final int? index;
  final String? id;
  final String? bookName;
  final String? author;
  final String? category;
  final double? price;

  BookForm(
      {this.index,
      this.bookName,
      this.author,
      this.category,
      this.price,
      this.id});
  @override
  _BookFormState createState() => _BookFormState();
}

class _BookFormState extends State<BookForm> {
  TextEditingController nameController = TextEditingController();
  TextEditingController authorController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  void initState() {
    super.initState();

    // Populate the form fields with book details when editing
    if (widget.index != null) {
      nameController.text = widget.bookName!;
      authorController.text = widget.author!;
      categoryController.text = widget.category!;
      priceController.text = widget.price!.toString();
    } else {
      nameController = TextEditingController();
      authorController = TextEditingController();
      categoryController = TextEditingController();
      priceController = TextEditingController();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.id != null ? 'Book Details' : 'Add New Book'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Book Name'),
              ),
              TextFormField(
                controller: authorController,
                decoration: const InputDecoration(labelText: 'Author'),
              ),
              TextFormField(
                controller: categoryController,
                decoration: InputDecoration(labelText: 'Category'),
              ),
              TextFormField(
                controller: priceController,
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _sendRequest(CreateOrUpdateAction.Create, context);
                    },
                    child: Text(widget.id == null ? 'Create' : 'Update'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _sendRequest(
      CreateOrUpdateAction action, BuildContext context) async {
    final newBook = Books(
        name: nameController.text,
        author: authorController.text,
        catogory: categoryController.text,
        price: double.parse(priceController.text),
        id: widget.id.toString());

    try {
      if (action == CreateOrUpdateAction.Create) {
        await Provider.of<BooksProvider>(context, listen: false)
            .createBook(newBook);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Book created successfully!')));
      } else if (action == CreateOrUpdateAction.Update) {
        // Replace '123' with the actual book ID for the book you want to update
        final bookId = widget.id.toString();
        await Provider.of<BooksProvider>(context, listen: false)
            .updateBook(newBook, bookId);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Book updated successfully!')));
      } else if (action == CreateOrUpdateAction.Delete) {
        // Replace '123' with the actual book ID for the book you want to delete
        final bookId = widget.id.toString();
        await Provider.of<BooksProvider>(context, listen: false)
            .deleteBook(bookId);
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Book deleted successfully!')));

        // Navigate back to the book list screen after deletion
        Navigator.pop(context);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => BooksList()));
      }
    } catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed: $error')));
    }
  }
}

enum CreateOrUpdateAction {
  Create,
  Update,
  Delete,
}
