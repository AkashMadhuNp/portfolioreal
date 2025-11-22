import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:lottie/lottie.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_strings.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/responsive_helper.dart';
import '../widgets/section_title.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = ResponsiveHelper.getPadding(context);
    final isMobile = ResponsiveHelper.isMobile(context);

    return Container(
      padding: padding,
      child: Stack(
        children: [
          // Lottie animation background on left
          if (!isMobile)
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: Opacity(
                opacity: 0.08,
                child: SizedBox(
                  width: 600,
                  child: Lottie.asset(
                    'assets/images/Flutter.json',
                    fit: BoxFit.cover,
                    repeat: true,
                  ),
                ),
              ),
            ),
          
          // Content
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: ResponsiveHelper.getMaxWidth(context),
              ),
              child: Column(
                children: [
                  const SectionTitle(
                    title: AppStrings.aboutTitle,
                    subtitle: AppStrings.aboutSubtitle,
                  ),
                  const SizedBox(height: 60),
                  isMobile
                      ? _buildMobileLayout(context)
                      : _buildDesktopLayout(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 5,
          child: _buildContent(context),
        ),
        const SizedBox(width: 60),
        Expanded(
          flex: 4,
          child: _buildStats(context),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        _buildContent(context),
        const SizedBox(height: 40),
        _buildStats(context),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    return FadeInLeft(
      duration: const Duration(milliseconds: 1000),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppConstants.bio,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  height: 1.8,
                ),
          ),
          const SizedBox(height: 24),
          _buildInfoRow(
            context,
            Icons.work_rounded,
            'Company',
            AppConstants.company,
          ),
          const SizedBox(height: 16),
          _buildInfoRow(
            context,
            Icons.location_on_rounded,
            'Location',
            AppConstants.location,
          ),
          const SizedBox(height: 16),
          _buildInfoRow(
            context,
            Icons.email_rounded,
            'Email',
            AppConstants.email,
          ),
          const SizedBox(height: 16),
          _buildInfoRow(
            context,
            Icons.phone_rounded,
            'Phone',
            AppConstants.phone,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
            ),
            Text(
              value,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStats(BuildContext context) {
    return FadeInRight(
      duration: const Duration(milliseconds: 1000),
      child: Column(
        children: [
          _buildStatCard(
            context,
            '1+',
            AppStrings.yearsExperience,
            AppColors.primary,
            0,
          ),
          const SizedBox(height: 20),
          _buildStatCard(
            context,
            '2',
            AppStrings.projectsCompleted,
            AppColors.accent,
            100,
          ),
          const SizedBox(height: 20),
          _buildStatCard(
            context,
            '0',
            AppStrings.happyClients,
            AppColors.success,
            200,
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String number,
    String label,
    Color color,
    int delay,
  ) {
    return FadeInUp(
      duration: const Duration(milliseconds: 800),
      delay: Duration(milliseconds: delay),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.1),
              color.withOpacity(0.05),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: color.withOpacity(0.3),
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Text(
              number,
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

