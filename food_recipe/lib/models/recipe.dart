class Recipe {
  final String id;
  final String name;
  final String imageUrl;
  final String category;
  final String? instructions;
  final List<String>? ingredients;

  Recipe({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.category,
    this.instructions,
    this.ingredients,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    List<String> ingredientList = [];
    for (int i = 1; i <= 20; i++) {
      if (json['strIngredient$i'] != null && json['strIngredient$i'].toString().trim().isNotEmpty) {
        ingredientList.add("${json['strMeasure$i'] ?? ''} ${json['strIngredient$i']}");
      }
    }

    return Recipe(
      id: json['idMeal'],
      name: json['strMeal'],
      imageUrl: json['strMealThumb'],
      category: json['strCategory'] ?? 'General',
      instructions: json['strInstructions'],
      ingredients: ingredientList,
    );
  }

  Map<String, dynamic> toJson() => {
        'idMeal': id,
        'strMeal': name,
        'strMealThumb': imageUrl,
        'strCategory': category,
      };
}