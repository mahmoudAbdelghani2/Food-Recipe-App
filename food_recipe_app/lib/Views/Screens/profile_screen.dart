import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../Utils/responsive_utils.dart';

import 'app_router_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveUtils.isDesktop(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: isDesktop
          ? AppBar(
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
        actions: [
          IconButton(
            icon: Icon(Icons.settings_rounded, color: const Color(0xFF1B8A6B)),
            onPressed: () => context.push('/settings'),
          ),
          SizedBox(width: ResponsiveUtils.horizontalPadding(context)),
        ],
      )
          : null, // على الموبايل هنستخدم الـ SliverAppBar جوه الـ body

      body: isDesktop
          ? _buildDesktopBody(context)
          : _buildMobileBody(context),
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
              _buildProfileHeader(context, isDesktop: true),
              const SizedBox(height: 24),
              _buildStatsSection(context),
              const SizedBox(height: 24),
              _buildMenuSection(context, title: 'Account', icon: Icons.person_outline, items: [
                _MenuItem(icon: Icons.edit_outlined, title: 'Edit Profile', subtitle: 'Update your personal info', onTap: () => context.push('/profile/edit')),
                _MenuItem(icon: Icons.bookmark_outline, title: 'Saved Recipes', subtitle: 'Your favorite collections', onTap: () => context.push('/saved')),
                _MenuItem(icon: Icons.history_outlined, title: 'Cooking History', subtitle: 'View your activity', onTap: () => context.push('/history')),
              ]),
              _buildMenuSection(context, title: 'App Settings', icon: Icons.settings_outlined, items: [
                _MenuItem(icon: Icons.notifications_outlined, title: 'Notifications', subtitle: 'Manage alerts & updates', onTap: () => context.push('/settings/notifications')),
                _MenuItem(icon: Icons.palette_outlined, title: 'Appearance', subtitle: 'Light / Dark mode', onTap: () => _showThemeDialog(context)),
                _MenuItem(icon: Icons.language_outlined, title: 'Language', subtitle: 'English', onTap: () => context.push('/settings/language')),
              ]),
              _buildMenuSection(context, title: 'Support', icon: Icons.help_outline, items: [
                _MenuItem(icon: Icons.chat_bubble_outline, title: 'Help & Support', subtitle: 'Get help or contact us', onTap: () => context.push('/support')),
                _MenuItem(icon: Icons.info_outline, title: 'About App', subtitle: 'Version 1.0.0', onTap: () => _showAboutDialog(context)),
              ]),
              const SizedBox(height: 20),
              _buildLogoutCard(context),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────
  // 👉 Mobile Body (Slivers for Parallax Effect)
  // ─────────────────────────────────────────────
  Widget _buildMobileBody(BuildContext context) {
    return CustomScrollView(
      slivers: [
        _buildSliverAppBar(context),
        _buildProfileHeaderSliver(context),
        SliverToBoxAdapter(child: SizedBox(height: ResponsiveUtils.spacingLarge(context))),
        _buildStatsSectionSliver(context),
        SliverToBoxAdapter(child: SizedBox(height: ResponsiveUtils.spacingLarge(context))),
        _buildMenuSectionSliver(context, title: 'Account', icon: Icons.person_outline, items: [
          _MenuItem(icon: Icons.edit_outlined, title: 'Edit Profile', subtitle: 'Update your personal info', onTap: () => context.push('/profile/edit')),
          _MenuItem(icon: Icons.bookmark_outline, title: 'Saved Recipes', subtitle: 'Your favorite collections', onTap: () => context.push('/saved')),
          _MenuItem(icon: Icons.history_outlined, title: 'Cooking History', subtitle: 'View your activity', onTap: () => context.push('/history')),
        ]),
        _buildMenuSectionSliver(context, title: 'App Settings', icon: Icons.settings_outlined, items: [
          _MenuItem(icon: Icons.notifications_outlined, title: 'Notifications', subtitle: 'Manage alerts & updates', onTap: () => context.push('/settings/notifications')),
          _MenuItem(icon: Icons.palette_outlined, title: 'Appearance', subtitle: 'Light / Dark mode', onTap: () => _showThemeDialog(context)),
          _MenuItem(icon: Icons.language_outlined, title: 'Language', subtitle: 'English', onTap: () => context.push('/settings/language')),
        ]),
        _buildMenuSectionSliver(context, title: 'Support', icon: Icons.help_outline, items: [
          _MenuItem(icon: Icons.chat_bubble_outline, title: 'Help & Support', subtitle: 'Get help or contact us', onTap: () => context.push('/support')),
          _MenuItem(icon: Icons.info_outline, title: 'About App', subtitle: 'Version 1.0.0', onTap: () => _showAboutDialog(context)),
        ]),
        _buildLogoutSectionSliver(context),
        const SliverToBoxAdapter(child: SizedBox(height: 30)),
      ],
    );
  }


  // 1. App Bar (Mobile Sliver)
  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
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
      actions: [
        IconButton(
          icon: Icon(Icons.settings_rounded, color: const Color(0xFF1B8A6B)),
          onPressed: () => context.push('/settings'),
        ).animate().scale(delay: 100.ms, curve: Curves.easeOutBack),
        SizedBox(width: ResponsiveUtils.spacingSmall(context)),
      ],
    );
  }

  // 2. Profile Header (Shared Logic)
  Widget _buildProfileHeader(BuildContext context, {bool isDesktop = false}) {
    final imageSize = ResponsiveUtils.getValue4<double>(context, small: 90, medium: 110, large: 120, xlarge: 140);
    final titleSize = ResponsiveUtils.getValue4<double>(context, small: 22, medium: 24, large: 28, xlarge: 32);

    return Container(
      padding: EdgeInsets.all(isDesktop ? 24 : 24),
      decoration: isDesktop
          ? BoxDecoration(
        color: const Color(0xFF1B8A6B), // لون ثابت للديسكتوب
        borderRadius: BorderRadius.circular(ResponsiveUtils.borderRadiusLarge(context)),
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
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 20, offset: const Offset(0, 8))],
                  image: const DecorationImage(image: NetworkImage('https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200'), fit: BoxFit.cover),
                ),
              ),
              Positioned(
                bottom: 0, right: 0,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: const Color(0xFF1B8A6B), width: 2)),
                  child: Icon(Icons.camera_alt_rounded, color: const Color(0xFF1B8A6B), size: 18),
                ),
              ),
            ],
          ).animate().scale(delay: 200.ms, curve: Curves.easeOutBack).then().shake(),
          SizedBox(height: ResponsiveUtils.spacingMedium(context)),
          Text('Jega Kumar', style: GoogleFonts.poppins(fontSize: titleSize, fontWeight: FontWeight.w700, color: Colors.white)).animate().fadeIn(delay: 300.ms).slideY(begin: 0.3, end: 0),
          SizedBox(height: ResponsiveUtils.spacingSmall(context)),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(20)),
            child: Text('🍳 Food Enthusiast', style: GoogleFonts.poppins(fontSize: ResponsiveUtils.fontSizeBody(context), color: Colors.white, fontWeight: FontWeight.w500)),
          ).animate().fadeIn(delay: 400.ms),
          SizedBox(height: ResponsiveUtils.spacingMedium(context)),
          Row(mainAxisSize: MainAxisSize.min, children: [
            Icon(Icons.verified_rounded, color: Colors.amber[300], size: 16),
            SizedBox(width: 4),
            Text('Member since Jan 2024', style: GoogleFonts.poppins(fontSize: ResponsiveUtils.fontSizeSmall(context), color: Colors.white.withOpacity(0.9))),
          ]).animate().fadeIn(delay: 500.ms),
        ],
      ),
    );
  }

  // Wrapper for Mobile Sliver Header
  Widget _buildProfileHeaderSliver(BuildContext context) {
    return SliverToBoxAdapter(child: _buildProfileHeader(context, isDesktop: false));
  }

  // 3. Stats Section (Shared Logic)
  Widget _buildStatsContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ResponsiveUtils.isSmallMobile(context) ? 16 : 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(ResponsiveUtils.borderRadius(context)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 20, offset: const Offset(0, 4))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatCard('24', 'Recipes', Icons.restaurant_menu_rounded, context),
          _buildDivider(),
          _buildStatCard('156', 'Followers', Icons.people_outline_rounded, context),
          _buildDivider(),
          _buildStatCard('89', 'Following', Icons.person_add_alt_1_rounded, context),
        ],
      ),
    ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.2, end: 0);
  }

  Widget _buildStatsSection(BuildContext context) => _buildStatsContent(context);
  Widget _buildStatsSectionSliver(BuildContext context) => SliverToBoxAdapter(child: _buildStatsContent(context));

  Widget _buildStatCard(String value, String label, IconData icon, BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFF1B8A6B), size: ResponsiveUtils.iconSize(context)),
        SizedBox(height: 8),
        Text(value, style: GoogleFonts.poppins(fontSize: ResponsiveUtils.getValue4<double>(context, small: 18, medium: 22, large: 24, xlarge: 28), fontWeight: FontWeight.w700, color: Colors.black87)),
        SizedBox(height: 2),
        Text(label, style: GoogleFonts.poppins(fontSize: ResponsiveUtils.fontSizeSmall(context), color: Colors.black45)),
      ],
    );
  }
  Widget _buildDivider() => Container(height: 32, width: 1, color: Colors.grey.shade200);

  // 4. Menu Section (Shared Logic)
  Widget _buildMenuContent(BuildContext context, {required String title, required IconData icon, required List<_MenuItem> items}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: ResponsiveUtils.spacingMedium(context) * 0.6),
          child: Row(
            children: [
              Icon(icon, size: ResponsiveUtils.iconSize(context), color: const Color(0xFF1B8A6B)),
              SizedBox(width: ResponsiveUtils.spacingSmall(context)),
              Text(title, style: GoogleFonts.poppins(fontSize: ResponsiveUtils.fontSizeHeading(context), fontWeight: FontWeight.w600, color: Colors.black87)),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(ResponsiveUtils.borderRadius(context)),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 15, offset: const Offset(0, 3))],
          ),
          child: Column(
            children: items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              return Column(
                children: [
                  _buildMenuItem(item, context),
                  if (index < items.length - 1) Divider(height: 1, color: Colors.grey.shade100, indent: 60),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuSection(BuildContext context, {required String title, required IconData icon, required List<_MenuItem> items}) {
    return Padding(
      padding: EdgeInsets.only(bottom: ResponsiveUtils.spacingLarge(context)),
      child: _buildMenuContent(context, title: title, icon: icon, items: items),
    );
  }

  Widget _buildMenuSectionSliver(BuildContext context, {required String title, required IconData icon, required List<_MenuItem> items}) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: ResponsiveUtils.horizontalPadding(context), vertical: 8),
      sliver: SliverToBoxAdapter(child: _buildMenuContent(context, title: title, icon: icon, items: items)),
    );
  }

  Widget _buildMenuItem(_MenuItem item, BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(color: item.isDanger ? Colors.red.shade50 : const Color(0xFF1B8A6B).withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
        child: Icon(item.icon, color: item.isDanger ? Colors.red : const Color(0xFF1B8A6B), size: ResponsiveUtils.iconSize(context)),
      ),
      title: Text(item.title, style: GoogleFonts.poppins(fontSize: ResponsiveUtils.fontSizeBody(context), fontWeight: FontWeight.w500, color: item.isDanger ? Colors.red : Colors.black87)),
      subtitle: item.subtitle != null ? Text(item.subtitle!, style: GoogleFonts.poppins(fontSize: ResponsiveUtils.fontSizeSmall(context), color: Colors.black45)) : null,
      trailing: Icon(Icons.chevron_right_rounded, color: Colors.black38, size: ResponsiveUtils.iconSize(context)),
      onTap: item.onTap,
    );
  }

  // 5. Logout (Shared Logic)
  Widget _buildLogoutContent(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(ResponsiveUtils.borderRadius(context)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 15, offset: const Offset(0, 3))],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(12)),
          child: Icon(Icons.logout_rounded, color: Colors.red, size: ResponsiveUtils.iconSize(context)),
        ),
        title: Text('Logout', style: GoogleFonts.poppins(fontSize: ResponsiveUtils.fontSizeBody(context), fontWeight: FontWeight.w600, color: Colors.red)),
        subtitle: Text('Sign out from your account', style: GoogleFonts.poppins(fontSize: ResponsiveUtils.fontSizeSmall(context), color: Colors.black45)),
        trailing: Icon(Icons.chevron_right_rounded, color: Colors.black38, size: ResponsiveUtils.iconSize(context)),
        onTap: () => _showLogoutDialog(context),
      ),
    ).animate().fadeIn(delay: 800.ms);
  }

  Widget _buildLogoutCard(BuildContext context) => _buildLogoutContent(context);
  Widget _buildLogoutSectionSliver(BuildContext context) => SliverPadding(
    padding: EdgeInsets.symmetric(horizontal: ResponsiveUtils.horizontalPadding(context)),
    sliver: SliverToBoxAdapter(child: _buildLogoutContent(context)),
  );

  // ─────────────────────────────────────────────
  // 👉 Dialogs
  // ─────────────────────────────────────────────

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(children: [Icon(Icons.logout_rounded, color: Colors.red, size: 24), SizedBox(width: 10), Text('Logout', style: GoogleFonts.poppins(fontWeight: FontWeight.w700))]),
        content: Text('Are you sure you want to sign out?', style: GoogleFonts.poppins(color: Colors.black54, fontSize: ResponsiveUtils.fontSizeBody(context))),
        actionsPadding: const EdgeInsets.all(16),
        actions: [
          SizedBox(width: double.infinity, child: Row(children: [
            Expanded(child: TextButton(onPressed: () => Navigator.pop(context), style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: Colors.grey.shade300))), child: Text('Cancel', style: GoogleFonts.poppins(fontWeight: FontWeight.w500, color: Colors.black87)))),
            SizedBox(width: 12),
            Expanded(child: ElevatedButton(onPressed: () { Navigator.pop(context); authState.value = false; context.go('/login'); }, style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), elevation: 0), child: Text('Logout', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)))),
          ])),
        ],
      ),
    );
  }

  void _showThemeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Choose Theme', style: GoogleFonts.poppins(fontWeight: FontWeight.w700)),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          _buildThemeOption(context, 'Light Mode', Icons.light_mode_rounded, false),
          const SizedBox(height: 12),
          _buildThemeOption(context, 'Dark Mode', Icons.dark_mode_rounded, true),
        ]),
      ),
    );
  }

  Widget _buildThemeOption(BuildContext context, String title, IconData icon, bool isDark) {
    final currentTheme = Theme.of(context).brightness;
    final isSelected = (isDark && currentTheme == Brightness.dark) || (!isDark && currentTheme == Brightness.light);
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF1B8A6B)),
      title: Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: ResponsiveUtils.fontSizeBody(context))),
      trailing: isSelected ? const Icon(Icons.check_circle_rounded, color: Color(0xFF1B8A6B)) : null,
      onTap: () { Navigator.pop(context); /* TODO: Add theme logic */ },
    );
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'Cooking App',
      applicationVersion: '1.0.0',
      applicationIcon: const Icon(Icons.restaurant_menu_rounded, color: Color(0xFF1B8A6B)),
      children: [Text('Your perfect companion for delicious recipes.', style: GoogleFonts.poppins(color: Colors.black54, fontSize: ResponsiveUtils.fontSizeBody(context)))],
    );
  }
}

class _MenuItem {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final bool isDanger;
  _MenuItem({required this.icon, required this.title, this.subtitle, required this.onTap, this.isDanger = false});
}