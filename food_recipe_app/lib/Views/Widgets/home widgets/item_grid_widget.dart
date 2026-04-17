import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Models/recipe_model.dart';
import '../../../Utils/responsive_utils.dart';

class ItemGridWidget extends StatelessWidget {
  const ItemGridWidget({
    super.key,
    required this.recipes,
    this.onRecipeTap,
    this.sectionTitle = 'All Recipes',
  });

  final List<RecipeModel> recipes;
  final void Function(RecipeModel recipe)? onRecipeTap;
  final String? sectionTitle;

  String _formatRating(double rating) {
    return rating % 1 == 0 ? rating.toInt().toString() : rating.toString();
  }

  String _formatTime(double time) {
    final value =
        time % 1 == 0 ? time.toInt().toString() : time.toStringAsFixed(1);
    return '$value Mins';
  }

  Widget _buildRecipeCard(BuildContext context, RecipeModel recipe, int index) {
    final title = recipe.title;
    final time = _formatTime(recipe.time);
    final image = recipe.recipeImageUrl_1;
    final rating = _formatRating(recipe.recipeRating);

    final imageSize = ResponsiveUtils.getValue4<double>(
      context,
      small: 98,
      medium: 106,
      large: 112,
      xlarge: 118,
    );

    return GestureDetector(
      onTap: () => onRecipeTap?.call(recipe),
      child: SizedBox.expand(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(
              top: imageSize * 0.42,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFE8E8EA),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(12, imageSize * 0.58, 12, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          title,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: ResponsiveUtils.getValue4<double>(
                              context,
                              small: 14,
                              medium: 15,
                              large: 16,
                              xlarge: 17,
                            ),
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF4C4E53),
                            height: 1.15,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'Time',
                        style: GoogleFonts.poppins(
                          fontSize: ResponsiveUtils.fontSizeBody(context),
                          color: const Color(0xFFA7A9AE),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              time,
                              style: GoogleFonts.poppins(
                                fontSize: ResponsiveUtils.getValue4<double>(
                                  context,
                                  small: 13,
                                  medium: 14,
                                  large: 15,
                                  xlarge: 16,
                                ),
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF4C4E53),
                              ),
                            ),
                          ),
                          Container(
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF2F5F4),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: IconButton(
                              onPressed: () {},
                              padding: EdgeInsets.zero,
                              iconSize: 20,
                              splashRadius: 20,
                              icon: Icon(
                                recipe.isFavorite
                                    ? Icons.favorite_rounded
                                    : Icons.favorite_border_rounded,
                                color: const Color(0xFF6DB7A7),
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
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: imageSize,
                  height: imageSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.16),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: image,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: const Color(0xFFE3E3E5),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey[300],
                        child: const Center(
                          child: Icon(Icons.broken_image, color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: imageSize * 0.30,
              right: 8,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF4D49A),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star_rounded,
                        size: 16, color: Color(0xFFEAA321)),
                    const SizedBox(width: 4),
                    Text(
                      rating,
                      style: GoogleFonts.poppins(
                        fontSize: ResponsiveUtils.fontSizeBody(context),
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1F2024),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
            .animate()
            .fadeIn(delay: Duration(milliseconds: 350 + index * 100))
            .slideY(begin: 0.15, end: 0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (sectionTitle != null) ...[
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: ResponsiveUtils.horizontalPadding(context)),
            child: Text(
              sectionTitle!,
              style: GoogleFonts.poppins(
                fontSize: ResponsiveUtils.fontSizeHeading(context),
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
          ).animate().fadeIn(delay: 280.ms),
          const SizedBox(height: 12),
        ],
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: ResponsiveUtils.horizontalPadding(context)),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: recipes.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio:
                  ResponsiveUtils.isSmallMobile(context) ? 0.69 : 0.74,
            ),
            itemBuilder: (context, index) {
              return _buildRecipeCard(context, recipes[index], index);
            },
          ),
        ),
      ],
    );
  }
}
