import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Models/recipe_model.dart';
import '../../../Utils/responsive_utils.dart';

class TopRatingWidget extends StatelessWidget {
  const TopRatingWidget({
    super.key,
    required this.recipes,
    this.onRecipeTap,
  });

  final List<RecipeModel> recipes;
  final void Function(RecipeModel recipe)? onRecipeTap;

  String _formatTime(double time) {
    return time % 1 == 0
        ? '${time.toInt()} mins'
        : '${time.toStringAsFixed(1)} mins';
  }

  List<RecipeModel> _topFiveRecipes() {
    final sorted = List<RecipeModel>.from(recipes)
      ..sort((a, b) => b.recipeRating.compareTo(a.recipeRating));
    return sorted.take(5).toList();
  }

  Widget _buildStars(double rating) {
    final starCount = rating.clamp(0, 5).floor();

    if (starCount <= 0) {
      return const SizedBox.shrink();
    }

    return Row(
      children: List.generate(starCount, (index) {
        return Icon(
          Icons.star_rounded,
          size: 20,
          color: const Color(0xFFF0A11A),
        );
      }),
    );
  }

  Widget _buildTopRecipeCard(
      BuildContext context, RecipeModel recipe, int index) {
    final imageSize = ResponsiveUtils.getValue4<double>(
      context,
      small: 98,
      medium: 104,
      large: 112,
      xlarge: 118,
    );

    return GestureDetector(
      onTap: () => onRecipeTap?.call(recipe),
      child: SizedBox(
        width: ResponsiveUtils.getValue4<double>(
          context,
          small: 300,
          medium: 320,
          large: 335,
          xlarge: 360,
        ),
        height: ResponsiveUtils.getValue4<double>(
          context,
          small: 166,
          medium: 174,
          large: 182,
          xlarge: 190,
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(
              top: imageSize * 0.34,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F2F2),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      16, imageSize * 0.26, imageSize + 20, 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recipe.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: ResponsiveUtils.getValue4<double>(
                            context,
                            small: 30,
                            medium: 32,
                            large: 34,
                            xlarge: 36,
                          ),
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF424242),
                          height: 1,
                        ),
                      ),
                      const SizedBox(height: 6),
                      _buildStars(recipe.recipeRating),
                      const Spacer(),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'By ${recipe.chefName}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                fontSize: ResponsiveUtils.fontSizeBody(context),
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF9A9A9A),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.timelapse_rounded,
                            size: 20,
                            color: Color(0xFF9A9A9A),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _formatTime(recipe.time),
                            style: GoogleFonts.poppins(
                              fontSize: ResponsiveUtils.fontSizeBody(context),
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF9A9A9A),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              right: 12,
              top: 0,
              child: Container(
                width: imageSize,
                height: imageSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.16),
                      blurRadius: 12,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: recipe.recipeImageUrl_1,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: const Color(0xFFE0E0E0),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey[300],
                      child: const Icon(Icons.broken_image, color: Colors.grey),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
            .animate()
            .fadeIn(delay: Duration(milliseconds: 220 + (index * 90)))
            .slideX(begin: 0.1, end: 0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final topRecipes = _topFiveRecipes();

    if (topRecipes.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveUtils.horizontalPadding(context),
          ),
          child: Text(
            'Top Recipes',
            style: GoogleFonts.poppins(
              fontSize: ResponsiveUtils.fontSizeHeading(context),
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
        ).animate().fadeIn(delay: 230.ms),
        const SizedBox(height: 12),
        SizedBox(
          height: ResponsiveUtils.getValue4<double>(
            context,
            small: 166,
            medium: 174,
            large: 182,
            xlarge: 190,
          ),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveUtils.horizontalPadding(context),
            ),
            itemCount: topRecipes.length,
            separatorBuilder: (_, __) => const SizedBox(width: 14),
            itemBuilder: (context, index) {
              return _buildTopRecipeCard(context, topRecipes[index], index);
            },
          ),
        ),
      ],
    );
  }
}
