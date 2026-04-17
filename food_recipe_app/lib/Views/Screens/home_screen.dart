import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Utils/responsive_utils.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  int _selectedCategory = 0;
  late AnimationController _animationController;

  final List<String> _categories = [
    'All',
    'Indian',
    'Italian',
    'Asian',
    'Chinese'
  ];

  final List<Map<String, dynamic>> _featuredRecipes = [
    {
      'id': '1',
      'title': 'Classic Greek\nSalad',
      'time': '15 Mins',
      'rating': 4.5,
      'image':
          'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?w=400',
      'author': 'By Chef Maria',
      'calories': '250 kcal',
    },
    {
      'id': '2',
      'title': 'Crunchy Nut\nColeslaw',
      'time': '10 Mins',
      'rating': 3.5,
      'image':
          'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=400',
      'author': 'By John Doe',
      'calories': '180 kcal',
    },
    {
      'id': '3',
      'title': 'Spicy Chicken\nBurger',
      'time': '20 Mins',
      'rating': 4.8,
      'image':
          'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=400',
      'author': 'By Chef Ahmed',
      'calories': '450 kcal',
    },
  ];

  final List<Map<String, dynamic>> _newRecipes = [
    {
      'id': '4',
      'title': 'Steak with tomato sauce',
      'author': 'By James Milner',
      'time': '20 mins',
      'rating': 5,
      'image':
          'https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=400',
      'calories': '520 kcal',
    },
    {
      'id': '5',
      'title': 'Pilaf sweet rice',
      'author': 'By Laura W.',
      'time': '25 mins',
      'rating': 4,
      'image':
          'https://images.unsplash.com/photo-1563379091339-03246963d96a?w=400',
      'calories': '380 kcal',
    },
    {
      'id': '6',
      'title': 'Spicy Chicken Burger',
      'author': 'By Laura Wilson',
      'time': '20 mins',
      'rating': 4,
      'image':
          'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=400',
      'calories': '450 kcal',
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onNavItemTapped(int index) {
    setState(() => _currentIndex = index);
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
    final isDesktop = ResponsiveUtils.isDesktop(context);

    return Scaffold(
      backgroundColor: Colors.white,

      // 👉 Desktop: Drawer | Mobile: BottomNavBar
      drawer: isDesktop ? _buildDesktopDrawer() : null,

      body: Row(
        children: [
          // 👉 Sidebar للديسكتوب فقط
          if (isDesktop) _buildDesktopSidebar(),

          // 👉 المحتوى الرئيسي
          Expanded(
            child: IndexedStack(
              index: isDesktop
                  ? 0
                  : _currentIndex, // على الديسكتوب نعرض الهوم دايماً
              children: [
                _buildHomeBody(),
                const Center(
                    child: Text('Saved', style: TextStyle(fontSize: 24))),
                const Center(
                    child: Text('Add Recipe', style: TextStyle(fontSize: 24))),
                const Center(
                    child:
                        Text('Notifications', style: TextStyle(fontSize: 24))),
                const ProfileScreen(),
              ],
            ),
          ),
        ],
      ),

      // 👉 Mobile Only: Bottom Navigation
      bottomNavigationBar: isDesktop ? null : _buildBottomNav(),

      // FAB removed per UI request
    );
  }

  // ─────────────────────────────────────────────
  // 👉 Desktop Sidebar / Drawer
  // ─────────────────────────────────────────────

  Widget _buildDesktopSidebar() {
    return Container(
      width: 240,
      color: const Color(0xFFF8F9FA),
      child: Column(
        children: [
          const SizedBox(height: 20),
          // Logo
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1B8A6B),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.restaurant_menu_rounded,
                      color: Colors.white, size: 24),
                ),
                const SizedBox(width: 12),
                Text(
                  'Cooking App',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1B8A6B),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          // Nav Items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              children: [
                _desktopNavItem(Icons.home_rounded, 'Home', 0),
                _desktopNavItem(Icons.bookmark_border_rounded, 'Saved', 1),
                _desktopNavItem(Icons.add_circle_rounded, 'Add Recipe', 2),
                _desktopNavItem(
                    Icons.notifications_none_rounded, 'Notifications', 3),
                const Divider(height: 32),
                _desktopNavItem(Icons.person_outline_rounded, 'Profile', 4),
                _desktopNavItem(Icons.settings_outlined, 'Settings', 5),
              ],
            ),
          ),
          // User Profile at Bottom
          _buildDesktopUserProfile(),
        ],
      ),
    );
  }

  Widget _buildDesktopDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Jega Kumar',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
            accountEmail: const Text('jega@example.com'),
            currentAccountPicture: const CircleAvatar(
              backgroundImage: NetworkImage(
                'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100',
              ),
            ),
            decoration: const BoxDecoration(color: Color(0xFF1B8A6B)),
          ),
          _desktopNavItem(Icons.home_rounded, 'Home', 0, isDrawer: true),
          _desktopNavItem(Icons.bookmark_border_rounded, 'Saved', 1,
              isDrawer: true),
          _desktopNavItem(Icons.add_circle_rounded, 'Add Recipe', 2,
              isDrawer: true),
          _desktopNavItem(Icons.notifications_none_rounded, 'Notifications', 3,
              isDrawer: true),
          const Divider(),
          _desktopNavItem(Icons.person_outline_rounded, 'Profile', 4,
              isDrawer: true),
          _desktopNavItem(Icons.settings_outlined, 'Settings', 5,
              isDrawer: true),
        ],
      ),
    );
  }

  Widget _desktopNavItem(IconData icon, String label, int index,
      {bool isDrawer = false}) {
    final isActive = (isDrawer ? _currentIndex : _currentIndex) == index;

    return ListTile(
      leading: Icon(icon,
          color: isActive ? const Color(0xFF1B8A6B) : Colors.black54, size: 22),
      title: Text(label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
            color: isActive ? const Color(0xFF1B8A6B) : Colors.black87,
          )),
      selected: isActive,
      selectedTileColor: const Color(0xFF1B8A6B).withOpacity(0.1),
      onTap: () {
        if (isDrawer) Navigator.pop(context); // Close drawer
        setState(() => _currentIndex = index);
      },
    );
  }

  Widget _buildDesktopUserProfile() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 18,
            backgroundImage: NetworkImage(
              'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100',
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Jega Kumar',
                    style: GoogleFonts.poppins(
                        fontSize: 13, fontWeight: FontWeight.w600)),
                Text('Food Enthusiast',
                    style: GoogleFonts.poppins(
                        fontSize: 11, color: Colors.black45)),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.logout_rounded,
                size: 20, color: Colors.black45),
            onPressed: () {
              // Logout logic
            },
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  // 👉 Main Home Body (Responsive)
  // ─────────────────────────────────────────────

  Widget _buildHomeBody() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: ResponsiveUtils.verticalPadding(context),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 👉 Header
            _buildHeader(),

            // 👉 Search Bar
            _buildSearchBar(),

            const SizedBox(height: 16),

            // 👉 Categories
            _buildCategories(),

            const SizedBox(height: 16),

            // 👉 Featured Recipes (Horizontal)
            _buildFeaturedRecipes(),

            const SizedBox(height: 20),

            // 👉 New Recipes (Vertical List)
            _buildNewRecipesSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.horizontalPadding(context),
        vertical: ResponsiveUtils.spacingMedium(context),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Hello Jega',
                        style: GoogleFonts.poppins(
                          fontSize: ResponsiveUtils.fontSizeHeading(context),
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ))
                    .animate()
                    .fadeIn(delay: 100.ms)
                    .slideX(begin: -0.3, end: 0),
                Text('What are you cooking today?',
                        style: GoogleFonts.poppins(
                          fontSize: ResponsiveUtils.fontSizeBody(context),
                          color: Colors.black45,
                        ))
                    .animate()
                    .fadeIn(delay: 200.ms)
                    .slideX(begin: -0.3, end: 0),
              ],
            ),
          ),
          Container(
            width: ResponsiveUtils.getValue4<double>(
              context,
              small: 36,
              medium: 40,
              large: 44,
              xlarge: 48,
            ),
            height: ResponsiveUtils.getValue4<double>(
              context,
              small: 36,
              medium: 40,
              large: 44,
              xlarge: 48,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: const DecorationImage(
                image: NetworkImage(
                  'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ).animate().scale(delay: 300.ms, curve: Curves.easeOutBack),
        ],
      ),
    ).animate().fadeIn(delay: 100.ms);
  }

  // ─────────────────────────────────────────────
  // 👉 Search Bar
  // ─────────────────────────────────────────────

  Widget _buildSearchBar() {
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
                decoration: InputDecoration(
                  hintText: 'Search recipe',
                  hintStyle: GoogleFonts.poppins(
                      color: Colors.black38,
                      fontSize: ResponsiveUtils.fontSizeBody(context)),
                  prefixIcon:
                      const Icon(Icons.search_rounded, color: Colors.black38),
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

  // ─────────────────────────────────────────────
  // 👉 Categories (Horizontal List)
  // ─────────────────────────────────────────────

  Widget _buildCategories() {
    return SizedBox(
      height: 36,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(
            horizontal: ResponsiveUtils.horizontalPadding(context)),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final isSelected = _selectedCategory == index;
          return GestureDetector(
            onTap: () => setState(() => _selectedCategory = index),
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
                _categories[index],
                style: GoogleFonts.poppins(
                  color: isSelected ? Colors.white : const Color(0xFF1B8A6B),
                  fontSize: ResponsiveUtils.fontSizeBody(context),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          )
              .animate()
              .fadeIn(
                delay: Duration(milliseconds: 300 + index * 100),
              )
              .slideX(begin: -0.2, end: 0);
        },
      ),
    );
  }

  // ─────────────────────────────────────────────
  // 👉 Featured Recipes (Horizontal Cards)
  // ─────────────────────────────────────────────

  Widget _buildFeaturedRecipes() {
    final isSmall = ResponsiveUtils.isSmallMobile(context);

    // حساب عرض الكارت حسب حجم الشاشة
    final cardWidth = ResponsiveUtils.getValue4<double>(
      context,
      small: MediaQuery.of(context).size.width * 0.7 - 40,
      medium: MediaQuery.of(context).size.width * 0.65 - 40,
      large: 280,
      xlarge: 320,
    );
    final cardHeight = ResponsiveUtils.getValue4<double>(
      context,
      small: 150,
      medium: 180,
      large: 200,
      xlarge: 220,
    );

    return SizedBox(
      height: cardHeight + 40, // + space for gradient overlay
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(
            horizontal: ResponsiveUtils.horizontalPadding(context)),
        itemCount: _featuredRecipes.length,
        itemBuilder: (context, index) {
          final recipe = _featuredRecipes[index];
          return GestureDetector(
            onTap: () {
              context.push('/recipe/${recipe['id']}', extra: recipe);
            },
            child: Container(
              width: cardWidth,
              margin: const EdgeInsets.only(right: 16),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                        ResponsiveUtils.borderRadiusLarge(context)),
                    child: Image.network(
                      recipe['image'],
                      width: double.infinity,
                      height: cardHeight,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey[300],
                        child:
                            const Icon(Icons.broken_image, color: Colors.grey),
                      ),
                    ),
                  ),
                  // Rating Badge
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFC107),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        recipe['rating'].toString(),
                        style: GoogleFonts.poppins(
                          fontSize: ResponsiveUtils.fontSizeSmall(context),
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  // Info Overlay
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(isSmall ? 8 : 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(
                              ResponsiveUtils.borderRadiusLarge(context)),
                          bottomRight: Radius.circular(
                              ResponsiveUtils.borderRadiusLarge(context)),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.7),
                            Colors.transparent,
                          ],
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            recipe['title'],
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: ResponsiveUtils.fontSizeBody(context),
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            recipe['time'],
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: ResponsiveUtils.fontSizeSmall(context),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
              .animate()
              .fadeIn(
                delay: Duration(milliseconds: 400 + index * 150),
              )
              .slideX(begin: 0.3, end: 0);
        },
      ),
    );
  }

  // ─────────────────────────────────────────────
  // 👉 New Recipes Section (Vertical List)
  // ─────────────────────────────────────────────

  Widget _buildNewRecipesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: ResponsiveUtils.horizontalPadding(context)),
          child: Text('New Recipes',
              style: GoogleFonts.poppins(
                fontSize: ResponsiveUtils.fontSizeHeading(context),
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              )).animate().fadeIn(delay: 700.ms).slideY(begin: 0.2, end: 0),
        ),
        const SizedBox(height: 12),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(
              horizontal: ResponsiveUtils.horizontalPadding(context)),
          itemCount: _newRecipes.length,
          itemBuilder: (context, index) {
            final recipe = _newRecipes[index];
            return _buildRecipeListItem(recipe, index);
          },
        ),
      ],
    );
  }

  Widget _buildRecipeListItem(Map<String, dynamic> recipe, int index) {
    final isSmall = ResponsiveUtils.isSmallMobile(context);
    final imageSize = ResponsiveUtils.getValue4<double>(
      context,
      small: 75,
      medium: 90,
      large: 100,
      xlarge: 110,
    );

    final card = Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(ResponsiveUtils.borderRadius(context)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: ResponsiveUtils.shadowBlurRadius(context),
            offset: ResponsiveUtils.shadowOffset(context),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(ResponsiveUtils.borderRadius(context)),
              bottomLeft:
                  Radius.circular(ResponsiveUtils.borderRadius(context)),
            ),
            child: Image.network(
              recipe['image'],
              width: imageSize,
              height: imageSize,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: imageSize,
                height: imageSize,
                color: Colors.grey[300],
                child: const Icon(Icons.broken_image, color: Colors.grey),
              ),
            ),
          ),
          SizedBox(width: ResponsiveUtils.spacingMedium(context)),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    recipe['title'],
                    style: GoogleFonts.poppins(
                      fontSize: ResponsiveUtils.fontSizeBody(context),
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: List.generate(
                      5,
                      (i) => Icon(
                        i < recipe['rating']
                            ? Icons.star_rounded
                            : Icons.star_outline_rounded,
                        color: const Color(0xFFFFC107),
                        size: ResponsiveUtils.iconSize(context),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: isSmall ? 8 : 10,
                        backgroundImage: const NetworkImage(
                          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=50',
                        ),
                      ),
                      SizedBox(width: ResponsiveUtils.spacingSmall(context)),
                      Expanded(
                        child: Text(
                          recipe['author'],
                          style: GoogleFonts.poppins(
                            fontSize: ResponsiveUtils.fontSizeSmall(context),
                            color: Colors.black45,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.access_time_rounded,
                              size: ResponsiveUtils.iconSize(context),
                              color: Colors.black45),
                          const SizedBox(width: 2),
                          Text(
                            recipe['time'],
                            style: GoogleFonts.poppins(
                              fontSize: ResponsiveUtils.fontSizeSmall(context),
                              color: Colors.black45,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    return GestureDetector(
      onTap: () {
        context.push('/recipe/${recipe['id']}', extra: recipe);
      },
      child: card
          .animate()
          .fadeIn(delay: Duration(milliseconds: 800 + index * 100))
          .slideX(begin: 0.2, end: 0),
    );
  }

  // ─────────────────────────────────────────────
  // 👉 Bottom Navigation (Mobile Only)
  // ─────────────────────────────────────────────

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
                color: Colors.black.withOpacity(0.08),
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
            tabBackgroundColor: const Color(0xFF1B8A6B).withOpacity(0.12),
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
