import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// Alternative hero section with profile image as blended background
/// To use this, replace AnimatedBackground in PortfolioScreen
class HeroBackground extends StatelessWidget {
  final Widget child;

  const HeroBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background image with blend effect
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage('assets/images/profile.jpeg'),
                fit: BoxFit.cover,
                alignment: Alignment.centerRight,
                // Blend mode for unique effect
                colorFilter: ColorFilter.mode(
                  Theme.of(context).scaffoldBackgroundColor.withOpacity(0.85),
                  BlendMode.darken,
                ),
              ),
            ),
            // Additional gradient overlay
            foregroundDecoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Theme.of(context).scaffoldBackgroundColor,
                  Theme.of(context).scaffoldBackgroundColor.withOpacity(0.95),
                  Theme.of(context).scaffoldBackgroundColor.withOpacity(0.7),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.4, 0.7, 1.0],
              ),
            ),
          ),
        ),
        
        // Decorative gradient overlay
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.primary.withOpacity(0.1),
                  Colors.transparent,
                  AppColors.accent.withOpacity(0.1),
                ],
              ),
            ),
          ),
        ),
        
        // Content
        child,
      ],
    );
  }
}

/// Option 2: Split screen design with image on right
class SplitHeroBackground extends StatelessWidget {
  final Widget child;

  const SplitHeroBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 640;

    return Stack(
      children: [
        if (!isMobile)
          // Desktop: Image on right half
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            width: screenWidth * 0.5,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('assets/images/profile.jpeg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    AppColors.primary.withOpacity(0.2),
                    BlendMode.colorBurn,
                  ),
                ),
              ),
              foregroundDecoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Theme.of(context).scaffoldBackgroundColor,
                    Theme.of(context).scaffoldBackgroundColor.withOpacity(0.8),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.3, 1.0],
                ),
              ),
            ),
          ),
        
        // Content
        child,
      ],
    );
  }
}

/// Option 3: Glassmorphism effect with profile
class GlassHeroBackground extends StatelessWidget {
  final Widget child;

  const GlassHeroBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Blurred background
        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/profile.jpeg'),
                fit: BoxFit.cover,
                opacity: 0.15,
              ),
            ),
            foregroundDecoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.topRight,
                radius: 1.5,
                colors: [
                  AppColors.primary.withOpacity(0.3),
                  Theme.of(context).scaffoldBackgroundColor,
                ],
              ),
            ),
          ),
        ),
        
        // Mesh gradient overlay
        Positioned.fill(
          child: CustomPaint(
            painter: _MeshGradientPainter(),
          ),
        ),
        
        // Content
        child,
      ],
    );
  }
}

class _MeshGradientPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 80);

    // Create mesh effect
    paint.color = AppColors.primary.withOpacity(0.15);
    canvas.drawCircle(
      Offset(size.width * 0.8, size.height * 0.3),
      200,
      paint,
    );

    paint.color = AppColors.accent.withOpacity(0.1);
    canvas.drawCircle(
      Offset(size.width * 0.2, size.height * 0.7),
      150,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

