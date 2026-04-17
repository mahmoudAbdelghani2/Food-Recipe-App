import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../Utils/responsive_utils.dart';

class AuthSocialButtons extends StatelessWidget {
  const AuthSocialButtons({
    super.key,
    this.showAppleOnLarge = false,
    this.compactOnSmall = false,
  });

  final bool showAppleOnLarge;
  final bool compactOnSmall;

  @override
  Widget build(BuildContext context) {
    final spacing = ResponsiveUtils.spacingMedium(context);
    final isSmall = ResponsiveUtils.isSmallMobile(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AuthSocialButton(
          icon: Icons.g_mobiledata_rounded,
          label: 'Google',
          compact: compactOnSmall && isSmall,
          color: const Color(0xFFEA4335),
        ),
        SizedBox(width: spacing),
        AuthSocialButton(
          icon: Icons.facebook_rounded,
          label: 'Facebook',
          compact: compactOnSmall && isSmall,
          color: const Color(0xFF1877F2),
        ),
        if (showAppleOnLarge &&
            (ResponsiveUtils.isTablet(context) ||
                ResponsiveUtils.isDesktop(context))) ...[
          SizedBox(width: spacing),
          const AuthSocialButton(
            icon: Icons.apple_rounded,
            label: 'Apple',
            color: Colors.black,
          ),
        ],
      ],
    );
  }
}

class AuthSocialButton extends StatelessWidget {
  const AuthSocialButton({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    this.compact = false,
  });

  final IconData icon;
  final String label;
  final Color color;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final borderRadius = ResponsiveUtils.borderRadius(context);
    final iconSize = ResponsiveUtils.iconSize(context);
    final isSmall = ResponsiveUtils.isSmallMobile(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmall ? 12 : 16,
        vertical: isSmall ? 10 : 12,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE8E8E8)),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: iconSize),
          if (!compact) ...[
            SizedBox(width: ResponsiveUtils.spacingSmall(context)),
            Text(
              label,
              style: GoogleFonts.poppins(
                color: Colors.black87,
                fontSize: ResponsiveUtils.fontSizeBody(context),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
