import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Utils/responsive_utils.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({
    super.key,
    required this.selectedIndex,
    required this.onCategorySelected,
  });

  final int selectedIndex;
  final void Function(int index, String category) onCategorySelected;

  static const List<String> categories = [
    'All',
    'Italy',
    'India',
    'Japan',
    'Mexico',
    'Others',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveUtils.horizontalPadding(context),
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final isSelected = selectedIndex == index;

          return GestureDetector(
            onTap: () => onCategorySelected(index, categories[index]),
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color:
                    isSelected ? const Color(0xFF1B8A6B) : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                border: isSelected
                    ? null
                    : Border.all(color: const Color(0xFF1B8A6B)),
              ),
              child: Text(
                categories[index],
                style: GoogleFonts.poppins(
                  color: isSelected ? Colors.white : const Color(0xFF1B8A6B),
                  fontSize: ResponsiveUtils.fontSizeBody(context),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          )
              .animate()
              .fadeIn(delay: Duration(milliseconds: 300 + index * 100))
              .slideX(begin: -0.2, end: 0);
        },
      ),
    );
  }
}
