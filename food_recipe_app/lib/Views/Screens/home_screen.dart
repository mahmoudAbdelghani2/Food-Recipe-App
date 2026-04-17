import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Controllers/recipe_controller.dart';
import '../../Models/recipe_model.dart';
import '../../Utils/responsive_utils.dart';
import '../Widgets/home widgets/categories_widget.dart';
import '../Widgets/home widgets/header_widget.dart';
import '../Widgets/home widgets/item_grid_widget.dart';
import '../Widgets/home widgets/search_widget.dart';
import '../Widgets/home widgets/top_rating_widget.dart';
import 'profile_screen.dart';
import 'saved_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  int _selectedCategory = 0;
  String _searchQuery = '';
  final RecipeController _recipeController = RecipeController();
  final TextEditingController _searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  bool get _isSearching => _searchQuery.trim().isNotEmpty;

  List<RecipeModel> get _searchedRecipes => _recipeController.displayedRecipes;

  List<RecipeModel> get _categoryRecipes => _recipeController.displayedRecipes;

  String _formatIngredientAmount(double amount) {
    return amount % 1 == 0 ? amount.toInt().toString() : amount.toString();
  }

  Map<String, dynamic> _toRecipeDetailsMap(RecipeModel recipe) {
    final timeValue = recipe.time % 1 == 0
        ? recipe.time.toInt().toString()
        : recipe.time.toStringAsFixed(1);

    final ingredients = recipe.ingredients
        .map((ingredient) =>
            '${_formatIngredientAmount(ingredient.amount)} ${ingredient.unit} ${ingredient.name}')
        .toList();

    return {
      'id': recipe.id,
      'title': recipe.title,
      'image': recipe.recipeImageUrl_2,
      'author': recipe.chefName,
      'rating': recipe.recipeRating,
      'time': '$timeValue mins',
      'calories': '${recipe.calories} kcal',
      'servings': recipe.servings,
      'description': recipe.description,
      'ingredients': ingredients,
      'instructions': recipe.recipeProcedure,
    };
  }

  void _onNavItemTapped(int index) {
    setState(() => _currentIndex = index);
  }

  Future<void> _loadFavorites() async {
    await _recipeController.getFavorites();
    if (!mounted) {
      return;
    }
    setState(() {});
  }

  Future<void> _onFavoriteTapped(RecipeModel recipe) async {
    final didToggle = await _recipeController.toggleFavorite(recipe.id);

    if (!mounted) {
      return;
    }

    if (!didToggle) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please sign in first to save recipes.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() {});
  }

  void _onSearchQueryChanged(String query) {
    setState(() {
      _searchQuery = query;

      if (query.trim().isEmpty && _selectedCategory != 0) {
        final currentCategory = CategoriesWidget.categories[_selectedCategory];
        _recipeController.filterByCountry(currentCategory);
      }
    });
  }

  void _onCategorySelected(int index, String category) {
    _searchTextController.clear();

    _recipeController.filterByCountry(category);

    setState(() {
      _selectedCategory = index;
      _searchQuery = '';
    });
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    super.dispose();
  }

  int _mobileNavToStackIndex(int mobileIndex) {
    switch (mobileIndex) {
      case 1:
        return 1;
      case 2:
        return 4;
      case 0:
      default:
        return 0;
    }
  }

  int _stackToMobileNavIndex() {
    switch (_currentIndex) {
      case 1:
        return 1;
      case 4:
        return 2;
      case 0:
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _currentIndex,
        children: [
          _buildHomeBody(),
          SavedScreen(
            recipes: _recipeController.favoriteRecipes,
            onRecipeTap: (recipe) {
              context.push(
                '/recipe/${recipe.id}',
                extra: _toRecipeDetailsMap(recipe),
              );
            },
            onFavoriteTap: _onFavoriteTapped,
          ),
          const Center(
              child: Text('Add Recipe', style: TextStyle(fontSize: 24))),
          const Center(
              child: Text('Notifications', style: TextStyle(fontSize: 24))),
          const ProfileScreen(),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildHomeBody() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: ResponsiveUtils.verticalPadding(context),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HomeHeaderWidget(),
            SearchWidget(
              recipeController: _recipeController,
              textController: _searchTextController,
              onQueryChanged: _onSearchQueryChanged,
            ),
            const SizedBox(height: 16),
            CategoriesWidget(
              selectedIndex: _selectedCategory,
              onCategorySelected: _onCategorySelected,
            ),
            const SizedBox(height: 16),
            if (_isSearching) ...[
              if (_searchedRecipes.isEmpty)
                SizedBox(
                  height: ResponsiveUtils.getValue4<double>(
                    context,
                    small: 260,
                    medium: 280,
                    large: 300,
                    xlarge: 320,
                  ),
                  child: Center(
                    child: Text(
                      "No recipes found for '$_searchQuery'",
                      style: GoogleFonts.poppins(
                        fontSize: ResponsiveUtils.fontSizeBody(context),
                        color: Colors.black45,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                )
              else
                ItemGridWidget(
                  recipes: _searchedRecipes,
                  sectionTitle: null,
                  onFavoriteTap: _onFavoriteTapped,
                  onRecipeTap: (recipe) {
                    context.push(
                      '/recipe/${recipe.id}',
                      extra: _toRecipeDetailsMap(recipe),
                    );
                  },
                ),
            ] else ...[
              TopRatingWidget(
                recipes: _categoryRecipes,
                onRecipeTap: (recipe) {
                  context.push(
                    '/recipe/${recipe.id}',
                    extra: _toRecipeDetailsMap(recipe),
                  );
                },
              ),
              const SizedBox(height: 20),
              ItemGridWidget(
                recipes: _categoryRecipes,
                onFavoriteTap: _onFavoriteTapped,
                onRecipeTap: (recipe) {
                  context.push(
                    '/recipe/${recipe.id}',
                    extra: _toRecipeDetailsMap(recipe),
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    final selectedIndex = _stackToMobileNavIndex();

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 6, 14, 12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: const Color(0xFFE8EFEA)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 22,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: GNav(
            selectedIndex: selectedIndex,
            onTabChange: (index) {
              _onNavItemTapped(_mobileNavToStackIndex(index));
            },
            rippleColor: const Color(0xFFBADFCF),
            hoverColor: const Color(0xFFE8F5EF),
            haptic: true,
            curve: Curves.easeOutExpo,
            duration: const Duration(milliseconds: 500),
            gap: 8,
            color: Colors.black54,
            activeColor: const Color(0xFF1B8A6B),
            iconSize: ResponsiveUtils.iconSize(context),
            tabBackgroundColor: const Color(0xFF1B8A6B).withValues(alpha: 0.12),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            tabBorderRadius: 16,
            textStyle: GoogleFonts.poppins(
              fontSize: ResponsiveUtils.fontSizeSmall(context),
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1B8A6B),
            ),
            tabs: const [
              GButton(
                icon: Icons.home_rounded,
                text: 'Home',
              ),
              GButton(
                icon: Icons.bookmark_border_rounded,
                text: 'Saved',
              ),
              GButton(
                icon: Icons.person_outline_rounded,
                text: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
