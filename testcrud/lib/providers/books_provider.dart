import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:testcrud/models/books_model.dart';

class BooksProvider with ChangeNotifier {
  List<Books> _books = [];
  bool _isLoading = false;
  String _error = '';

  List<Books> get books => _books;
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> fetchBooks() async {
    _isLoading = true; // Set loading state to true before fetching data
    final apiUrl =
        'http://10.0.2.2:5263/api/books'; // Replace with your API URL

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _books = data.map((item) => Books.fromJson(item)).toList();
        notifyListeners();
      } else {
        throw Exception('Failed to load books');
      }
    } catch (error) {
      this._error = error.toString();
      throw Exception('Failed to load books: $error');
    }
    _isLoading =
        false; // Set loading state back to false after the request completes
    notifyListeners();
  }

  Future<void> createBook(Books newBook) async {
    _isLoading = true; // Set loading state to true before the request

    final apiUrl =
        'http://10.0.2.2:5263/api/books'; // Replace with your API URL

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(newBook.toJson()), // Convert the newBook to JSON
      );

      if (response.statusCode == 201) {
        // If the book was created successfully, you might want to update the local list, but this depends on your specific use case
        _books.add(newBook); // Update local list with the newly added book
        notifyListeners();
      } else {
        throw Exception(
            'Failed to create book. Status Code: ${response.statusCode}');
      }
    } catch (error) {
      _error = error.toString();
      throw Exception('Failed to create book: $error');
    }

    _isLoading =
        false; // Set loading state back to false after the request completes
    notifyListeners();
  }
}
