import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/scroll_provider.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/animated_background.dart';
import '../sections/home_section.dart';
import '../sections/about_section.dart';
import '../sections/skills_section.dart';
import '../sections/projects_section.dart';
import '../sections/experience_section.dart';
import '../sections/contact_section.dart';
import '../sections/footer_section.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final scrollProvider = Provider.of<ScrollProvider>(context, listen: false);

    return Scaffold(
      body: AnimatedBackground(
        child: Column(
          children: [
            CustomAppBar(
              homeKey: _homeKey,
              aboutKey: _aboutKey,
              skillsKey: _skillsKey,
              projectsKey: _projectsKey,
              experienceKey: _experienceKey,
              contactKey: _contactKey,
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: scrollProvider.scrollController,
                child: Column(
                  children: [
                    // Home Section
                    Container(
                      key: _homeKey,
                      child: const HomeSection(),
                    ),
                    const SizedBox(height: 80),

                    // About Section
                    Container(
                      key: _aboutKey,
                      child: const AboutSection(),
                    ),
                    const SizedBox(height: 80),

                    // Skills Section
                    Container(
                      key: _skillsKey,
                      child: const SkillsSection(),
                    ),
                    const SizedBox(height: 80),

                    // Projects Section
                    Container(
                      key: _projectsKey,
                      child: const ProjectsSection(),
                    ),
                    const SizedBox(height: 80),

                    // Experience Section
                    Container(
                      key: _experienceKey,
                      child: const ExperienceSection(),
                    ),
                    const SizedBox(height: 80),

                    // Contact Section
                    Container(
                      key: _contactKey,
                      child: const ContactSection(),
                    ),
                    const SizedBox(height: 80),

                    // Footer
                    const FooterSection(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _buildScrollToTopButton(scrollProvider),
    );
  }

  Widget _buildScrollToTopButton(ScrollProvider scrollProvider) {
    return AnimatedBuilder(
      animation: scrollProvider,
      builder: (context, child) {
        return AnimatedOpacity(
          opacity: scrollProvider.scrollOffset > 500 ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 300),
          child: AnimatedScale(
            scale: scrollProvider.scrollOffset > 500 ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            child: FloatingActionButton(
              onPressed: () => scrollProvider.scrollToSection(_homeKey),
              child: const Icon(Icons.arrow_upward_rounded),
            ),
          ),
        );
      },
    );
  }
}

