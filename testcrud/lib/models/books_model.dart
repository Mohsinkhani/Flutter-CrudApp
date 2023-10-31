class Books {
  final String name;
  final String catogory;
  final String author;
  final double price;

  Books({
    required this.name,
    required this.catogory,
    required this.author,
    required this.price,
  });

  factory Books.fromJson(Map<String, dynamic> json) {
    return Books(
      name: json['bookName'],
      author: json['author'],
      catogory: json['category'],
      price: json['price'].toDouble(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'bookName': name,
      'author': author,
      'category': catogory,
      'price': price,
    };
  }
}
