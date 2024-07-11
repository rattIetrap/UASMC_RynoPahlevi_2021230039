class Recipe {
  final String id;
  final String title;
  final String description;
  final String? imageUrl;
  final String details;  // Periksa apakah kolom ini di API
  final String category;

  Recipe({
    required this.id,
    required this.title,
    required this.description,
    this.imageUrl,
    required this.details,
    required this.category,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    print('Parsing JSON: $json');  // Tambahkan log ini
    return Recipe(
      id: json['id'].toString(),
      title: json['title'],
      description: json['description'],
      imageUrl: json['image_url'],
      details: json['details'] ?? '',  // Pastikan ini ada atau tambahkan default value
      category: json['category'],
    );
  }
}
