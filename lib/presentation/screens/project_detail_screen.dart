import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../domain/entities/project.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/responsive_helper.dart';
import '../../core/utils/url_helper.dart';

class ProjectDetailScreen extends StatelessWidget {
  final Project project;

  const ProjectDetailScreen({super.key, required this.project});

  // Project-specific data maps
  Map<String, dynamic> get _projectData {
    if (project.title == 'Connect') {
      return {
        'subtitle': 'Task & Event Management App',
        'tagline': 'A clean, fast, and intuitive way to organize your everyday life.',
        'fullDescription': 'Connect is a modern task and event management application built with Flutter, designed to make daily planning simple, visual, and efficient. Featuring a vibrant yellow-themed UI and powered by Hive for fast local storage, Connect delivers a smooth offline-first experience. Users can manage to-dos, mark important events, save image memories, and receive smart local notifications that keep them on track. With gesture-based controls, progress tracking, and secure login persistence through Shared Preferences, Connect provides a polished, responsive, and user-friendly productivity flow.\n\nThis application is a demo project built to showcase UI design, state handling, offline storage integration, and real-device app performance.',
        'apkUrl': 'https://apkpure.com/p/com.example.first_project_app',
        'features': [
          'User-friendly task and event management with a clean visual layout',
          'Hive-powered local storage for fast, secure offline data handling',
          'Shared Preferences for persistent login sessions',
          'Real-time local notifications for reminders and alerts',
          'Ability to save images as event memories',
          'Visual progress bar to track task completion',
          'Smooth gesture actions (edit/delete) for easy task management',
          'Optimized performance with responsive UI and smooth interactions',
        ],
      };
    } else if (project.title == 'Refine Spot') {
      return {
        'subtitle': 'Salon Booking Ecosystem',
        'tagline': 'A complete multi-role salon appointment booking platform.',
        'fullDescription': 'Refine Spot is a complete multi-role salon appointment booking ecosystem built using Flutter. Designed as a demo application, it showcases how users, salon owners, and administrators can interact within a unified digital platform. The system streamlines salon discovery, booking, payments, and management with a smooth, modern interface and powerful backend integrations.\n\nWith real-time updates, secure payments, and efficient role-based dashboards, Refine Spot demonstrates the structure of a real-world production-level grooming platform.',
        'modules': [
          {
            'name': 'User Application',
            'apkUrl': 'https://apkpure.net/refine-spot/com.example.sec_pro',
            'githubUrl': 'https://github.com/AkashMadhuNp/refinespotuser',
          },
          {
            'name': 'Salon Application',
            'apkUrl': 'https://apkpure.com/p/com.example.sec_pro_saloon_app',
            'githubUrl': 'https://github.com/AkashMadhuNp/refinespot_saloon',
          },
          {
            'name': 'Admin Panel',
            'liveUrl': 'https://secpro-8c421.web.app/',
            'githubUrl': 'https://github.com/AkashMadhuNp/refinespotadmin',
          },
        ],
        'features': [
          'Multi-Role Architecture - Three separate applications (User, Salon, Admin)',
          'Firebase Integration - Authentication, real-time data, and password recovery',
          'Cloudinary Media Management - Upload and store salon images efficiently',
          'Stripe Payment Integration - Secure online payments with dynamic confirmation',
          'Location & Mapping - OpenStreetMap + Geolocator for salon navigation',
          'Deep Linking & Quick Actions - WhatsApp chats and one-tap phone calls',
          'Review & Rating System - Post-appointment reviews for legitimacy',
          'Salon Dashboard - Track income, manage appointments and services',
          'Admin Controls - Verify salons, manage service categories, monitor platform',
          'Profile Management - Full editing capabilities with secure data handling',
        ],
      };
    }
    return {};
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    final data = _projectData;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          // Custom App Bar with Back Button
          SliverAppBar(
            expandedHeight: isMobile ? 200 : 300,
            pinned: true,
            backgroundColor: Colors.transparent,
            leading: FadeIn(
              child: IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.darkCard,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.primary.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: const Icon(
                    Icons.arrow_back_rounded,
                    color: AppColors.primaryLight,
                  ),
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Gradient Background
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.primary.withOpacity(0.2),
                          AppColors.accent.withOpacity(0.1),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  
                  // Project Logo
                  Center(
                    child: FadeInDown(
                      duration: const Duration(milliseconds: 800),
                      child: Container(
                        width: isMobile ? 120 : 150,
                        height: isMobile ? 120 : 150,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.3),
                              blurRadius: 30,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(20),
                        child: project.imageUrl != null
                            ? Image.asset(
                                project.imageUrl!,
                                fit: BoxFit.contain,
                              )
                            : Icon(
                                Icons.phone_android_rounded,
                                size: isMobile ? 60 : 80,
                                color: AppColors.primary,
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: ResponsiveHelper.getPadding(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  
                  // Project Title & Subtitle
                  FadeInUp(
                    duration: const Duration(milliseconds: 800),
                    child: Center(
                      child: Column(
                        children: [
                          ShaderMask(
                            shaderCallback: (bounds) =>
                                AppColors.luxuryGradient.createShader(bounds),
                            child: Text(
                              project.title,
                              style: GoogleFonts.playfairDisplay(
                                fontSize: isMobile ? 32 : 48,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          if (data['subtitle'] != null) ...[
                            const SizedBox(height: 8),
                            Text(
                              data['subtitle'],
                              style: GoogleFonts.montserrat(
                                fontSize: isMobile ? 14 : 18,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Badges
                  FadeInUp(
                    duration: const Duration(milliseconds: 800),
                    delay: const Duration(milliseconds: 200),
                    child: Center(
                      child: Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        alignment: WrapAlignment.center,
                        children: [
                          _buildBadge(
                            context,
                            project.category,
                            AppColors.primary,
                            Icons.category_rounded,
                          ),
                          _buildBadge(
                            context,
                            'Demo Project',
                            AppColors.accent,
                            Icons.lightbulb_outline_rounded,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Tagline
                  if (data['tagline'] != null)
                    FadeInUp(
                      duration: const Duration(milliseconds: 800),
                      delay: const Duration(milliseconds: 300),
                      child: _buildTagline(context, data['tagline'], isMobile),
                    ),
                  const SizedBox(height: 40),

                  // Full Description Section
                  FadeInUp(
                    duration: const Duration(milliseconds: 800),
                    delay: const Duration(milliseconds: 400),
                    child: _buildSection(
                      context,
                      'Overview',
                      data['fullDescription'] ?? project.description,
                      isMobile,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Live Links Section
                  FadeInUp(
                    duration: const Duration(milliseconds: 800),
                    delay: const Duration(milliseconds: 500),
                    child: _buildLinksSection(context, data, isMobile),
                  ),
                  const SizedBox(height: 32),

                  // Key Features Section
                  if (data['features'] != null)
                    FadeInUp(
                      duration: const Duration(milliseconds: 800),
                      delay: const Duration(milliseconds: 600),
                      child: _buildFeaturesSection(
                        context,
                        data['features'],
                        isMobile,
                      ),
                    ),
                  const SizedBox(height: 32),

                  // Technologies Section
                  FadeInUp(
                    duration: const Duration(milliseconds: 800),
                    delay: const Duration(milliseconds: 700),
                    child: _buildTechnologiesSection(context, isMobile),
                  ),
                  const SizedBox(height: 32),

                  // Demo Disclaimer
                  FadeInUp(
                    duration: const Duration(milliseconds: 800),
                    delay: const Duration(milliseconds: 800),
                    child: _buildDemoDisclaimer(context, isMobile),
                  ),
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(
    BuildContext context,
    String label,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 8),
          Text(
            label,
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTagline(BuildContext context, String tagline, bool isMobile) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primary.withOpacity(0.1),
              AppColors.accent.withOpacity(0.05),
            ],
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.primary.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Text(
          tagline,
          style: GoogleFonts.inter(
            fontSize: isMobile ? 16 : 18,
            fontStyle: FontStyle.italic,
            color: AppColors.accent,
            height: 1.6,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    String content,
    bool isMobile,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title
        Row(
          children: [
            Container(
              width: 4,
              height: 24,
              decoration: BoxDecoration(
                gradient: AppColors.luxuryGradient,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: GoogleFonts.montserrat(
                fontSize: isMobile ? 20 : 24,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryLight,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        
        // Content
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.darkCard,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.primary.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Text(
            content,
            style: GoogleFonts.inter(
              fontSize: isMobile ? 14 : 16,
              height: 1.8,
              color: Colors.white70,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLinksSection(
    BuildContext context,
    Map<String, dynamic> data,
    bool isMobile,
  ) {
    // Check if project has modules (multi-app structure)
    final hasModules = data['modules'] != null;

    if (hasModules) {
      return _buildModulesSection(context, data['modules'], isMobile);
    }

    // Standard single-app links
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title
        Row(
          children: [
            Container(
              width: 4,
              height: 24,
              decoration: BoxDecoration(
                gradient: AppColors.luxuryGradient,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'Live App & Source Code',
              style: GoogleFonts.montserrat(
                fontSize: isMobile ? 20 : 24,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryLight,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        
        // Links
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            // APK Download Link
            if (data['apkUrl'] != null)
              _buildLinkButton(
                context,
                'APK Download',
                data['apkUrl'],
                FontAwesomeIcons.android,
                AppColors.success,
                isMobile,
              ),
            
            // GitHub Link
            if (project.githubUrl != null)
              _buildLinkButton(
                context,
                'GitHub Repository',
                project.githubUrl!,
                FontAwesomeIcons.github,
                AppColors.primaryLight,
                isMobile,
              ),
            
            // Live URL Link
            if (project.liveUrl != null)
              _buildLinkButton(
                context,
                'Live Demo',
                project.liveUrl!,
                FontAwesomeIcons.globe,
                AppColors.info,
                isMobile,
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildModulesSection(
    BuildContext context,
    List<dynamic> modules,
    bool isMobile,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title
        Row(
          children: [
            Container(
              width: 4,
              height: 24,
              decoration: BoxDecoration(
                gradient: AppColors.luxuryGradient,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'Project Modules & Live Links',
              style: GoogleFonts.montserrat(
                fontSize: isMobile ? 20 : 24,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryLight,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        
        // Module Cards
        ...modules.asMap().entries.map((entry) {
          final index = entry.key;
          final module = entry.value;
          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: _buildModuleCard(
              context,
              '${index + 1}. ${module['name']}',
              module['apkUrl'],
              module['liveUrl'],
              module['githubUrl'],
              isMobile,
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildModuleCard(
    BuildContext context,
    String moduleName,
    String? apkUrl,
    String? liveUrl,
    String? githubUrl,
    bool isMobile,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Module Name
          Text(
            moduleName,
            style: GoogleFonts.montserrat(
              fontSize: isMobile ? 16 : 18,
              fontWeight: FontWeight.w700,
              color: AppColors.primaryLight,
            ),
          ),
          const SizedBox(height: 16),
          
          // Links
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              if (apkUrl != null)
                _buildCompactLinkButton(
                  context,
                  'APK',
                  apkUrl,
                  FontAwesomeIcons.android,
                  AppColors.success,
                  isMobile,
                ),
              if (liveUrl != null)
                _buildCompactLinkButton(
                  context,
                  'Live',
                  liveUrl,
                  FontAwesomeIcons.globe,
                  const Color(0xFF4299E1),
                  isMobile,
                ),
              if (githubUrl != null)
                _buildCompactLinkButton(
                  context,
                  'GitHub',
                  githubUrl,
                  FontAwesomeIcons.github,
                  AppColors.primaryLight,
                  isMobile,
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCompactLinkButton(
    BuildContext context,
    String label,
    String url,
    IconData icon,
    Color color,
    bool isMobile,
  ) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => UrlHelper.launchURL(url),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 12 : 16,
            vertical: isMobile ? 8 : 10,
          ),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: color.withOpacity(0.3),
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 14, color: color),
              const SizedBox(width: 8),
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: isMobile ? 12 : 14,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLinkButton(
    BuildContext context,
    String label,
    String url,
    IconData icon,
    Color color,
    bool isMobile,
  ) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => UrlHelper.launchURL(url),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : 24,
            vertical: isMobile ? 12 : 16,
          ),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: color.withOpacity(0.3),
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 18, color: color),
              const SizedBox(width: 12),
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: isMobile ? 14 : 16,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.arrow_forward_rounded, size: 16, color: color),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturesSection(
    BuildContext context,
    List<String> features,
    bool isMobile,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title
        Row(
          children: [
            Container(
              width: 4,
              height: 24,
              decoration: BoxDecoration(
                gradient: AppColors.luxuryGradient,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'Key Features',
              style: GoogleFonts.montserrat(
                fontSize: isMobile ? 20 : 24,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryLight,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        
        // Features List
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.darkCard,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.primary.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: features.map((feature) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check_rounded,
                        size: 14,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        feature,
                        style: GoogleFonts.inter(
                          fontSize: isMobile ? 14 : 16,
                          height: 1.6,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildTechnologiesSection(BuildContext context, bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title
        Row(
          children: [
            Container(
              width: 4,
              height: 24,
              decoration: BoxDecoration(
                gradient: AppColors.luxuryGradient,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'Technologies Used',
              style: GoogleFonts.montserrat(
                fontSize: isMobile ? 20 : 24,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryLight,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        
        // Tech Tags
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: project.technologies.map((tech) {
            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                color: AppColors.darkCard,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.primary.withOpacity(0.3),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Text(
                tech,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryLight,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildDemoDisclaimer(BuildContext context, bool isMobile) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.accent.withOpacity(0.15),
            AppColors.accent.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.accent.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline_rounded,
            color: AppColors.accent,
            size: isMobile ? 24 : 32,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Demo Project',
                  style: GoogleFonts.montserrat(
                    fontSize: isMobile ? 16 : 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.accent,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'This is a concept demo built to demonstrate design, flow, and technical skill. Not a live production app.',
                  style: GoogleFonts.inter(
                    fontSize: isMobile ? 13 : 14,
                    color: Colors.white60,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

