class MealDetail {
  final String id;
  final String name;
  final String category;
  final String area;
  final String instructions;
  final String thumbnail;
  final String? youtubeUrl;

  MealDetail({
    required this.id,
    required this.name,
    required this.category,
    required this.area,
    required this.instructions,
    required this.thumbnail,
    this.youtubeUrl,
  });

  factory MealDetail.fromJson(Map<String, dynamic> json) {
    return MealDetail(
      id: json['idMeal'] as String,
      name: json['strMeal'] as String,
      category: json['strCategory'] as String,
      area: json['strArea'] as String,
      instructions: json['strInstructions'] as String,
      thumbnail: json['strMealThumb'] as String,
      youtubeUrl: json['strYoutube'] as String?, // Nullable because some don't have it
    );
  }
}