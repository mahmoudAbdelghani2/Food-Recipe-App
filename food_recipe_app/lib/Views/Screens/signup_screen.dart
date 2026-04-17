// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Controllers/auth_controller.dart';
import '../../Utils/responsive_utils.dart';
import '../Widgets/custom_btn_signin_singup.dart';
import '../Widgets/custom_snackBar.dart';
import '../Widgets/custom_socialButton.dart';
import '../Widgets/custom_textFormField.dart';
import 'home_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _authController = AuthController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String? _selectedGender;
  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _acceptTerms = false;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isFormValid = _acceptTerms &&
        _selectedGender != null &&
        _nameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _confirmPasswordController.text.isNotEmpty;

    final isDesktop = ResponsiveUtils.isDesktop(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveUtils.horizontalPadding(context),
            vertical: ResponsiveUtils.verticalPadding(context),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).padding.bottom -
                  ResponsiveUtils.verticalPadding(context) * 2,
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
                      'Create an account',
                      style: GoogleFonts.poppins(
                        fontSize: ResponsiveUtils.fontSizeHeading(context),
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: ResponsiveUtils.spacingSmall(context)),
                    Text(
                      "Let's help you set up your account,\nit won't take long.",
                      style: GoogleFonts.poppins(
                        fontSize: ResponsiveUtils.fontSizeBody(context),
                        color: Colors.black45,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: ResponsiveUtils.spacingLarge(context)),

                    const AuthFieldLabel(text: 'Name'),
                    SizedBox(height: ResponsiveUtils.spacingSmall(context)),
                    CustomTextFormField(
                      controller: _nameController,
                      hint: 'Enter Name',
                      prefixIcon: Icons.person_outline_rounded,
                      validator: (value) {
                        final name = value?.trim() ?? '';
                        if (name.isEmpty) return 'Please enter your name';
                        if (name.length < 3) {
                          return 'Name must be at least 3 characters';
                        }
                        return null;
                      },
                      onChanged: (_) => setState(() {}),
                    ),
                    SizedBox(height: ResponsiveUtils.spacingMedium(context)),

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

                    // 👉 Gender Selection
                    const AuthFieldLabel(text: 'Gender'),
                    SizedBox(height: ResponsiveUtils.spacingSmall(context)),
                    _buildGenderSelection(context),
                    SizedBox(height: ResponsiveUtils.spacingMedium(context)),

                    // 👉 Password Field
                    const AuthFieldLabel(text: 'Password'),
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
                      ),
                      validator: (value) {
                        final password = value ?? '';
                        if (password.isEmpty) return 'Please enter a password';
                        if (password.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                      onChanged: (_) => setState(() {}),
                    ),
                    SizedBox(height: ResponsiveUtils.spacingMedium(context)),

                    // 👉 Confirm Password Field
                    const AuthFieldLabel(text: 'Confirm Password'),
                    SizedBox(height: ResponsiveUtils.spacingSmall(context)),
                    CustomTextFormField(
                      controller: _confirmPasswordController,
                      hint: 'Retype Password',
                      obscure: _obscureConfirm,
                      prefixIcon: Icons.lock_outline_rounded,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureConfirm
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: Colors.grey,
                          size: ResponsiveUtils.iconSize(context),
                        ),
                        onPressed: () =>
                            setState(() => _obscureConfirm = !_obscureConfirm),
                        constraints: BoxConstraints(
                          minWidth: ResponsiveUtils.iconSize(context) + 16,
                          minHeight: ResponsiveUtils.iconSize(context) + 16,
                        ),
                      ),
                      validator: (value) {
                        final confirm = value ?? '';
                        if (confirm.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (confirm != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                      onChanged: (_) => setState(() {}),
                    ),
                    SizedBox(height: ResponsiveUtils.spacingLarge(context)),

                    // 👉 Terms Checkbox
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: Checkbox(
                            value: _acceptTerms,
                            activeColor: const Color(0xFF1B8A6B),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            side: const BorderSide(color: Color(0xFF1B8A6B)),
                            onChanged: (v) => setState(() => _acceptTerms = v!),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            visualDensity: VisualDensity.compact,
                          ),
                        ),
                        SizedBox(width: ResponsiveUtils.spacingSmall(context)),
                        Expanded(
                          child: GestureDetector(
                            onTap: () =>
                                setState(() => _acceptTerms = !_acceptTerms),
                            child: RichText(
                              text: TextSpan(
                                style: GoogleFonts.poppins(
                                  color: Colors.black54,
                                  fontSize:
                                      ResponsiveUtils.fontSizeBody(context),
                                ),
                                children: const [
                                  TextSpan(text: 'I agree to the '),
                                  TextSpan(
                                    text: 'Terms & Conditions',
                                    style: TextStyle(
                                      color: Color(0xFF1B8A6B),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: ResponsiveUtils.spacingLarge(context)),

                    if (isDesktop) const Spacer(),

                    AuthSubmitButton(
                      label: 'Sign Up',
                      isEnabled: isFormValid,
                      isLoading: _isSubmitting,
                      onPressed: () async {
                        if (!(_formKey.currentState?.validate() ?? false)) {
                          return;
                        }

                        setState(() => _isSubmitting = true);

                        final email = _emailController.text.trim();
                        final emailExists =
                            await _authController.isEmailExists(email);

                        if (!mounted) return;

                        if (emailExists) {
                          CustomSnackBar.show(
                            context,
                            'This email is already registered',
                            backgroundColor: Colors.orange,
                          );
                          setState(() => _isSubmitting = false);
                          return;
                        }

                        final registerResult =
                            await _authController.registerUser(
                          name: _nameController.text.trim(),
                          email: email,
                          password: _passwordController.text,
                          gender: _selectedGender!,
                        );

                        if (!mounted) return;

                        if (registerResult == RegisterUserResult.success) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const HomeScreen(),
                            ),
                          );
                          return;
                        }

                        if (registerResult ==
                            RegisterUserResult.emailAlreadyExists) {
                          CustomSnackBar.show(
                            context,
                            'This email is already registered',
                            backgroundColor: Colors.orange,
                          );
                        } else {
                          CustomSnackBar.show(
                            context,
                            'An error occurred while creating the account',
                            backgroundColor: Colors.red,
                          );
                        }

                        setState(() => _isSubmitting = false);
                      },
                    ),
                    SizedBox(height: ResponsiveUtils.spacingLarge(context)),

                    // 👉 Divider
                    _buildDivider('Or Sign In With', context),
                    SizedBox(height: ResponsiveUtils.spacingMedium(context)),

                    // 👉 Social Buttons
                    const AuthSocialButtons(showAppleOnLarge: true),
                    SizedBox(height: ResponsiveUtils.spacingLarge(context)),

                    // 👉 Sign In Link
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already a member? ',
                            style: GoogleFonts.poppins(
                                color: Colors.black54,
                                fontSize:
                                    ResponsiveUtils.fontSizeBody(context)),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Text(
                              'Sign In',
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

  Widget _buildGenderSelection(BuildContext context) {
    final options = ['Male', 'Female'];
    final borderRadius = ResponsiveUtils.borderRadius(context);

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Row(
        children: options.map((gender) {
          final isSelected = _selectedGender == gender;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedGender = gender),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: EdgeInsets.symmetric(
                  vertical: ResponsiveUtils.isSmallMobile(context) ? 10 : 14,
                ),
                decoration: BoxDecoration(
                  color:
                      isSelected ? const Color(0xFF1B8A6B) : Colors.transparent,
                  borderRadius: BorderRadius.circular(borderRadius - 2),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: const Color(0xFF1B8A6B).withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ]
                      : null,
                ),
                child: Center(
                  child: Text(
                    gender,
                    style: GoogleFonts.poppins(
                      fontSize: ResponsiveUtils.fontSizeBody(context),
                      fontWeight: FontWeight.w500,
                      color: isSelected ? Colors.white : Colors.black54,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
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
