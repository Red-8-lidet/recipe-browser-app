class MealCategory {
  final String id;
  final String name;
  final String thumbnail;
  final String description;

  MealCategory({
    required this.id,
    required this.name,
    required this.thumbnail,
    required this.description,
  });

  factory MealCategory.fromJson(Map<String, dynamic> json) {
    return MealCategory(
      id: json['idCategory'] as String,
      name: json['strCategory'] as String,
      thumbnail: json['strCategoryThumb'] as String,
      description: json['strCategoryDescription'] as String,
    );
  }
}