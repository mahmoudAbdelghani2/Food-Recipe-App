import 'package:food_recipe_app/Models/recipe_model.dart';
import 'package:food_recipe_app/Services/database_helper.dart';
import 'package:food_recipe_app/Utils/constants.dart';

class RecipeController {
  List<RecipeModel> displayedRecipes = List.from(AppConstants.allRecipes);
  List<RecipeModel> favoriteRecipes = [];
  void searchRecipes(String query) {
    if (query.isEmpty) {
      displayedRecipes = List.from(AppConstants.allRecipes);
    } else {
      displayedRecipes = AppConstants.allRecipes.where((recipe) {
        return recipe.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
  }

  void filterByCountry(String country) {
    if (country == "All") {
      displayedRecipes = List.from(AppConstants.allRecipes);
    } else {
      displayedRecipes = AppConstants.allRecipes.where((recipe) {
        return recipe.recipeCountry == country;
      }).toList();
    }
  }

  Future<void> getFavorites(int userId) async {
    DatabaseHelper dbHelper = DatabaseHelper();
    List<int> favIds = await dbHelper.getFavoriteIds(userId);

    favoriteRecipes = AppConstants.allRecipes.where((recipe) {
      return favIds.contains(recipe.id);
    }).toList();
  }
}
