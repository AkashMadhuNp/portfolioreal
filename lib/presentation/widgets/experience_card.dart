import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/experience.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/url_helper.dart';
import '../../core/utils/responsive_helper.dart';

class ExperienceCard extends StatelessWidget {
  final Experience experience;
  final int index;

  const ExperienceCard({
    super.key,
    required this.experience,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    
    return FadeInLeft(
      duration: const Duration(milliseconds: 800),
      delay: Duration(milliseconds: index * 200),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: EdgeInsets.all(isMobile ? 16 : 24),
          child: isMobile ? _buildMobileLayout(context) : _buildDesktopLayout(context),
        ),
      ),
    );
  }

  // Mobile Layout - Vertical Stack
  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Logo and Title Row
        Row(
          children: [
            // Company Logo
            _buildLogo(50),
            const SizedBox(width: 12),
            
            // Position and Company (Flexible to prevent overflow)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Position
                  Text(
                    experience.position,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  
                  // Company
                  Row(
                    children: [
                      Icon(
                        Icons.business_rounded,
                        size: 14,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          experience.company,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Current Badge
            if (experience.isCurrent)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Current',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 12),
        
        // Duration and Location (Wrapped)
        Wrap(
          spacing: 12,
          runSpacing: 8,
          children: [
            // Duration
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.calendar_today_rounded,
                  size: 14,
                  color: Theme.of(context).textTheme.bodySmall?.color,
                ),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    experience.duration,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 12,
                        ),
                  ),
                ),
              ],
            ),
            
            // Location
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.location_on_rounded,
                  size: 14,
                  color: Theme.of(context).textTheme.bodySmall?.color,
                ),
                const SizedBox(width: 4),
                Text(
                  experience.location,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 12,
                      ),
                ),
              ],
            ),
          ],
        ),
        
        // Responsibilities
        if (experience.responsibilities.isNotEmpty) ...[
          const SizedBox(height: 12),
          ...experience.responsibilities.map((resp) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 6),
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      resp,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 12,
                            height: 1.4,
                          ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
        
        // Certificate Button
        if (experience.certificateUrl != null) ...[
          const SizedBox(height: 12),
          _buildCertificateButton(context, true),
        ],
      ],
    );
  }

  // Desktop Layout - Horizontal Row
  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline indicator / Company Logo
        Column(
          children: [
            _buildLogo(60),
            if (index == 0)
              Container(
                width: 2,
                height: 100,
                margin: const EdgeInsets.only(top: 8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary,
                      AppColors.primary.withOpacity(0.1),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(width: 24),

        // Content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Position
              Text(
                experience.position,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),

              // Company
              Row(
                children: [
                  Icon(
                    Icons.business_rounded,
                    size: 20,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    experience.company,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  if (experience.isCurrent) ...[
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Current',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 8),

              // Duration and Location
              Row(
                children: [
                  Icon(
                    Icons.calendar_today_rounded,
                    size: 16,
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    experience.duration,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(width: 16),
                  Icon(
                    Icons.location_on_rounded,
                    size: 16,
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    experience.location,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Responsibilities
              if (experience.responsibilities.isNotEmpty)
                ...experience.responsibilities.map((resp) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            resp,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  );
                }),

              // Certificate Button
              if (experience.certificateUrl != null) ...[
                const SizedBox(height: 16),
                _buildCertificateButton(context, false),
              ],
            ],
          ),
        ),
      ],
    );
  }

  // Build Logo Widget
  Widget _buildLogo(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: experience.logoUrl == null && experience.isCurrent
            ? AppColors.primaryGradient
            : null,
        color: experience.logoUrl != null ? Colors.white : null,
        borderRadius: BorderRadius.circular(size / 2),
        border: experience.logoUrl != null
            ? Border.all(
                color: AppColors.primary.withOpacity(0.3),
                width: 2,
              )
            : null,
        boxShadow: experience.logoUrl != null
            ? [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: experience.logoUrl != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(size / 2 - 2),
              child: Image.asset(
                experience.logoUrl!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    experience.isCurrent
                        ? Icons.work_rounded
                        : Icons.work_outline_rounded,
                    color: AppColors.primary,
                    size: size * 0.5,
                  );
                },
              ),
            )
          : Icon(
              experience.isCurrent
                  ? Icons.work_rounded
                  : Icons.work_outline_rounded,
              color: Colors.white,
              size: size * 0.5,
            ),
    );
  }

  // Build Certificate Button
  Widget _buildCertificateButton(BuildContext context, bool isMobile) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => UrlHelper.launchURL(experience.certificateUrl!),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : 20,
            vertical: isMobile ? 10 : 12,
          ),
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.verified_rounded,
                size: isMobile ? 16 : 20,
                color: Colors.black,
              ),
              SizedBox(width: isMobile ? 6 : 8),
              Text(
                'View Certificate',
                style: GoogleFonts.inter(
                  fontSize: isMobile ? 12 : 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: isMobile ? 4 : 4),
              Icon(
                Icons.arrow_forward_rounded,
                size: isMobile ? 14 : 16,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
