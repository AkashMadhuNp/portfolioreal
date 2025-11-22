import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import '../../core/constants/app_strings.dart';
import '../../core/utils/responsive_helper.dart';
import '../providers/theme_provider.dart';
import '../providers/scroll_provider.dart';

class CustomAppBar extends StatelessWidget {
  final GlobalKey homeKey;
  final GlobalKey aboutKey;
  final GlobalKey skillsKey;
  final GlobalKey projectsKey;
  final GlobalKey experienceKey;
  final GlobalKey contactKey;

  const CustomAppBar({
    super.key,
    required this.homeKey,
    required this.aboutKey,
    required this.skillsKey,
    required this.projectsKey,
    required this.experienceKey,
    required this.contactKey,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final scrollProvider = Provider.of<ScrollProvider>(context);

    return FadeInDown(
      duration: const Duration(milliseconds: 800),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 16 : 64,
          vertical: 20,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Navigation Items
            if (!isMobile)
              Row(
                children: [
                  _buildNavItem(context, AppStrings.home, homeKey, scrollProvider),
                  _buildNavItem(context, AppStrings.about, aboutKey, scrollProvider),
                  _buildNavItem(context, AppStrings.skills, skillsKey, scrollProvider),
                  _buildNavItem(context, AppStrings.projects, projectsKey, scrollProvider),
                  _buildNavItem(context, AppStrings.experience, experienceKey, scrollProvider),
                  _buildNavItem(context, AppStrings.contact, contactKey, scrollProvider),
                ],
              ),

            // Theme Toggle
            FadeInRight(
              duration: const Duration(milliseconds: 1000),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      themeProvider.isDarkMode
                          ? Icons.light_mode_rounded
                          : Icons.dark_mode_rounded,
                    ),
                    onPressed: () => themeProvider.toggleTheme(),
                    tooltip: 'Toggle Theme',
                  ),
                  if (isMobile)
                    IconButton(
                      icon: const Icon(Icons.menu_rounded),
                      onPressed: () => _showMobileMenu(context),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    String title,
    GlobalKey key,
    ScrollProvider scrollProvider,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextButton(
        onPressed: () => scrollProvider.scrollToSection(key),
        child: Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
    );
  }

  void _showMobileMenu(BuildContext context) {
    final scrollProvider = Provider.of<ScrollProvider>(context, listen: false);
    
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildMobileNavItem(context, AppStrings.home, homeKey, scrollProvider),
            _buildMobileNavItem(context, AppStrings.about, aboutKey, scrollProvider),
            _buildMobileNavItem(context, AppStrings.skills, skillsKey, scrollProvider),
            _buildMobileNavItem(context, AppStrings.projects, projectsKey, scrollProvider),
            _buildMobileNavItem(context, AppStrings.experience, experienceKey, scrollProvider),
            _buildMobileNavItem(context, AppStrings.contact, contactKey, scrollProvider),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileNavItem(
    BuildContext context,
    String title,
    GlobalKey key,
    ScrollProvider scrollProvider,
  ) {
    return ListTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      onTap: () {
        Navigator.pop(context);
        scrollProvider.scrollToSection(key);
      },
    );
  }
}

