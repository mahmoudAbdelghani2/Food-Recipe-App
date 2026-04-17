// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../Utils/responsive_utils.dart';

class AuthSubmitButton extends StatelessWidget {
  const AuthSubmitButton({
    super.key,
    required this.label,
    required this.isEnabled,
    required this.isLoading,
    this.onPressed,
  });

  final String label;
  final bool isEnabled;
  final bool isLoading;
  final FutureOr<void> Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: ResponsiveUtils.buttonHeight(context),
      child: ElevatedButton(
        onPressed: (isEnabled && !isLoading && onPressed != null)
            ? () async {
                await onPressed!.call();
              }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1B8A6B),
          disabledBackgroundColor: const Color(0xFF1B8A6B).withOpacity(0.4),
          disabledForegroundColor: Colors.white.withOpacity(0.7),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 0,
          textStyle: GoogleFonts.poppins(
            fontSize: ResponsiveUtils.fontSizeBody(context),
            fontWeight: FontWeight.w600,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading) ...[
              SizedBox(
                width: ResponsiveUtils.iconSize(context),
                height: ResponsiveUtils.iconSize(context),
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: ResponsiveUtils.spacingSmall(context)),
              const Text('Please wait...'),
            ] else ...[
              Text(label),
              SizedBox(width: ResponsiveUtils.spacingSmall(context)),
              Icon(
                Icons.arrow_forward_rounded,
                size: ResponsiveUtils.iconSize(context),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
