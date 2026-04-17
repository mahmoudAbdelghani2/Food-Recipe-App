
import '../Models/recipe_model.dart';
import '../Services/database_helper.dart';
import '../Services/pref_service.dart';
import '../Utils/constants.dart';

class RecipeController {
  List<RecipeModel> displayedRecipes = List.from(AppConstants.allRecipes);
  List<RecipeModel> favoriteRecipes = [];
  final DatabaseHelper _dbHelper = DatabaseHelper();

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

  Future<void> getFavorites() async {
    int? userId = await PrefService.getUserId();

    if (userId != null) {
      List<int> favIds = await _dbHelper.getFavoriteIds(userId);

      favoriteRecipes = AppConstants.allRecipes.where((recipe) {
        return favIds.contains(recipe.id);
      }).toList();
    } else {
      favoriteRecipes = [];
    }
  }

  Future<void> toggleFavorite(int recipeId) async {
    int? userId = await PrefService.getUserId();

    if (userId != null) {
      await _dbHelper.toggleFavorite(userId, recipeId);
      await getFavorites();
    } else {
      print("User is not logged in!");
    }
  }

  bool isFavorite(int recipeId) {
    return favoriteRecipes.any((recipe) => recipe.id == recipeId);
  }
}
