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
    _isLoading = true;
    try {
      final apiUrl = 'http://10.0.2.2:5263/api/books';
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _books = data.map((item) => Books.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load books');
      }
    } catch (error) {
      _error = error.toString();
      throw Exception('Failed to load books: $error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createBook(Books newBook) async {
    _isLoading = true;

    try {
      final apiUrl = 'http://10.0.2.2:5263/api/books';
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            newBook.toJsonForCreation()), // Use a separate method for creation
      );

      if (response.statusCode == 201) {
        // Parse the created book from the response and add it to the local list
        final createdBook = Books.fromJson(json.decode(response.body));
        _books.add(createdBook);
      } else {
        throw Exception(
            'Failed to create book. Status Code: ${response.statusCode}');
      }
    } catch (error) {
      _error = error.toString();
      throw Exception('Failed to create book: $error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateBook(Books updatedBook, String bookId) async {
    _isLoading = true;

    try {
      final apiUrl =
          'http://10.0.2.2:5263/api/books/${bookId}'; // Assuming your API supports updating by ID
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(updatedBook.toJson()),
      );

      if (response.statusCode == 204) {
        // Update the local list with the updated book
        int index = _books.indexWhere((book) => book == updatedBook);
        if (index != -1) {
          _books[index] = updatedBook;
        }
      } else {
        throw Exception(
            'Failed to update book. Status Code: ${response.statusCode}');
      }
    } catch (error) {
      _error = error.toString();
      throw Exception('Failed to update book: $error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteBook(String id) async {
    _isLoading = true;

    final apiUrl = 'http://10.0.2.2:5263/api/books/${id}';

    try {
      final response = await http.delete(Uri.parse(apiUrl));

      if (response.statusCode == 204) {
        _books.removeWhere((book) => book.id == id);
        notifyListeners();
      } else {
        throw Exception(
          'Failed to delete book. Status Code: ${response.statusCode}',
        );
      }
    } catch (error) {
      _error = error.toString();
      throw Exception('Failed to delete book: $error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  getbooks() {}

  deleteBrand(int brandId) {}

  void deleteBookById(String id) {}
}
