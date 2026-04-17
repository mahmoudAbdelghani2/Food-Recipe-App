// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Utils/responsive_utils.dart';
import '../Widgets/custom_btn_logout.dart';
import '../Widgets/custom_listtile.dart';
import '../Widgets/profile_header_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveUtils.isDesktop(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: isDesktop
          ? AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                'My Profile',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700,
                  fontSize: ResponsiveUtils.fontSizeHeading(context),
                  color: Colors.black87,
                ),
              ),
              centerTitle: true,
            )
          : null,
      body: isDesktop ? _buildDesktopBody(context) : _buildMobileBody(context),
    );
  }

  Widget _buildDesktopBody(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 650),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(ResponsiveUtils.horizontalPadding(context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const ProfileHeaderWidget(isDesktop: true),
              const SizedBox(height: 24),
              _buildMenuSection(context,
                  title: 'Account',
                  icon: Icons.person_outline,
                  items: [
                    const ProfileMenuItem(
                        icon: Icons.edit_outlined,
                        title: 'Edit Profile',
                      subtitle: 'Update your personal info'),
                    const ProfileMenuItem(
                        icon: Icons.bookmark_outline,
                        title: 'Saved Recipes',
                      subtitle: 'Your favorite collections'),
                    const ProfileMenuItem(
                        icon: Icons.history_outlined,
                        title: 'Cooking History',
                      subtitle: 'View your activity'),
                  ]),
              _buildMenuSection(context,
                  title: 'App Settings',
                  icon: Icons.settings_outlined,
                  items: [
                    const ProfileMenuItem(
                        icon: Icons.notifications_outlined,
                        title: 'Notifications',
                      subtitle: 'Manage alerts & updates'),
                    const ProfileMenuItem(
                        icon: Icons.palette_outlined,
                        title: 'Appearance',
                      subtitle: 'Light / Dark mode'),
                    const ProfileMenuItem(
                        icon: Icons.language_outlined,
                        title: 'Language',
                      subtitle: 'English'),
                  ]),
              _buildMenuSection(context,
                  title: 'Support',
                  icon: Icons.help_outline,
                  items: [
                    const ProfileMenuItem(
                        icon: Icons.chat_bubble_outline,
                        title: 'Help & Support',
                      subtitle: 'Get help or contact us'),
                    const ProfileMenuItem(
                        icon: Icons.info_outline,
                        title: 'About App',
                      subtitle: 'Version 1.0.0'),
                  ]),
              const SizedBox(height: 20),
              const CustomLogoutButton(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMobileBody(BuildContext context) {
    return CustomScrollView(
      slivers: [
        _buildSliverAppBar(context),
        const ProfileHeaderSliver(),
        SliverToBoxAdapter(
            child: SizedBox(height: ResponsiveUtils.spacingLarge(context))),
        _buildMenuSectionSliver(context,
            title: 'Account',
            icon: Icons.person_outline,
            items: [
              const ProfileMenuItem(
                  icon: Icons.edit_outlined,
                  title: 'Edit Profile',
                  subtitle: 'Update your personal info'),
              const ProfileMenuItem(
                  icon: Icons.bookmark_outline,
                  title: 'Saved Recipes',
                  subtitle: 'Your favorite collections'),
              const ProfileMenuItem(
                  icon: Icons.history_outlined,
                  title: 'Cooking History',
                  subtitle: 'View your activity'),
            ]),
        _buildMenuSectionSliver(context,
            title: 'App Settings',
            icon: Icons.settings_outlined,
            items: [
              const ProfileMenuItem(
                  icon: Icons.notifications_outlined,
                  title: 'Notifications',
                  subtitle: 'Manage alerts & updates'),
              const ProfileMenuItem(
                  icon: Icons.palette_outlined,
                  title: 'Appearance',
                  subtitle: 'Light / Dark mode'),
              const ProfileMenuItem(
                  icon: Icons.language_outlined,
                  title: 'Language',
                  subtitle: 'English'),
            ]),
        _buildMenuSectionSliver(context,
            title: 'Support',
            icon: Icons.help_outline,
            items: [
              const ProfileMenuItem(
                  icon: Icons.chat_bubble_outline,
                  title: 'Help & Support',
                  subtitle: 'Get help or contact us'),
              const ProfileMenuItem(
                  icon: Icons.info_outline,
                  title: 'About App',
                  subtitle: 'Version 1.0.0'),
            ]),
        SliverPadding(
          padding: EdgeInsets.symmetric(
              horizontal: ResponsiveUtils.horizontalPadding(context)),
          sliver: const SliverToBoxAdapter(child: CustomLogoutButton()),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 30)),
      ],
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      floating: true,
      snap: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        'My Profile',
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w700,
          fontSize: ResponsiveUtils.fontSizeHeading(context),
          color: Colors.black87,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildMenuContent(BuildContext context,
      {required String title,
      required IconData icon,
      required List<ProfileMenuItem> items}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 8,
              vertical: ResponsiveUtils.spacingMedium(context) * 0.6),
          child: Row(
            children: [
              Icon(icon,
                  size: ResponsiveUtils.iconSize(context),
                  color: const Color(0xFF1B8A6B)),
              SizedBox(width: ResponsiveUtils.spacingSmall(context)),
              Text(title,
                  style: GoogleFonts.poppins(
                      fontSize: ResponsiveUtils.fontSizeHeading(context),
                      fontWeight: FontWeight.w600,
                      color: Colors.black87)),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:
                BorderRadius.circular(ResponsiveUtils.borderRadius(context)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 15,
                  offset: const Offset(0, 3))
            ],
          ),
          child: Column(
            children: items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              return Column(
                children: [
                  CustomProfileListTile(item: item),
                  if (index < items.length - 1)
                    Divider(height: 1, color: Colors.grey.shade100, indent: 60),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuSection(BuildContext context,
      {required String title,
      required IconData icon,
      required List<ProfileMenuItem> items}) {
    return Padding(
      padding: EdgeInsets.only(bottom: ResponsiveUtils.spacingLarge(context)),
      child: _buildMenuContent(context, title: title, icon: icon, items: items),
    );
  }

  Widget _buildMenuSectionSliver(BuildContext context,
      {required String title,
      required IconData icon,
      required List<ProfileMenuItem> items}) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(
          horizontal: ResponsiveUtils.horizontalPadding(context), vertical: 8),
      sliver: SliverToBoxAdapter(
          child: _buildMenuContent(context,
              title: title, icon: icon, items: items)),
    );
  }
}
