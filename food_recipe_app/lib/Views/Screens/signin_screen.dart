import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../../Utils/responsive_utils.dart';
import 'signup_screen.dart';
import 'home_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveUtils.isDesktop(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          // 👉 Responsive Padding
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveUtils.horizontalPadding(context),
            vertical: ResponsiveUtils.verticalPadding(context),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: ResponsiveUtils.maxContentWidth(context) ?? double.infinity,
            ),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 👉 Header Section - "Hello, Welcome Back!"
                  Text(
                    'Hello,',
                    style: GoogleFonts.poppins(
                      fontSize: ResponsiveUtils.fontSizeTitle(context),
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                      height: 1.1,
                    ),
                  ),
                  Text(
                    'Welcome Back!',
                    style: GoogleFonts.poppins(
                      fontSize: ResponsiveUtils.fontSizeTitle(context),
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: ResponsiveUtils.spacingLarge(context)),

                  // 👉 Email Field
                  _buildLabel('Email', context),
                  SizedBox(height: ResponsiveUtils.spacingSmall(context)),
                  _buildTextField(
                    controller: _emailController,
                    hint: 'Enter Email',
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icons.email_outlined,
                    context: context,
                  ),
                  SizedBox(height: ResponsiveUtils.spacingMedium(context)),

                  // 👉 Password Field
                  _buildLabel('Enter Password', context),
                  SizedBox(height: ResponsiveUtils.spacingSmall(context)),
                  _buildTextField(
                    controller: _passwordController,
                    hint: 'Enter Password',
                    obscure: _obscurePassword,
                    prefixIcon: Icons.lock_outline_rounded,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: Colors.grey,
                        size: ResponsiveUtils.iconSize(context),
                      ),
                      onPressed: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                      constraints: BoxConstraints(
                        minWidth: ResponsiveUtils.iconSize(context) + 16,
                        minHeight: ResponsiveUtils.iconSize(context) + 16,
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    context: context,
                  ),
                  SizedBox(height: ResponsiveUtils.spacingSmall(context)),

                  // 👉 Forgot Password (Right Aligned)
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Forgot Password?',
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF1B8A6B),
                          fontSize: ResponsiveUtils.fontSizeBody(context),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: ResponsiveUtils.spacingMedium(context)),

                  // 👉 Sign In Button (Push to bottom on desktop)
                  if (isDesktop) const Spacer(),

                  SizedBox(
                    width: double.infinity,
                    height: ResponsiveUtils.buttonHeight(context),
                    child: ElevatedButton(
                      onPressed: () {

                        context.go('/home');

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const HomeScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1B8A6B),
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
                          Text('Sign In'),
                          SizedBox(width: ResponsiveUtils.spacingSmall(context)),
                          Icon(Icons.arrow_forward_rounded,
                              size: ResponsiveUtils.iconSize(context)),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: ResponsiveUtils.spacingLarge(context)),

                  // 👉 Divider
                  _buildDivider('Or Sign In With', context),
                  SizedBox(height: ResponsiveUtils.spacingMedium(context)),

                  // 👉 Social Buttons
                  _buildSocialButtons(context),
                  SizedBox(height: ResponsiveUtils.spacingLarge(context)),

                  // 👉 Sign Up Link
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: GoogleFonts.poppins(
                            color: Colors.black54,
                            fontSize: ResponsiveUtils.fontSizeBody(context),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const SignUpScreen()),
                            );
                          },
                          child: Text(
                            'Sign up',
                            style: GoogleFonts.poppins(
                              color: const Color(0xFF1B8A6B),
                              fontSize: ResponsiveUtils.fontSizeBody(context),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // 👉 Extra spacing for desktop
                  if (isDesktop) const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildLabel(String text, BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: ResponsiveUtils.fontSizeLabel(context),
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    bool obscure = false,
    TextInputType? keyboardType,
    Widget? suffixIcon,
    IconData? prefixIcon,
    required BuildContext context,
  }) {
    final borderRadius = ResponsiveUtils.borderRadius(context);
    final iconSize = ResponsiveUtils.iconSize(context);

    return TextField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      style: GoogleFonts.poppins(fontSize: ResponsiveUtils.fontSizeBody(context)),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.poppins(
            color: Colors.black26,
            fontSize: ResponsiveUtils.fontSizeBody(context)
        ),
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

  Widget _buildDivider(String text, BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: Color(0xFFE0E0E0))),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveUtils.spacingMedium(context),
          ),
          child: Text(
            text,
            style: GoogleFonts.poppins(
                color: Colors.black38,
                fontSize: ResponsiveUtils.fontSizeBody(context)
            ),
          ),
        ),
        const Expanded(child: Divider(color: Color(0xFFE0E0E0))),
      ],
    );
  }

  Widget _buildSocialButtons(BuildContext context) {
    final spacing = ResponsiveUtils.spacingMedium(context);
    final isSmall = ResponsiveUtils.isSmallMobile(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _socialButton(
          icon: Icons.g_mobiledata_rounded,
          label: isSmall ? 'G' : 'Google',
          color: const Color(0xFFEA4335),
          context: context,
        ),
        SizedBox(width: spacing),
        _socialButton(
          icon: Icons.facebook_rounded,
          label: isSmall ? 'f' : 'Facebook',
          color: const Color(0xFF1877F2),
          context: context,
        ),


      ],
    );
  }

  Widget _socialButton({
    required IconData icon,
    required String label,
    required Color color,
    required BuildContext context,
  }) {
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
          if (!isSmall) ...[
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