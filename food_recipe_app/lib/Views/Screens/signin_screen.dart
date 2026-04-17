// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Controllers/auth_controller.dart';
import '../../Utils/responsive_utils.dart';
import '../Widgets/custom_btn_signin_singup.dart';
import '../Widgets/custom_snackBar.dart';
import '../Widgets/custom_socialButton.dart';
import '../Widgets/custom_textFormField.dart';
import 'signup_screen.dart';
import 'home_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _authController = AuthController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveUtils.isDesktop(context);
    final isFormValid = _emailController.text.trim().isNotEmpty &&
        _passwordController.text.isNotEmpty;

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
              maxWidth:
                  ResponsiveUtils.maxContentWidth(context) ?? double.infinity,
            ),
            child: IntrinsicHeight(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    const AuthFieldLabel(text: 'Email'),
                    SizedBox(height: ResponsiveUtils.spacingSmall(context)),
                    CustomTextFormField(
                      controller: _emailController,
                      hint: 'Enter Email',
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: Icons.email_outlined,
                      validator: (value) {
                        final email = value?.trim() ?? '';
                        if (email.isEmpty) return 'Please enter your email';
                        final emailRegex = RegExp(
                          r'^[\w\.-]+@[\w\.-]+\.[a-zA-Z]{2,}$',
                        );
                        if (!emailRegex.hasMatch(email)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      onChanged: (_) => setState(() {}),
                    ),
                    SizedBox(height: ResponsiveUtils.spacingMedium(context)),

                    const AuthFieldLabel(text: 'Enter Password'),
                    SizedBox(height: ResponsiveUtils.spacingSmall(context)),
                    CustomTextFormField(
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
                        onPressed: () => setState(
                            () => _obscurePassword = !_obscurePassword),
                        constraints: BoxConstraints(
                          minWidth: ResponsiveUtils.iconSize(context) + 16,
                          minHeight: ResponsiveUtils.iconSize(context) + 16,
                        ),
                        padding: EdgeInsets.zero,
                      ),
                      validator: (value) {
                        if ((value ?? '').isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      onChanged: (_) => setState(() {}),
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

                    AuthSubmitButton(
                      label: 'Sign In',
                      isEnabled: isFormValid,
                      isLoading: _isSubmitting,
                      onPressed: () async {
                        if (!(_formKey.currentState?.validate() ?? false)) {
                          return;
                        }

                        setState(() => _isSubmitting = true);

                        final isLoggedIn = await _authController.loginUser(
                          _emailController.text.trim(),
                          _passwordController.text,
                        );

                        if (!mounted) return;

                        if (isLoggedIn) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const HomeScreen(),
                            ),
                          );
                          return;
                        }

                        CustomSnackBar.show(
                          context,
                          'The email or password is incorrect',
                          backgroundColor: Colors.red,
                        );
                        setState(() => _isSubmitting = false);
                      },
                    ),
                    SizedBox(height: ResponsiveUtils.spacingLarge(context)),

                    // 👉 Divider
                    _buildDivider('Or Sign In With', context),
                    SizedBox(height: ResponsiveUtils.spacingMedium(context)),

                    // 👉 Social Buttons
                    const AuthSocialButtons(compactOnSmall: true),
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

                    if (isDesktop) const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ),
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
                fontSize: ResponsiveUtils.fontSizeBody(context)),
          ),
        ),
        const Expanded(child: Divider(color: Color(0xFFE0E0E0))),
      ],
    );
  }
}
