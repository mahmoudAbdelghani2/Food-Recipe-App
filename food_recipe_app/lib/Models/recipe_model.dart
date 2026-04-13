class RecipeModel {
  final int id;
  final String title;
  final String chefName;
  final String chefCountry;
  final String recipeCountry;
  final String recipeProcedure;
  final String recipeImageUrl_1;
  final String recipeImageUrl_2;
  final double recipeRating;
  final double time;
  bool isFavorite;
  final List<Ingredient> ingredients;

  RecipeModel({
    required this.id,
    required this.title,
    required this.chefName,
    required this.chefCountry,
    required this.recipeCountry,
    required this.recipeProcedure,
    required this.recipeImageUrl_1,
    required this.recipeImageUrl_2,
    required this.recipeRating,
    required this.time,
    this.isFavorite = false,
    required this.ingredients,
  });
}

class Ingredient {
  final String name;
  final double amount;
  final String unit;

  Ingredient({required this.name, required this.amount, required this.unit});

  String get formattedAmount => "$amount $unit";
}
