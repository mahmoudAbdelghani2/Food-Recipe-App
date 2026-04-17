import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

import '../../Models/recipe_model.dart';
import '../../Utils/constants.dart';
import '../../Utils/responsive_utils.dart';

class RecipeDetailScreen extends StatelessWidget {
  static const String _fallbackImageUrl =
      'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?w=800';

  final String recipeId;
  final Map<String, dynamic>? recipeData;

  const RecipeDetailScreen({
    super.key,
    required this.recipeId,
    this.recipeData,
  });

  String _safeImageUrl(dynamic url) {
    final parsed = (url ?? '').toString().trim();
    return parsed.isEmpty ? _fallbackImageUrl : parsed;
  }

  String _formatIngredientAmount(double amount) {
    return amount % 1 == 0 ? amount.toInt().toString() : amount.toString();
  }

  Map<String, dynamic>? _resolveRecipeData() {
    if (recipeData != null && recipeData!.isNotEmpty) {
      return recipeData;
    }

    final parsedId = int.tryParse(recipeId);
    if (parsedId == null) {
      return null;
    }

    RecipeModel? selectedRecipe;
    for (final recipe in AppConstants.allRecipes) {
      if (recipe.id == parsedId) {
        selectedRecipe = recipe;
        break;
      }
    }

    if (selectedRecipe == null) {
      return null;
    }

    final timeValue = selectedRecipe.time % 1 == 0
        ? selectedRecipe.time.toInt().toString()
        : selectedRecipe.time.toStringAsFixed(1);

    final ingredients = selectedRecipe.ingredients
        .map(
          (ingredient) =>
              '${_formatIngredientAmount(ingredient.amount)} ${ingredient.unit} ${ingredient.name}',
        )
        .toList();

    return {
      'id': selectedRecipe.id,
      'title': selectedRecipe.title,
      'image': selectedRecipe.recipeImageUrl_2,
      'author': selectedRecipe.chefName,
      'rating': selectedRecipe.recipeRating,
      'time': '$timeValue mins',
      'calories': '${selectedRecipe.calories} kcal',
      'servings': selectedRecipe.servings,
      'description': selectedRecipe.description,
      'ingredients': ingredients,
      'instructions': selectedRecipe.recipeProcedure,
    };
  }

  @override
  Widget build(BuildContext context) {
    final recipe = _resolveRecipeData();
    if (recipe == null) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
            onPressed: () => context.pop(),
          ),
        ),
        body: Center(
          child: Text(
            'Recipe not found',
            style: GoogleFonts.poppins(
              fontSize: ResponsiveUtils.fontSizeBody(context),
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    }

    final isSmall = ResponsiveUtils.isSmallMobile(context);

    final appBarHeight = ResponsiveUtils.getValue4<double>(
      context,
      small: 250,
      medium: 280,
      large: 300,
      xlarge: 350,
    );
    final titleFontSize = ResponsiveUtils.getValue4<double>(
      context,
      small: 20,
      medium: 24,
      large: 28,
      xlarge: 32,
    );
    final bodyFontSize = ResponsiveUtils.fontSizeBody(context);
    final iconSize = ResponsiveUtils.iconSize(context);
    final borderRadius = ResponsiveUtils.borderRadius(context);
    final spacingSmall = ResponsiveUtils.spacingSmall(context);
    final spacingMedium = ResponsiveUtils.spacingMedium(context);
    final spacingLarge = ResponsiveUtils.spacingLarge(context);
    final horizontalPadding = ResponsiveUtils.horizontalPadding(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildMobileLayout(
        context,
        recipe,
        appBarHeight,
        titleFontSize,
        bodyFontSize,
        iconSize,
        borderRadius,
        spacingSmall,
        spacingMedium,
        spacingLarge,
        horizontalPadding,
        isSmall,
      ),
    );
  }

  Widget _buildMobileLayout(
    BuildContext context,
    Map<String, dynamic> recipe,
    double appBarHeight,
    double titleFontSize,
    double bodyFontSize,
    double iconSize,
    double borderRadius,
    double spacingSmall,
    double spacingMedium,
    double spacingLarge,
    double horizontalPadding,
    bool isSmall,
  ) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: appBarHeight,
          pinned: true,
          leading: IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.arrow_back_ios_new, size: 18),
            ),
            onPressed: () => context.pop(),
          ),
          actions: [
            IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.favorite_border, size: 20),
              ),
              onPressed: () {},
            ),
            SizedBox(width: horizontalPadding * 0.3),
          ],
          flexibleSpace: FlexibleSpaceBar(
            background: Hero(
              tag: 'recipe_image_$recipeId',
              child: CachedNetworkImage(
                imageUrl: _safeImageUrl(recipe['image']),
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: const Color(0xFFE3E3E5),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.broken_image, color: Colors.grey),
                ),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  recipe['title'],
                  style: GoogleFonts.poppins(
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.3, end: 0),
                SizedBox(height: spacingSmall),
                Row(
                  children: [
                    Icon(
                      Icons.person_outline_rounded,
                      color: Colors.black54,
                      size: iconSize,
                    ),
                    SizedBox(width: spacingSmall),
                    Text(
                      'By ${recipe['author'] ?? 'Chef'}',
                      style: GoogleFonts.poppins(
                        fontSize: bodyFontSize,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.star_rounded,
                        color: const Color(0xFFFFC107), size: iconSize),
                    SizedBox(width: 4),
                    Text(
                      recipe['rating']?.toString() ?? '4.5',
                      style: GoogleFonts.poppins(
                        fontSize: bodyFontSize,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.3, end: 0),
                SizedBox(height: spacingLarge),
                Row(
                  children: [
                    _buildInfoCard(
                      icon: Icons.access_time_rounded,
                      label: 'Time',
                      value: recipe['time'] ?? '20 mins',
                      color: const Color(0xFF1B8A6B),
                      context: context,
                    ),
                    SizedBox(width: spacingMedium),
                    _buildInfoCard(
                      icon: Icons.local_fire_department_rounded,
                      label: 'Calories',
                      value: recipe['calories'] ?? '350 kcal',
                      color: const Color(0xFFFF6B6B),
                      context: context,
                    ),
                    SizedBox(width: spacingMedium),
                    _buildInfoCard(
                      icon: Icons.restaurant_rounded,
                      label: 'Servings',
                      value: (recipe['servings'] ?? '1-2').toString(),
                      color: const Color(0xFF4ECDC4),
                      context: context,
                    ),
                  ],
                ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.3, end: 0),
                SizedBox(height: spacingLarge),
                _buildSectionTitle('Description', context, 500),
                SizedBox(height: spacingSmall),
                Text(
                  (recipe['description'] ??
                          'A delicious recipe made with quality ingredients and simple, clear steps.')
                      .toString(),
                  style: GoogleFonts.poppins(
                    fontSize: bodyFontSize,
                    color: Colors.black54,
                    height: 1.6,
                  ),
                ).animate().fadeIn(delay: 600.ms).slideX(begin: -0.2, end: 0),
                SizedBox(height: spacingLarge),
                _buildSectionTitle('Ingredients', context, 700),
                SizedBox(height: spacingSmall),
                ..._buildAnimatedIngredients(context, recipe),
                SizedBox(height: spacingLarge),
                _buildSectionTitle('Instructions', context, 1200),
                SizedBox(height: spacingSmall),
                ..._buildAnimatedInstructions(context, recipe),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title, BuildContext context, int delay) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: ResponsiveUtils.fontSizeHeading(context),
        fontWeight: FontWeight.w700,
        color: Colors.black87,
      ),
    )
        .animate()
        .fadeIn(delay: Duration(milliseconds: delay))
        .slideX(begin: -0.2, end: 0);
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
    required BuildContext context,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: ResponsiveUtils.isSmallMobile(context) ? 10 : 12,
          horizontal: 8,
        ),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius:
              BorderRadius.circular(ResponsiveUtils.borderRadius(context)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: ResponsiveUtils.iconSize(context)),
            SizedBox(height: ResponsiveUtils.spacingSmall(context) * 0.5),
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: ResponsiveUtils.fontSizeBody(context),
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: ResponsiveUtils.fontSizeSmall(context),
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<String> _asStringList(dynamic rawValue, List<String> fallback) {
    if (rawValue is List) {
      return rawValue.map((item) => item.toString()).toList();
    }
    return fallback;
  }

  List<Widget> _buildIngredientsList(
      BuildContext context, Map<String, dynamic> recipe) {
    final ingredients = _asStringList(
      recipe['ingredients'],
      const [
        '500 g main ingredient',
        '2 tbsp oil',
        'Salt and pepper to taste',
      ],
    );
    final iconSize = ResponsiveUtils.getValue4<double>(
      context,
      small: 14,
      medium: 14,
      large: 16,
      xlarge: 18,
    );
    final fontSize = ResponsiveUtils.fontSizeBody(context);

    return ingredients.map((ingredient) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: const Color(0xFF1B8A6B),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Icon(Icons.check, color: Colors.white, size: iconSize),
            ),
            SizedBox(width: ResponsiveUtils.spacingMedium(context)),
            Expanded(
              child: Text(
                ingredient,
                style: GoogleFonts.poppins(
                    fontSize: fontSize, color: Colors.black87),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  List<Widget> _buildAnimatedIngredients(
      BuildContext context, Map<String, dynamic> recipe) {
    final baseItems = _buildIngredientsList(context, recipe);
    return baseItems.asMap().entries.map((entry) {
      final index = entry.key;
      final item = entry.value;
      return item
          .animate()
          .fadeIn(delay: Duration(milliseconds: 800 + (index * 100)))
          .slideX(begin: -0.2, end: 0);
    }).toList();
  }

  List<Widget> _buildInstructionsList(
      BuildContext context, Map<String, dynamic> recipe) {
    final instructions = _asStringList(
      recipe['instructions'],
      const [
        'Prepare ingredients.',
        'Cook following the recipe steps.',
        'Serve and enjoy.',
      ],
    );
    final boxSize = ResponsiveUtils.getValue4<double>(
      context,
      small: 28,
      medium: 32,
      large: 36,
      xlarge: 40,
    );
    final fontSize = ResponsiveUtils.fontSizeBody(context);

    return instructions.asMap().entries.map((entry) {
      int index = entry.key;
      String instruction = entry.value;

      return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: boxSize,
              height: boxSize,
              decoration: BoxDecoration(
                color: const Color(0xFF1B8A6B),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  '${index + 1}',
                  style: GoogleFonts.poppins(
                    fontSize: ResponsiveUtils.fontSizeBody(context),
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(width: ResponsiveUtils.spacingMedium(context)),
            Expanded(
              child: Text(
                instruction,
                style: GoogleFonts.poppins(
                  fontSize: fontSize,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  List<Widget> _buildAnimatedInstructions(
      BuildContext context, Map<String, dynamic> recipe) {
    final baseItems = _buildInstructionsList(context, recipe);
    return baseItems.asMap().entries.map((entry) {
      final index = entry.key;
      final item = entry.value;
      return item
          .animate()
          .fadeIn(delay: Duration(milliseconds: 1300 + (index * 150)))
          .slideX(begin: -0.2, end: 0);
    }).toList();
  }
}
