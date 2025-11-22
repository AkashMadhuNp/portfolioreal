import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../../core/theme/app_colors.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool centerAlign;

  const SectionTitle({
    super.key,
    required this.title,
    required this.subtitle,
    this.centerAlign = true,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      duration: const Duration(milliseconds: 800),
      child: Column(
        crossAxisAlignment:
            centerAlign ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          ShaderMask(
            shaderCallback: (bounds) =>
                AppColors.primaryGradient.createShader(bounds),
            child: Text(
              title,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
              textAlign: centerAlign ? TextAlign.center : TextAlign.left,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).textTheme.bodySmall?.color,
                ),
            textAlign: centerAlign ? TextAlign.center : TextAlign.left,
          ),
          const SizedBox(height: 16),
          Container(
            height: 4,
            width: 80,
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }
}

