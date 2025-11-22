import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_strings.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/responsive_helper.dart';
import '../../core/utils/url_helper.dart';
import '../providers/contact_provider.dart';
import '../widgets/section_title.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final padding = ResponsiveHelper.getPadding(context);
    final isMobile = ResponsiveHelper.isMobile(context);

    return Container(
      padding: padding,
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: ResponsiveHelper.getMaxWidth(context),
          ),
          child: Column(
            children: [
              const SectionTitle(
                title: AppStrings.contactTitle,
                subtitle: AppStrings.contactSubtitle,
              ),
              const SizedBox(height: 60),
              isMobile
                  ? _buildMobileLayout(context)
                  : _buildDesktopLayout(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 5,
          child: _buildContactForm(context),
        ),
        const SizedBox(width: 60),
        Expanded(
          flex: 4,
          child: _buildContactInfo(context),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        _buildContactInfo(context),
        const SizedBox(height: 40),
        _buildContactForm(context),
      ],
    );
  }

  Widget _buildContactForm(BuildContext context) {
    return FadeInLeft(
      duration: const Duration(milliseconds: 1000),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: AppStrings.yourName,
                    prefixIcon: Icon(Icons.person_rounded),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: AppStrings.yourEmail,
                    prefixIcon: Icon(Icons.email_rounded),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _messageController,
                  decoration: const InputDecoration(
                    labelText: AppStrings.yourMessage,
                    prefixIcon: Icon(Icons.message_rounded),
                    alignLabelWithHint: true,
                  ),
                  maxLines: 5,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your message';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                Consumer<ContactProvider>(
                  builder: (context, provider, child) {
                    return ElevatedButton.icon(
                      onPressed: provider.isLoading
                          ? null
                          : () => _handleSubmit(context, provider),
                      icon: provider.isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : const Icon(Icons.send_rounded),
                      label: Text(
                        provider.isLoading
                            ? 'Sending...'
                            : AppStrings.sendMessage,
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContactInfo(BuildContext context) {
    return FadeInRight(
      duration: const Duration(milliseconds: 1000),
      child: Column(
        children: [
          _buildContactCard(
            context,
            FontAwesomeIcons.envelope,
            'Email',
            AppConstants.email,
            () => UrlHelper.launchEmail(AppConstants.email),
            0,
          ),
          const SizedBox(height: 20),
          _buildContactCard(
            context,
            FontAwesomeIcons.phone,
            'Phone',
            AppConstants.phone,
            () => UrlHelper.launchPhone(AppConstants.phone),
            100,
          ),
          const SizedBox(height: 20),
          _buildContactCard(
            context,
            FontAwesomeIcons.locationDot,
            'Location',
            AppConstants.location,
            null,
            200,
          ),
          const SizedBox(height: 20),
          _buildContactCard(
            context,
            FontAwesomeIcons.github,
            'GitHub',
            'View Profile',
            () => UrlHelper.launchURL(AppConstants.github),
            300,
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    VoidCallback? onTap,
    int delay,
  ) {
    return FadeInUp(
      duration: const Duration(milliseconds: 800),
      delay: Duration(milliseconds: delay),
      child: MouseRegion(
        cursor: onTap != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
        child: GestureDetector(
          onTap: onTap,
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: FaIcon(
                      icon,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  if (onTap != null)
                    const Icon(
                      Icons.arrow_forward_rounded,
                      color: AppColors.primary,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleSubmit(BuildContext context, ContactProvider provider) async {
    if (_formKey.currentState!.validate()) {
      await provider.sendMessage(
        name: _nameController.text,
        email: _emailController.text,
        message: _messageController.text,
      );

      if (provider.message != null && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(provider.message!),
            backgroundColor: provider.message!.contains('success')
                ? AppColors.success
                : AppColors.error,
          ),
        );

        if (provider.message!.contains('success')) {
          _nameController.clear();
          _emailController.clear();
          _messageController.clear();
        }
      }
    }
  }
}

