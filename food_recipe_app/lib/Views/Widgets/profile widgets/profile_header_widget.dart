import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Controllers/auth_controller.dart';
import '../../../Models/user_model.dart';
import '../../../Utils/responsive_utils.dart';

class ProfileHeaderWidget extends StatelessWidget {
  final bool isDesktop;

  const ProfileHeaderWidget({super.key, this.isDesktop = false});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel?>(
      future: AuthController().getCurrentUser(),
      builder: (context, snapshot) {
        final user = snapshot.data;
        final displayName =
            (user?.name.trim().isNotEmpty ?? false) ? user!.name : 'User';
        final isFemale = (user?.gender ?? '').toLowerCase() == 'female';
        final imagePath =
            isFemale ? 'assets/images/girl.jpg' : 'assets/images/boy.jpg';

        return _buildProfileHeader(
          context,
          displayName: displayName,
          profileImagePath: imagePath,
        );
      },
    );
  }

  Widget _buildProfileHeader(BuildContext context,
      {required String displayName, required String profileImagePath}) {
    final imageSize = ResponsiveUtils.getValue4<double>(context,
        small: 90, medium: 110, large: 120, xlarge: 140);
    final titleSize = ResponsiveUtils.getValue4<double>(context,
        small: 22, medium: 24, large: 28, xlarge: 32);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: isDesktop
          ? BoxDecoration(
              color: const Color(0xFF1B8A6B),
              borderRadius: BorderRadius.circular(
                  ResponsiveUtils.borderRadiusLarge(context)),
            )
          : const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF1B8A6B), Color(0xFF2ECCA8)],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: imageSize,
                height: imageSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 20,
                        offset: const Offset(0, 8))
                  ],
                  image: DecorationImage(
                      image: AssetImage(profileImagePath), fit: BoxFit.cover),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border:
                          Border.all(color: const Color(0xFF1B8A6B), width: 2)),
                  child: const Icon(Icons.camera_alt_rounded,
                      color: Color(0xFF1B8A6B), size: 18),
                ),
              ),
            ],
          )
              .animate()
              .scale(delay: 200.ms, curve: Curves.easeOutBack)
              .then()
              .shake(),
          SizedBox(height: ResponsiveUtils.spacingMedium(context)),
          Text(displayName,
                  style: GoogleFonts.poppins(
                      fontSize: titleSize,
                      fontWeight: FontWeight.w700,
                      color: Colors.white))
              .animate()
              .fadeIn(delay: 300.ms)
              .slideY(begin: 0.3, end: 0),
          SizedBox(height: ResponsiveUtils.spacingSmall(context)),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20)),
            child: Text('🍳 Food Enthusiast',
                style: GoogleFonts.poppins(
                    fontSize: ResponsiveUtils.fontSizeBody(context),
                    color: Colors.white,
                    fontWeight: FontWeight.w500)),
          ).animate().fadeIn(delay: 400.ms),
          SizedBox(height: ResponsiveUtils.spacingMedium(context)),
          Row(mainAxisSize: MainAxisSize.min, children: [
            Icon(Icons.verified_rounded, color: Colors.amber[300], size: 16),
            const SizedBox(width: 4),
            Text('Member since Jan 2024',
                style: GoogleFonts.poppins(
                    fontSize: ResponsiveUtils.fontSizeSmall(context),
                    color: Colors.white.withOpacity(0.9))),
          ]).animate().fadeIn(delay: 500.ms),
        ],
      ),
    );
  }
}

class ProfileHeaderSliver extends StatelessWidget {
  const ProfileHeaderSliver({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(child: ProfileHeaderWidget());
  }
}
