class Books {
  final String id;
  final String name;
  final String catogory;
  final String author;
  final double price;

  Books({
    required this.name,
    required this.catogory,
    required this.author,
    required this.price,
    this.id = 'null',
  });

  factory Books.fromJson(Map<String, dynamic> json) {
    return Books(
      id: json['id']!,
      name: json['bookName'],
      author: json['author'],
      catogory: json['category'],
      price: json['price'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bookName': name,
      'author': author,
      'category': catogory,
      'price': price,
    };
  }

  Map<String, dynamic> toJsonForCreation() {
    return {
      'bookName': name,
      'author': author,
      'category': catogory,
      'price': price,
    };
  }
}
