import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/books_model.dart';
import '../providers/books_provider.dart';

class BookForm extends StatefulWidget {
  @override
  _BookFormState createState() => _BookFormState();
}

class _BookFormState extends State<BookForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Book'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Book Name'),
              ),
              TextFormField(
                controller: authorController,
                decoration: InputDecoration(labelText: 'Author'),
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
              ElevatedButton(
                onPressed: () {
                  _sendRequest();
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _sendRequest() async {
    final newBook = Books(
      name: nameController.text,
      author: authorController.text,
      catogory: categoryController.text,
      price: double.parse(priceController.text),
    );

    try {
      await Provider.of<BooksProvider>(context, listen: false)
          .createBook(newBook);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Book created successfully!')));
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create book: $error')));
    }
  }
}
