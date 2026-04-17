import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
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

  @override
  Widget build(BuildContext context) {
    final recipe = recipeData ?? _getDummyRecipe();
    final isDesktop = ResponsiveUtils.isDesktop(context);
    final isSmall = ResponsiveUtils.isSmallMobile(context);

    // 👉 Responsive Values
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
    final sectionTitleSize = ResponsiveUtils.getValue4<double>(
      context,
      small: 16,
      medium: 18,
      large: 20,
      xlarge: 22,
    );
    final bodyFontSize = ResponsiveUtils.fontSizeBody(context);
    final smallFontSize = ResponsiveUtils.fontSizeSmall(context);
    final iconSize = ResponsiveUtils.iconSize(context);
    final borderRadius = ResponsiveUtils.borderRadius(context);
    final borderRadiusLarge = ResponsiveUtils.borderRadiusLarge(context);
    final spacingSmall = ResponsiveUtils.spacingSmall(context);
    final spacingMedium = ResponsiveUtils.spacingMedium(context);
    final spacingLarge = ResponsiveUtils.spacingLarge(context);
    final horizontalPadding = ResponsiveUtils.horizontalPadding(context);

    return Scaffold(
      backgroundColor: Colors.white,

      // 👉 Desktop: App Bar مخصص
      appBar: isDesktop
          ? AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new),
                onPressed: () => context.pop(),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.favorite_border_rounded),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.share_rounded),
                  onPressed: () {},
                ),
                SizedBox(width: horizontalPadding * 0.5),
              ],
            )
          : null,

      body: isDesktop
          // 👉 Desktop Layout: عمودين (صورة + محتوى)
          ? _buildDesktopLayout(context, recipe, borderRadiusLarge,
              spacingLarge, horizontalPadding)
          // 👉 Mobile/Tablet Layout: Scroll عادي
          : _buildMobileLayout(
              context,
              recipe,
              appBarHeight,
              titleFontSize,
              sectionTitleSize,
              bodyFontSize,
              smallFontSize,
              iconSize,
              borderRadius,
              borderRadiusLarge,
              spacingSmall,
              spacingMedium,
              spacingLarge,
              horizontalPadding,
              isSmall,
            ),

      // 👉 Bottom Bar: يظهر على الموبايل/تابلت فقط
      bottomNavigationBar: isDesktop
          ? null
          : _buildBottomBar(context, iconSize, bodyFontSize, borderRadius),
    );
  }

  // ─────────────────────────────────────────────
  // 👉 Desktop Layout (Two Columns)
  // ─────────────────────────────────────────────

  Widget _buildDesktopLayout(
    BuildContext context,
    Map<String, dynamic> recipe,
    double borderRadiusLarge,
    double spacingLarge,
    double horizontalPadding,
  ) {
    return Row(
      children: [
        // 👈 Image Column (40%)
        Expanded(
          flex: 4,
          child: Container(
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image:
                    CachedNetworkImageProvider(_safeImageUrl(recipe['image'])),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                // Gradient Overlay
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.3),
                      ],
                    ),
                  ),
                ),
                // Back Button
                Positioned(
                  top: 20,
                  left: 20,
                  child: IconButton(
                    icon: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.arrow_back_ios_new, size: 20),
                    ),
                    onPressed: () => context.pop(),
                  ),
                ),
                // Action Buttons
                Positioned(
                  top: 20,
                  right: 20,
                  child: Column(
                    children: [
                      _desktopActionButton(
                          Icons.favorite_border_rounded, () {}),
                      const SizedBox(height: 12),
                      _desktopActionButton(Icons.share_rounded, () {}),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // 👈 Content Column (60%)
        Expanded(
          flex: 6,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(ResponsiveUtils.verticalPadding(context)),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDesktopContent(
                      context, recipe, borderRadiusLarge, spacingLarge),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _desktopActionButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, size: 20),
      ),
    );
  }

  Widget _buildDesktopContent(
    BuildContext context,
    Map<String, dynamic> recipe,
    double borderRadiusLarge,
    double spacingLarge,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Text(
          recipe['title'],
          style: GoogleFonts.poppins(
            fontSize: ResponsiveUtils.fontSizeTitle(context),
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.3, end: 0),

        SizedBox(height: ResponsiveUtils.spacingSmall(context)),

        // Author & Rating
        Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundImage: CachedNetworkImageProvider(
                'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=50',
              ),
            ),
            SizedBox(width: ResponsiveUtils.spacingSmall(context)),
            Text(
              recipe['author'] ?? 'By Chef',
              style: GoogleFonts.poppins(
                fontSize: ResponsiveUtils.fontSizeBody(context),
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Icon(Icons.star_rounded, color: const Color(0xFFFFC107), size: 20),
            SizedBox(width: 4),
            Text(
              recipe['rating']?.toString() ?? '4.5',
              style: GoogleFonts.poppins(
                fontSize: ResponsiveUtils.fontSizeBody(context),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.3, end: 0),

        SizedBox(height: spacingLarge),

        // Info Cards (Horizontal)
        Row(
          children: [
            _buildInfoCard(
              icon: Icons.access_time_rounded,
              label: 'Time',
              value: recipe['time'] ?? '20 mins',
              color: const Color(0xFF1B8A6B),
              context: context,
            ),
            SizedBox(width: ResponsiveUtils.spacingMedium(context)),
            _buildInfoCard(
              icon: Icons.local_fire_department_rounded,
              label: 'Calories',
              value: recipe['calories'] ?? '350 kcal',
              color: const Color(0xFFFF6B6B),
              context: context,
            ),
            SizedBox(width: ResponsiveUtils.spacingMedium(context)),
            _buildInfoCard(
              icon: Icons.restaurant_rounded,
              label: 'Servings',
              value: '2-3',
              color: const Color(0xFF4ECDC4),
              context: context,
            ),
          ],
        ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.3, end: 0),

        SizedBox(height: spacingLarge),

        // Description
        _buildSectionTitle('Description', context, 500),
        SizedBox(height: ResponsiveUtils.spacingSmall(context)),
        Text(
          'This delicious recipe is perfect for any occasion. Made with fresh ingredients and lots of love, it will surely satisfy your taste buds.',
          style: GoogleFonts.poppins(
            fontSize: ResponsiveUtils.fontSizeBody(context),
            color: Colors.black54,
            height: 1.6,
          ),
        ).animate().fadeIn(delay: 600.ms).slideX(begin: -0.2, end: 0),

        SizedBox(height: spacingLarge),

        // Ingredients & Instructions Side by Side
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ingredients
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('Ingredients', context, 700),
                  SizedBox(height: ResponsiveUtils.spacingSmall(context)),
                  ..._buildIngredientsList(context).take(4),
                ],
              ),
            ),
            SizedBox(width: spacingLarge),
            // Instructions
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('Instructions', context, 700),
                  SizedBox(height: ResponsiveUtils.spacingSmall(context)),
                  ..._buildInstructionsList(context).take(3),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 80),
      ],
    );
  }

  // ─────────────────────────────────────────────
  // 👉 Mobile/Tablet Layout (Single Column)
  // ─────────────────────────────────────────────

  Widget _buildMobileLayout(
    BuildContext context,
    Map<String, dynamic> recipe,
    double appBarHeight,
    double titleFontSize,
    double sectionTitleSize,
    double bodyFontSize,
    double smallFontSize,
    double iconSize,
    double borderRadius,
    double borderRadiusLarge,
    double spacingSmall,
    double spacingMedium,
    double spacingLarge,
    double horizontalPadding,
    bool isSmall,
  ) {
    return CustomScrollView(
      slivers: [
        // 👉 App Bar with Hero Image
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

        // 👉 Content
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  recipe['title'],
                  style: GoogleFonts.poppins(
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.3, end: 0),

                SizedBox(height: spacingSmall),

                // Author & Rating
                Row(
                  children: [
                    CircleAvatar(
                      radius: isSmall ? 14 : 16,
                      backgroundImage: CachedNetworkImageProvider(
                        'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=50',
                      ),
                    ),
                    SizedBox(width: spacingSmall),
                    Text(
                      recipe['author'] ?? 'By Chef',
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

                // Info Cards
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
                      value: '2-3',
                      color: const Color(0xFF4ECDC4),
                      context: context,
                    ),
                  ],
                ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.3, end: 0),

                SizedBox(height: spacingLarge),

                // Description
                _buildSectionTitle('Description', context, 500),
                SizedBox(height: spacingSmall),
                Text(
                  'This delicious recipe is perfect for any occasion. Made with fresh ingredients and lots of love, it will surely satisfy your taste buds. Follow the steps below to create this amazing dish.',
                  style: GoogleFonts.poppins(
                    fontSize: bodyFontSize,
                    color: Colors.black54,
                    height: 1.6,
                  ),
                ).animate().fadeIn(delay: 600.ms).slideX(begin: -0.2, end: 0),

                SizedBox(height: spacingLarge),

                // Ingredients
                _buildSectionTitle('Ingredients', context, 700),
                SizedBox(height: spacingSmall),
                ..._buildIngredientsList(context).map((item) => item
                    .animate()
                    .fadeIn(
                        delay: Duration(
                            milliseconds: 800 +
                                (_buildIngredientsList(context).indexOf(item) *
                                    100)))
                    .slideX(begin: -0.2, end: 0)),

                SizedBox(height: spacingLarge),

                // Instructions
                _buildSectionTitle('Instructions', context, 1200),
                SizedBox(height: spacingSmall),
                ..._buildInstructionsList(context).map((item) => item
                    .animate()
                    .fadeIn(
                        delay: Duration(
                            milliseconds: 1300 +
                                (_buildInstructionsList(context).indexOf(item) *
                                    150)))
                    .slideX(begin: -0.2, end: 0)),

                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ─────────────────────────────────────────────
  // 👉 Helper Widgets (Responsive)
  // ─────────────────────────────────────────────

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
          color: color.withOpacity(0.1),
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

  List<Widget> _buildIngredientsList(BuildContext context) {
    final ingredients = [
      '2 cups fresh vegetables',
      '1 tbsp olive oil',
      'Salt and pepper to taste',
      'Fresh herbs',
      '1 cup protein of choice',
    ];
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
            Text(
              ingredient,
              style: GoogleFonts.poppins(
                  fontSize: fontSize, color: Colors.black87),
            ),
          ],
        ),
      );
    }).toList();
  }

  List<Widget> _buildInstructionsList(BuildContext context) {
    final instructions = [
      'Prepare all ingredients and wash vegetables thoroughly',
      'Heat olive oil in a pan over medium heat',
      'Add protein and cook until golden brown',
      'Add vegetables and stir fry for 5 minutes',
      'Season with salt, pepper, and herbs',
      'Serve hot and enjoy!',
    ];
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

  Widget _buildBottomBar(
    BuildContext context,
    double iconSize,
    double fontSize,
    double borderRadius,
  ) {
    return Container(
      padding: EdgeInsets.all(ResponsiveUtils.horizontalPadding(context)),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.play_arrow_rounded, size: iconSize),
                label: Text('Start Cooking',
                    style: GoogleFonts.poppins(fontSize: fontSize)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1B8A6B),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Map<String, dynamic> _getDummyRecipe() {
    return {
      'title': 'Delicious Recipe',
      'author': 'By Chef',
      'time': '20 mins',
      'rating': 4.5,
      'calories': '350 kcal',
      'image':
          'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?w=400',
    };
  }
}
