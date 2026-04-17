// ignore_for_file: avoid_print

import 'package:cooking_app/Models/recipe_model.dart';
import 'package:cooking_app/Services/database_helper.dart';
import 'package:cooking_app/Services/pref_service.dart';
import 'package:cooking_app/Utils/constants.dart';

class RecipeController {
  List<RecipeModel> displayedRecipes = List.from(AppConstants.allRecipes);
  List<RecipeModel> favoriteRecipes = [];
  final DatabaseHelper _dbHelper = DatabaseHelper();

  static const List<String> featuredCountries = [
    'Italy',
    'India',
    'Japan',
    'Mexico',
  ];

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
    } else if (country == "Others") {
      displayedRecipes = AppConstants.allRecipes.where((recipe) {
        return !featuredCountries.contains(recipe.recipeCountry);
      }).toList();
    } else {
      displayedRecipes = AppConstants.allRecipes.where((recipe) {
        return recipe.recipeCountry == country;
      }).toList();
    }
  }

  void _syncFavoriteFlags(List<int> favIds) {
    for (final recipe in AppConstants.allRecipes) {
      recipe.isFavorite = favIds.contains(recipe.id);
    }
  }

  Future<void> getFavorites() async {
    int? userId = await PrefService.getUserId();

    if (userId != null) {
      List<int> favIds = await _dbHelper.getFavoriteIds(userId);
      _syncFavoriteFlags(favIds);
      favoriteRecipes =
          AppConstants.allRecipes.where((recipe) => recipe.isFavorite).toList();
    } else {
      _syncFavoriteFlags(const []);
      favoriteRecipes = [];
    }
  }

  Future<bool> toggleFavorite(int recipeId) async {
    int? userId = await PrefService.getUserId();

    if (userId != null) {
      await _dbHelper.toggleFavorite(userId, recipeId);
      await getFavorites();
      return true;
    } else {
      print("User is not logged in!");
      return false;
    }
  }

  bool isFavorite(int recipeId) {
    return favoriteRecipes.any((recipe) => recipe.id == recipeId);
  }
}
