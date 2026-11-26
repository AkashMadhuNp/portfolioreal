import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_palette.dart';
import '../providers/scroll_provider.dart';
import '../sections/about_section.dart';
import '../sections/contact_section.dart';
import '../sections/engineering_section.dart';
import '../sections/experience_section.dart';
import '../sections/footer_section.dart';
import '../sections/home_section.dart';
import '../sections/projects_section.dart';
import '../sections/skills_section.dart';
import '../widgets/custom_app_bar.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  final _homeKey = GlobalKey();
  final _aboutKey = GlobalKey();
  final _skillsKey = GlobalKey();
  final _engineeringKey = GlobalKey();
  final _projectsKey = GlobalKey();
  final _experienceKey = GlobalKey();
  final _contactKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final scrollProvider = context.read<ScrollProvider>();

    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            items: [
              NavItem('Home', _homeKey),
              NavItem('About', _aboutKey),
              NavItem('Skills', _skillsKey),
              NavItem('Engineering', _engineeringKey),
              NavItem('Projects', _projectsKey),
              NavItem('Experience', _experienceKey),
              NavItem('Contact', _contactKey),
            ],
          ),
          Expanded(
            child: Stack(
              children: [
                SingleChildScrollView(
                  controller: scrollProvider.scrollController,
                  child: Column(
                    children: [
                      KeyedSubtree(
                        key: _homeKey,
                        child: HomeSection(
                          onViewProjects: () => scrollProvider.scrollToSection(
                            _projectsKey,
                            extraOffset: 32,
                          ),
                        ),
                      ),
                      KeyedSubtree(key: _aboutKey, child: const AboutSection()),
                      KeyedSubtree(
                        key: _skillsKey,
                        child: const SkillsSection(),
                      ),
                      KeyedSubtree(
                        key: _engineeringKey,
                        child: const EngineeringSection(),
                      ),
                      KeyedSubtree(
                        key: _projectsKey,
                        child: const ProjectsSection(),
                      ),
                      KeyedSubtree(
                        key: _experienceKey,
                        child: const ExperienceSection(),
                      ),
                      KeyedSubtree(
                        key: _contactKey,
                        child: const ContactSection(),
                      ),
                      const FooterSection(),
                    ],
                  ),
                ),
                const Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: 2,
                  child: _ScrollProgress(),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: _BackToTop(scrollProvider: scrollProvider),
    );
  }
}

/// Hairline reading-progress indicator pinned under the nav.
class _ScrollProgress extends StatelessWidget {
  const _ScrollProgress();

  @override
  Widget build(BuildContext context) {
    final scroll = context.watch<ScrollProvider>();
    final controller = scroll.scrollController;
    // The position exists before the first layout but has no extents yet;
    // reading maxScrollExtent then throws. Treat that as "no progress".
    final hasExtents =
        controller.hasClients && controller.position.hasContentDimensions;
    final max = hasExtents ? controller.position.maxScrollExtent : 0.0;
    final progress = max > 0
        ? (scroll.scrollOffset / max).clamp(0.0, 1.0)
        : 0.0;

    return IgnorePointer(
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: progress,
        child: ColoredBox(color: context.palette.goldStrong),
      ),
    );
  }
}

class _BackToTop extends StatelessWidget {
  const _BackToTop({required this.scrollProvider});

  final ScrollProvider scrollProvider;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: scrollProvider,
      builder: (context, _) {
        final visible = scrollProvider.scrollOffset > 600;
        return AnimatedOpacity(
          opacity: visible ? 1 : 0,
          duration: const Duration(milliseconds: 250),
          child: IgnorePointer(
            ignoring: !visible,
            child: FloatingActionButton.small(
              tooltip: 'Back to top',
              onPressed: scrollProvider.scrollToTop,
              child: const Icon(Icons.arrow_upward_rounded),
            ),
          ),
        );
      },
    );
  }
}
