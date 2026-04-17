import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../Utils/responsive_utils.dart';

class ProfileMenuItem {
  const ProfileMenuItem({
    required this.icon,
    required this.title,
    this.subtitle,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
}

class CustomProfileListTile extends StatelessWidget {
  const CustomProfileListTile({
    super.key,
    required this.item,
  });

  final ProfileMenuItem item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: item.onTap ?? () {},
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFF1B8A6B).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            item.icon,
            color: const Color(0xFF1B8A6B),
            size: ResponsiveUtils.iconSize(context),
          ),
        ),
        title: Text(
          item.title,
          style: GoogleFonts.poppins(
            fontSize: ResponsiveUtils.fontSizeBody(context),
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        subtitle: item.subtitle != null
            ? Text(
                item.subtitle!,
                style: GoogleFonts.poppins(
                  fontSize: ResponsiveUtils.fontSizeSmall(context),
                  color: Colors.black45,
                ),
              )
            : null,
        trailing: Icon(
          Icons.chevron_right_rounded,
          color: Colors.black38,
          size: ResponsiveUtils.iconSize(context),
        ),
        onTap: null,
      ),
    );
  }
}
