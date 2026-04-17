import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Controllers/recipe_controller.dart';
import '../../../Utils/responsive_utils.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
    required this.recipeController,
    required this.textController,
    required this.onQueryChanged,
  });

  final RecipeController recipeController;
  final TextEditingController textController;
  final ValueChanged<String> onQueryChanged;

  @override
  Widget build(BuildContext context) {
    final isSmall = ResponsiveUtils.isSmallMobile(context);

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: ResponsiveUtils.horizontalPadding(context)),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: ResponsiveUtils.inputHeight(context),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(
                    ResponsiveUtils.borderRadius(context)),
              ),
              child: TextField(
                controller: textController,
                onChanged: (value) {
                  recipeController.searchRecipes(value);
                  onQueryChanged(value);
                },
                decoration: InputDecoration(
                  hintText: 'Search recipe',
                  hintStyle: GoogleFonts.poppins(
                    color: Colors.black38,
                    fontSize: ResponsiveUtils.fontSizeBody(context),
                  ),
                  prefixIcon:
                      const Icon(Icons.search_rounded, color: Colors.black38),
                  suffixIcon: IconButton(
                    onPressed: () {
                      textController.clear();
                      recipeController.searchRecipes('');
                      onQueryChanged('');
                      FocusScope.of(context).unfocus();
                    },
                    icon: const Icon(
                      Icons.close_rounded,
                      color: Colors.black38,
                    ),
                  ),
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: isSmall ? 10 : 14),
                ),
              ),
            ),
          ),
          SizedBox(width: ResponsiveUtils.spacingSmall(context)),
          Container(
            width: ResponsiveUtils.inputHeight(context),
            height: ResponsiveUtils.inputHeight(context),
            decoration: BoxDecoration(
              color: const Color(0xFF1B8A6B),
              borderRadius:
                  BorderRadius.circular(ResponsiveUtils.borderRadius(context)),
            ),
            child: Icon(
              Icons.tune_rounded,
              color: Colors.white,
              size: ResponsiveUtils.iconSize(context),
            ),
          ).animate().shake(delay: 600.ms, duration: 600.ms),
        ],
      ),
    ).animate().fadeIn(delay: 200.ms);
  }
}
