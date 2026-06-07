import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../../domain/entities/project.dart';
import '../../core/theme/app_colors.dart';
import '../screens/project_detail_screen.dart';
import '../providers/cursor_provider.dart';
import '../../core/utils/responsive_helper.dart';
import 'cursor_hover_region.dart';

class ProjectCard extends StatefulWidget {
  final Project project;
  final int index;

  const ProjectCard({
    super.key,
    required this.project,
    required this.index,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: const Duration(milliseconds: 800),
      delay: Duration(milliseconds: widget.index * 100),
      child: CursorHoverRegion(
        type: CursorType.action,
        scale: 2.5,
        customText: 'VIEW',
        child: MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          transform: Matrix4.identity()
            ..translate(0.0, _isHovered ? -10.0 : 0.0, 0.0),
          child: Card(
            elevation: _isHovered ? 12 : 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              padding: ResponsiveHelper.responsive(
                context: context,
                mobile: const EdgeInsets.all(16),
                tablet: const EdgeInsets.all(20),
                desktop: const EdgeInsets.all(24),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: _isHovered
                    ? LinearGradient(
                        colors: [
                          AppColors.primary.withOpacity(0.1),
                          AppColors.accent.withOpacity(0.1),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : null,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Project Logo/Image
                  Container(
                    height: ResponsiveHelper.responsive(
                      context: context,
                      mobile: 56,
                      tablet: 68,
                      desktop: 80,
                    ),
                    width: ResponsiveHelper.responsive(
                      context: context,
                      mobile: 56,
                      tablet: 68,
                      desktop: 80,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        ResponsiveHelper.responsive(
                          context: context,
                          mobile: 12,
                          tablet: 14,
                          desktop: 16,
                        ),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.2),
                          blurRadius: 12,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    padding: ResponsiveHelper.responsive(
                      context: context,
                      mobile: const EdgeInsets.all(8),
                      tablet: const EdgeInsets.all(10),
                      desktop: const EdgeInsets.all(12),
                    ),
                    child: widget.project.imageUrl != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image.asset(
                              widget.project.imageUrl!,
                              fit: BoxFit.contain,
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              gradient: AppColors.primaryGradient,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Icon(
                              Icons.phone_android_rounded,
                              color: Colors.white,
                              size: ResponsiveHelper.responsive(
                                context: context,
                                mobile: 24,
                                tablet: 28,
                                desktop: 32,
                              ),
                            ),
                          ),
                  ),
                  SizedBox(
                    height: ResponsiveHelper.responsive(
                      context: context,
                      mobile: 12,
                      tablet: 16,
                      desktop: 20,
                    ),
                  ),

                  // Title
                  Text(
                    widget.project.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  SizedBox(
                    height: ResponsiveHelper.responsive(
                      context: context,
                      mobile: 8,
                      tablet: 10,
                      desktop: 12,
                    ),
                  ),

                  // Badges Wrap
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      // Category Badge
                      Container(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          widget.project.category,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                                fontSize: ResponsiveHelper.responsive(
                                  context: context,
                                  mobile: 10,
                                  tablet: 11,
                                  desktop: 12,
                                ),
                              ),
                        ),
                      ),
                      // Demo Badge
                      Container(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.accent.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppColors.accent.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.lightbulb_outline_rounded,
                              size: ResponsiveHelper.responsive(
                                context: context,
                                mobile: 12,
                                tablet: 13,
                                desktop: 14,
                              ),
                              color: AppColors.accent,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              widget.project.type.contains('Company') ? 'Real-World Project' : 'Demo Project',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColors.accent,
                                    fontWeight: FontWeight.w700,
                                    fontSize: ResponsiveHelper.responsive(
                                      context: context,
                                      mobile: 10,
                                      tablet: 10.5,
                                      desktop: 11,
                                    ),
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: ResponsiveHelper.responsive(
                      context: context,
                      mobile: 8,
                      tablet: 10,
                      desktop: 12,
                    ),
                  ),

                  // Description
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        widget.project.description,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: ResponsiveHelper.responsive(
                            context: context,
                            mobile: 12,
                            tablet: 12.5,
                            desktop: 13,
                          ),
                          height: 1.4,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: ResponsiveHelper.responsive(
                      context: context,
                      mobile: 10,
                      tablet: 12,
                      desktop: 16,
                    ),
                  ),

                  // Technologies
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: widget.project.technologies.map((tech) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: ResponsiveHelper.responsive(
                            context: context,
                            mobile: 8,
                            tablet: 10,
                            desktop: 12,
                          ),
                          vertical: ResponsiveHelper.responsive(
                            context: context,
                            mobile: 4,
                            tablet: 5,
                            desktop: 6,
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .surface
                              .withOpacity(0.5),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppColors.primary.withOpacity(0.3),
                          ),
                        ),
                        child: Text(
                          tech,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontSize: ResponsiveHelper.responsive(
                                      context: context,
                                      mobile: 10,
                                      tablet: 10.5,
                                      desktop: 11,
                                    ),
                                  ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height: ResponsiveHelper.responsive(
                      context: context,
                      mobile: 10,
                      tablet: 12,
                      desktop: 16,
                    ),
                  ),

                  // View Details Button
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProjectDetailScreen(
                              project: widget.project,
                            ),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.arrow_forward_rounded,
                        size: ResponsiveHelper.responsive(
                          context: context,
                          mobile: 16,
                          tablet: 17,
                          desktop: 18,
                        ),
                      ),
                      label: Text(
                        'View Details',
                        style: TextStyle(
                          fontSize: ResponsiveHelper.responsive(
                            context: context,
                            mobile: 13,
                            tablet: 13.5,
                            desktop: 14,
                          ),
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          vertical: ResponsiveHelper.responsive(
                            context: context,
                            mobile: 10,
                            tablet: 11,
                            desktop: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
}

