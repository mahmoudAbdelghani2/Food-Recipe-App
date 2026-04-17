import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../../Controllers/auth_controller.dart';
import '../../Utils/responsive_utils.dart';

import 'app_router_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  final AuthController _authController = AuthController();
  late AnimationController _controller;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;
  bool _hasNavigated = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _fadeAnim = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
    _initSessionAndNavigate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _initSessionAndNavigate() async {
    final isLoggedIn = await _authController.isUserLoggedIn();
    authState.value = isLoggedIn;

    await Future.delayed(const Duration(milliseconds: 1400));
    _navigateToNext();
  }

  void _navigateToNext() {
    if (!mounted || _hasNavigated) return;
    _hasNavigated = true;

    final nextRoute = authState.value == true ? '/home' : '/login';
    context.go(nextRoute);
  }

  @override
  Widget build(BuildContext context) {
    // 👉 Responsive values using ResponsiveUtils
    final isSmallMobile = ResponsiveUtils.isSmallMobile(context);
    final isDesktop = ResponsiveUtils.isDesktop(context);

    final logoSize = ResponsiveUtils.getValue4<double>(
      context,
      small: 70,
      medium: 80,
      large: 90,
      xlarge: 100,
    );
    final iconSize = ResponsiveUtils.getValue4<double>(
      context,
      small: 32,
      medium: 40,
      large: 44,
      xlarge: 48,
    );
    final titleFontSize = ResponsiveUtils.getValue4<double>(
      context,
      small: 36,
      medium: 44,
      large: 52,
      xlarge: 64,
    );
    final subtitleFontSize = ResponsiveUtils.getValue4<double>(
      context,
      small: 13,
      medium: 14,
      large: 15,
      xlarge: 16,
    );
    final badgeFontSize = ResponsiveUtils.getValue4<double>(
      context,
      small: 12,
      medium: 13,
      large: 14,
      xlarge: 15,
    );
    final buttonHeight = ResponsiveUtils.buttonHeight(context);
    final buttonFontSize = ResponsiveUtils.fontSizeBody(context);
    final buttonIconSize = ResponsiveUtils.iconSize(context);
    final horizontalPadding = ResponsiveUtils.horizontalPadding(context);
    final spacingSmall = ResponsiveUtils.spacingSmall(context);
    final spacingMedium = ResponsiveUtils.spacingMedium(context);
    final spacingLarge = ResponsiveUtils.spacingLarge(context);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 👉 Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const CachedNetworkImageProvider(
                  'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=800',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 👉 Gradient Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.55),
                  Colors.black.withOpacity(0.75),
                ],
              ),
            ),
          ),

          // 👉 Content
          SafeArea(
            child: FadeTransition(
              opacity: _fadeAnim,
              child: SlideTransition(
                position: _slideAnim,
                child: Column(
                  children: [
                    // 👉 Top Spacer (Responsive)
                    Spacer(flex: isSmallMobile ? 1 : 2),

                    // 👉 Logo Circle
                    Container(
                      width: logoSize,
                      height: logoSize,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white30,
                          width: isSmallMobile ? 1 : 1.5,
                        ),
                      ),
                      child: Icon(
                        Icons.restaurant_menu_rounded,
                        color: Colors.white,
                        size: iconSize,
                      ),
                    ),
                    SizedBox(height: spacingMedium),

                    // 👉 Badge Text
                    Text(
                      '100K+ Premium Recipe',
                      style: GoogleFonts.poppins(
                        color: Colors.white70,
                        fontSize: badgeFontSize,
                        letterSpacing: 0.5,
                      ),
                    ),

                    // 👉 Middle Spacer (Responsive)
                    Spacer(flex: isSmallMobile ? 1 : 2),

                    // 👉 Main Title "Get\nCooking"
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: horizontalPadding * 0.5),
                      child: Text(
                        'Get\nCooking',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: titleFontSize,
                          fontWeight: FontWeight.w700,
                          height: 1.1,
                        ),
                      ),
                    ),
                    SizedBox(height: spacingSmall),

                    // 👉 Subtitle
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: horizontalPadding * 0.5),
                      child: Text(
                        'Simple way to find Tasty Recipe',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          color: Colors.white60,
                          fontSize: subtitleFontSize,
                        ),
                      ),
                    ),
                    SizedBox(height: spacingLarge),

                    // 👉 Start Cooking Button
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: horizontalPadding),
                      child: SizedBox(
                        width: double.infinity,
                        height: buttonHeight,
                        child: ElevatedButton(
                          onPressed: _navigateToNext,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1B8A6B),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 0,
                            textStyle: GoogleFonts.poppins(
                              fontSize: buttonFontSize,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Start Cooking'),
                              SizedBox(width: spacingSmall),
                              Icon(Icons.arrow_forward_rounded,
                                  size: buttonIconSize),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: spacingLarge),

                    // 👉 Extra spacing for desktop
                    if (isDesktop) const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
