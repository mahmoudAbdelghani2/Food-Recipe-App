// 📁 lib/utils/responsive_utils.dart
import 'package:flutter/material.dart';

class ResponsiveUtils {
  static const double breakpointSmallMobile = 360;
  static const double breakpointMobile = 480;
  static const double breakpointTablet = 768;
  static const double breakpointDesktop = 1024;
  static const double breakpointDesktopLarge = 1440;


  static bool isSmallMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < breakpointSmallMobile;


  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < breakpointMobile;

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= breakpointMobile && width < breakpointTablet;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= breakpointTablet;


  static bool isDesktopLarge(BuildContext context) =>
      MediaQuery.of(context).size.width >= breakpointDesktopLarge;



  static T getValue<T>(
      BuildContext context, {
        required T small,
        required T medium,
        required T large,
      }) {
    final width = MediaQuery.of(context).size.width;
    if (width < breakpointMobile) return small;
    if (width < breakpointTablet) return medium;
    return large;
  }


  static T getValue4<T>(
      BuildContext context, {
        required T small,      // < 360
        required T medium,     // 360-480
        required T large,      // 480-768
        required T xlarge,     // >= 768
      }) {
    final width = MediaQuery.of(context).size.width;
    if (width < breakpointSmallMobile) return small;
    if (width < breakpointMobile) return medium;
    if (width < breakpointTablet) return large;
    return xlarge;
  }

  static double horizontalPadding(BuildContext context) =>
      getValue4<double>(
        context,
        small: 16,
        medium: 24,
        large: 40,
        xlarge: 80,
      );


  static double verticalPadding(BuildContext context) =>
      getValue4<double>(
        context,
        small: 20,
        medium: 32,
        large: 48,
        xlarge: 64,
      );


  static double spacingSmall(BuildContext context) =>
      getValue4<double>(
        context,
        small: 6,
        medium: 8,
        large: 10,
        xlarge: 12,
      );


  static double spacingMedium(BuildContext context) =>
      getValue4<double>(
        context,
        small: 12,
        medium: 16,
        large: 20,
        xlarge: 24,
      );


  static double spacingLarge(BuildContext context) =>
      getValue4<double>(
        context,
        small: 20,
        medium: 28,
        large: 32,
        xlarge: 40,
      );


  static double fontSizeTitle(BuildContext context) =>
      getValue4<double>(
        context,
        small: 26,
        medium: 30,
        large: 36,
        xlarge: 42,
      );


  static double fontSizeHeading(BuildContext context) =>
      getValue4<double>(
        context,
        small: 20,
        medium: 24,
        large: 28,
        xlarge: 32,
      );

  static double fontSizeBody(BuildContext context) =>
      getValue4<double>(
        context,
        small: 12,
        medium: 13,
        large: 14,
        xlarge: 15,
      );


  static double fontSizeLabel(BuildContext context) =>
      getValue4<double>(
        context,
        small: 13,
        medium: 14,
        large: 15,
        xlarge: 16,
      );


  static double fontSizeSmall(BuildContext context) =>
      getValue4<double>(
        context,
        small: 10,
        medium: 11,
        large: 12,
        xlarge: 13,
      );


  static double inputHeight(BuildContext context) =>
      getValue4<double>(
        context,
        small: 48,
        medium: 52,
        large: 56,
        xlarge: 60,
      );

  static double buttonHeight(BuildContext context) =>
      getValue4<double>(
        context,
        small: 48,
        medium: 52,
        large: 56,
        xlarge: 60,
      );


  static double borderRadius(BuildContext context) =>
      getValue4<double>(
        context,
        small: 12,
        medium: 14,
        large: 16,
        xlarge: 20,
      );

  static double borderRadiusLarge(BuildContext context) =>
      getValue4<double>(
        context,
        small: 16,
        medium: 20,
        large: 24,
        xlarge: 32,
      );


  static double iconSize(BuildContext context) =>
      getValue4<double>(
        context,
        small: 18,
        medium: 20,
        large: 22,
        xlarge: 24,
      );


  static double iconSizeLarge(BuildContext context) =>
      getValue4<double>(
        context,
        small: 24,
        medium: 28,
        large: 32,
        xlarge: 40,
      );

  static double heroImageHeight(BuildContext context) =>
      getValue4<double>(
        context,
        small: 200,
        medium: 240,
        large: 280,
        xlarge: 350,
      );
  static double? maxContentWidth(BuildContext context) =>
      isDesktop(context) ? 500 : null;


  static int gridCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < breakpointSmallMobile) return 2;
    if (width < breakpointMobile) return 2;
    if (width < breakpointTablet) return 3;
    if (width < breakpointDesktop) return 4;
    return 5;
  }


  static double gridChildAspectRatio(BuildContext context) =>
      isDesktop(context) ? 0.9 : 0.8;


  static double shadowBlurRadius(BuildContext context) =>
      getValue<double>(
        context,
        small: 10,
        medium: 15,
        large: 20,
      );

  static Offset shadowOffset(BuildContext context) =>
      getValue<Offset>(
        context,
        small: const Offset(0, 2),
        medium: const Offset(0, 3),
        large: const Offset(0, 4),
      );

  static bool showBottomNav(BuildContext context) => !isDesktop(context);


  static bool showDrawer(BuildContext context) => isDesktop(context);
}