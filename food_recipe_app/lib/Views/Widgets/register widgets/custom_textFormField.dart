import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../Utils/responsive_utils.dart';

class AuthFieldLabel extends StatelessWidget {
  const AuthFieldLabel({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: ResponsiveUtils.fontSizeLabel(context),
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hint,
    this.obscure = false,
    this.keyboardType,
    this.suffixIcon,
    this.prefixIcon,
    this.validator,
    this.onChanged,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
  });

  final TextEditingController controller;
  final String hint;
  final bool obscure;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final IconData? prefixIcon;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final AutovalidateMode autovalidateMode;

  @override
  Widget build(BuildContext context) {
    final borderRadius = ResponsiveUtils.borderRadius(context);
    final iconSize = ResponsiveUtils.iconSize(context);

    return TextFormField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      validator: validator,
      onChanged: onChanged,
      autovalidateMode: autovalidateMode,
      style:
          GoogleFonts.poppins(fontSize: ResponsiveUtils.fontSizeBody(context)),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.poppins(
            color: Colors.black26,
            fontSize: ResponsiveUtils.fontSizeBody(context)),
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: Colors.grey, size: iconSize)
            : null,
        prefixIconConstraints: BoxConstraints(
          minWidth: iconSize + 20,
          minHeight: ResponsiveUtils.inputHeight(context),
        ),
        suffixIcon: suffixIcon,
        contentPadding: EdgeInsets.symmetric(
          horizontal: ResponsiveUtils.horizontalPadding(context) * 0.6,
          vertical: ResponsiveUtils.isSmallMobile(context) ? 12 : 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(color: Color(0xFFE8E8E8)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(color: Color(0xFFE8E8E8)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(color: Color(0xFF1B8A6B), width: 1.5),
        ),
        filled: true,
        fillColor: const Color(0xFFF5F5F5),
        isDense: true,
      ),
    );
  }
}
