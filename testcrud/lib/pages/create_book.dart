import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/books_model.dart';
import '../providers/books_provider.dart';
import '../widgets/all_books.dart';

class BookForm extends StatefulWidget {
  final int? index;
  final String? id;
  final String? bookName;
  final String? author;
  final String? category;
  final double? price;

  const BookForm({
    super.key,
    this.index,
    this.bookName,
    this.author,
    this.category,
    this.price,
    this.id,
  });

  @override
  _BookFormState createState() => _BookFormState();
}

class _BookFormState extends State<BookForm> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController authorController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Populate the form fields with book details when editing
    if (widget.index != null) {
      nameController.text = widget.bookName!;
      authorController.text = widget.author!;
      categoryController.text = widget.category!;
      priceController.text = widget.price!.toString();
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
        child: ListView(
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Book Name'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a book name.';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: authorController,
                    decoration: const InputDecoration(labelText: 'Author'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the author\'s name.';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: categoryController,
                    decoration: const InputDecoration(labelText: 'Category'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the category.';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: priceController,
                    decoration: const InputDecoration(labelText: 'Price'),
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the price.';
                      }
                      try {
                        double.parse(value);
                      } catch (e) {
                        return 'Invalid price format. Please enter a valid number.';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _submitForm();
                    },
                    child: Text(widget.id == null ? 'Create' : 'Update'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (widget.id != null) {
        _sendRequest(CreateOrUpdateAction.Update, context);
      } else {
        _sendRequest(CreateOrUpdateAction.Create, context);
      }
    }
  }

  Future<void> _sendRequest(
      CreateOrUpdateAction action, BuildContext context) async {
    final newBook = Books(
      name: nameController.text,
      author: authorController.text,
      catogory: categoryController.text,
      price: double.parse(priceController.text),
      // id: action == CreateOrUpdateAction.Create ? null : widget.id,
    );

    try {
      if (action == CreateOrUpdateAction.Create) {
        await Provider.of<BooksProvider>(context, listen: false)
            .createBook(newBook);
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Book created successfully!')));

        Navigator.pop(context, newBook);
      } else if (action == CreateOrUpdateAction.Update) {
        final bookId = widget.id.toString();
        await Provider.of<BooksProvider>(context, listen: false)
            .updateBook(newBook, bookId);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Book updated successfully!')));
        Navigator.pop(context, newBook);
      } else if (action == CreateOrUpdateAction.Delete) {
        final bookId = widget.id.toString();
        await Provider.of<BooksProvider>(context, listen: false)
            .deleteBook(bookId);
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Book deleted successfully!')));

        Navigator.pop(context);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const BooksList()));
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
