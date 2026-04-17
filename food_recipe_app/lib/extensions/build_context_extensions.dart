// 📁 lib/extensions/build_context_extensions.dart
import 'package:flutter/material.dart';
import '../Utils/responsive_utils.dart';
import '../utils/responsive_utils.dart';

extension ResponsiveBuildContext on BuildContext {
  bool get isSmallMobile => ResponsiveUtils.isSmallMobile(this);
  bool get isMobile => ResponsiveUtils.isMobile(this);
  bool get isTablet => ResponsiveUtils.isTablet(this);
  bool get isDesktop => ResponsiveUtils.isDesktop(this);


  double get horizontalPadding => ResponsiveUtils.horizontalPadding(this);
  double get verticalPadding => ResponsiveUtils.verticalPadding(this);
  double get spacingSmall => ResponsiveUtils.spacingSmall(this);
  double get spacingMedium => ResponsiveUtils.spacingMedium(this);
  double get spacingLarge => ResponsiveUtils.spacingLarge(this);

  double get fontSizeTitle => ResponsiveUtils.fontSizeTitle(this);
  double get fontSizeBody => ResponsiveUtils.fontSizeBody(this);
  double get fontSizeLabel => ResponsiveUtils.fontSizeLabel(this);

  double get inputHeight => ResponsiveUtils.inputHeight(this);
  double get buttonHeight => ResponsiveUtils.buttonHeight(this);
  double get borderRadius => ResponsiveUtils.borderRadius(this);
  double get iconSize => ResponsiveUtils.iconSize(this);
}