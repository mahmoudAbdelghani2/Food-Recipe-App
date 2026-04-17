// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Controllers/auth_controller.dart';
import '../../Utils/responsive_utils.dart';
import '../Screens/app_router_screen.dart';

class CustomLogoutButton extends StatelessWidget {
  const CustomLogoutButton({super.key});

  Future<void> _showLogoutDialog(BuildContext context) async {
    await showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(
            'Logout',
            style: GoogleFonts.poppins(fontWeight: FontWeight.w700),
          ),
          content: Text(
            'Do you want to log out?',
            style: GoogleFonts.poppins(color: Colors.black54),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(
                'Cancel',
                style: GoogleFonts.poppins(color: Colors.black87),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(dialogContext).pop();
                await AuthController().logoutUser();
                authState.value = false;
                if (!context.mounted) return;
                context.go('/login');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: Text(
                'Logout',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(ResponsiveUtils.borderRadius(context)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.red.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            Icons.logout_rounded,
            color: Colors.red,
            size: ResponsiveUtils.iconSize(context),
          ),
        ),
        title: Text(
          'Logout',
          style: GoogleFonts.poppins(
            fontSize: ResponsiveUtils.fontSizeBody(context),
            fontWeight: FontWeight.w600,
            color: Colors.red,
          ),
        ),
        subtitle: Text(
          'Sign out from your account',
          style: GoogleFonts.poppins(
            fontSize: ResponsiveUtils.fontSizeSmall(context),
            color: Colors.black45,
          ),
        ),
        trailing: Icon(
          Icons.chevron_right_rounded,
          color: Colors.black38,
          size: ResponsiveUtils.iconSize(context),
        ),
        onTap: () => _showLogoutDialog(context),
      ),
    ).animate().fadeIn(delay: 800.ms);
  }
}
