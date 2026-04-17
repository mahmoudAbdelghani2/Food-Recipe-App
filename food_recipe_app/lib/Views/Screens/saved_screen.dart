import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Models/recipe_model.dart';
import '../../Utils/responsive_utils.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({
    super.key,
    required this.recipes,
    this.onRecipeTap,
    this.onFavoriteTap,
  });

  final List<RecipeModel> recipes;
  final void Function(RecipeModel recipe)? onRecipeTap;
  final Future<void> Function(RecipeModel recipe)? onFavoriteTap;

  String _formatTime(double time) {
    final value =
        time % 1 == 0 ? time.toInt().toString() : time.toStringAsFixed(1);
    return '$value min';
  }

  String _formatRating(double rating) {
    return rating % 1 == 0 ? rating.toInt().toString() : rating.toString();
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 82,
            height: 82,
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5EF),
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Icon(
              Icons.bookmark_border_rounded,
              color: Color(0xFF1B8A6B),
              size: 38,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            'No saved recipes yet',
            style: GoogleFonts.poppins(
              fontSize: ResponsiveUtils.fontSizeHeading(context),
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Tap the favorite icon on any recipe to save it here.',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: ResponsiveUtils.fontSizeBody(context),
              color: Colors.black45,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 180.ms);
  }

  Widget _buildSavedCard(BuildContext context, RecipeModel recipe, int index) {
    return GestureDetector(
      onTap: () => onRecipeTap?.call(recipe),
      child: Container(
        height: ResponsiveUtils.getValue4<double>(
          context,
          small: 170,
          medium: 182,
          large: 190,
          xlarge: 200,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          image: DecorationImage(
            image: CachedNetworkImageProvider(recipe.recipeImageUrl_1),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withValues(alpha: 0.45),
                Colors.black.withValues(alpha: 0.75),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF4D49A),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          size: 14,
                          color: Color(0xFFE09A00),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _formatRating(recipe.recipeRating),
                          style: GoogleFonts.poppins(
                            fontSize: ResponsiveUtils.fontSizeSmall(context),
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF2A2A2A),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    recipe.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: ResponsiveUtils.getValue4<double>(
                        context,
                        small: 18,
                        medium: 19,
                        large: 20,
                        xlarge: 22,
                      ),
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      height: 1.2,
                    ),
                  ),
                ),
                const SizedBox(height: 2),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'By ${recipe.chefName}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: ResponsiveUtils.fontSizeSmall(context),
                      color: Colors.white.withValues(alpha: 0.9),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Spacer(),
                    const Icon(
                      Icons.access_time_rounded,
                      size: 18,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _formatTime(recipe.time),
                      style: GoogleFonts.poppins(
                        fontSize: ResponsiveUtils.fontSizeBody(context),
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 10),
                    InkWell(
                      borderRadius: BorderRadius.circular(18),
                      onTap: () async {
                        await onFavoriteTap?.call(recipe);
                      },
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(
                          Icons.bookmark_rounded,
                          size: 18,
                          color: Color(0xFF1B8A6B),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(delay: Duration(milliseconds: 180 + (index * 100)))
        .slideY(begin: 0.1, end: 0);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 12,
              left: ResponsiveUtils.horizontalPadding(context),
              right: ResponsiveUtils.horizontalPadding(context),
              bottom: 10,
            ),
            child: Center(
              child: Text(
                'Saved recipes',
                style: GoogleFonts.poppins(
                  fontSize: ResponsiveUtils.fontSizeHeading(context),
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          Expanded(
            child: recipes.isEmpty
                ? _buildEmptyState(context)
                : ListView.separated(
                    padding: EdgeInsets.fromLTRB(
                      ResponsiveUtils.horizontalPadding(context),
                      8,
                      ResponsiveUtils.horizontalPadding(context),
                      24,
                    ),
                    itemCount: recipes.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      return _buildSavedCard(context, recipes[index], index);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
