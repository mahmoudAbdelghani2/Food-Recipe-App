import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Controllers/auth_controller.dart';
import '../../../Models/user_model.dart';
import '../../../Utils/responsive_utils.dart';

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel?>(
      future: AuthController().getCurrentUser(),
      builder: (context, snapshot) {
        final user = snapshot.data;
        final firstName = _extractFirstName(user?.name ?? '');
        final isFemale = (user?.gender ?? '').toLowerCase() == 'female';
        final profileImagePath =
            isFemale ? 'assets/images/girl.jpg' : 'assets/images/boy.jpg';

        return _buildHeaderContent(
          context,
          firstName: firstName,
          profileImagePath: profileImagePath,
        );
      },
    );
  }

  String _extractFirstName(String fullName) {
    final trimmed = fullName.trim();
    if (trimmed.isEmpty) return 'User';

    var firstName = '';
    for (var i = 0; i < trimmed.length; i++) {
      if (trimmed[i] == ' ') break;
      firstName += trimmed[i];
    }

    return firstName.isEmpty ? 'User' : firstName;
  }

  Widget _buildHeaderContent(BuildContext context,
      {required String firstName, required String profileImagePath}) {
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
                Text('Hello $firstName',
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
              image: DecorationImage(
                image: AssetImage(profileImagePath),
                fit: BoxFit.cover,
              ),
            ),
          ).animate().scale(delay: 300.ms, curve: Curves.easeOutBack),
        ],
      ),
    ).animate().fadeIn(delay: 100.ms);
  }
}
