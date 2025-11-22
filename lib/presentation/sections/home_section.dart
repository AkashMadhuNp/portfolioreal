import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_strings.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/responsive_helper.dart';
import '../../core/utils/download_helper.dart';
import '../widgets/social_links.dart';
import '../widgets/shimmer_text.dart';

class HomeSection extends StatelessWidget {
  const HomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight - 100,
      child: Stack(
        children: [
          // Full-width background with profile image
          _buildFullWidthBackground(context),
          
          // Content overlay - adjusted for better visibility
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Theme.of(context).scaffoldBackgroundColor,
                    Theme.of(context).scaffoldBackgroundColor.withOpacity(0.98),
                    Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
                    Theme.of(context).scaffoldBackgroundColor.withOpacity(0.6),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.25, 0.4, 0.5, 0.65],
                ),
              ),
            ),
          ),
          
          // Content
          Center(
            child: Padding(
              padding: ResponsiveHelper.getPadding(context),
              child: isMobile
                  ? _buildMobileLayout(context)
                  : _buildDesktopLayout(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFullWidthBackground(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    
    return Positioned.fill(
      child: Stack(
        children: [
          // Profile image - positioned on right side only
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            width: isMobile 
                ? MediaQuery.of(context).size.width 
                : MediaQuery.of(context).size.width * 0.55,
            child: Image.asset(
              'assets/images/profile.jpeg',
              fit: BoxFit.cover,
              alignment: isMobile ? Alignment.topCenter : Alignment.center,
            ),
          ),
          
          // Gradient mesh overlay for artistic effect
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.centerRight,
                  radius: 1.2,
                  colors: [
                    Colors.transparent,
                    AppColors.primary.withOpacity(0.15),
                    AppColors.accent.withOpacity(0.15),
                  ],
                ),
              ),
            ),
          ),
          
          // Additional artistic gradient overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    AppColors.primary.withOpacity(0.2),
                    Colors.transparent,
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 6,
          child: _buildContent(context),
        ),
        const Expanded(flex: 4, child: SizedBox()),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildContent(context),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);

    return Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        FadeInDown(
          duration: const Duration(milliseconds: 800),
          child: Text(
            AppStrings.hello,
            style: GoogleFonts.montserrat(
              fontSize: isMobile ? 16 : 18,
              fontWeight: FontWeight.w600,
              color: AppColors.accentLight,
              letterSpacing: 3,
            ),
          ),
        ),
        const SizedBox(height: 16),
        FadeInDown(
          duration: const Duration(milliseconds: 1000),
          delay: const Duration(milliseconds: 200),
          child: GlacierText(
            text: AppConstants.name,
            style: GoogleFonts.playfairDisplay(
              color: Colors.white,
              fontSize: isMobile ? 42 : 72,
              fontWeight: FontWeight.w900,
              letterSpacing: -2,
              height: 1.1,
              shadows: [
                Shadow(
                  color: Color(0xFFFFD700).withOpacity(0.5),
                  blurRadius: 20,
                  offset: Offset(0, 0),
                ),
                Shadow(
                  color: Color(0xFFFFFFFF).withOpacity(0.3),
                  blurRadius: 40,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            textAlign: isMobile ? TextAlign.center : TextAlign.left,
          ),
        ),
        const SizedBox(height: 16),
        FadeInDown(
          duration: const Duration(milliseconds: 1200),
          delay: const Duration(milliseconds: 400),
          child: Row(
            mainAxisSize: isMobile ? MainAxisSize.min : MainAxisSize.max,
            children: [
              Text(
                'I\'m a ',
                style: GoogleFonts.inter(
                  fontSize: isMobile ? 20 : 32,
                  fontWeight: FontWeight.w400,
                  color: Colors.white70,
                ),
              ),
              AnimatedTextKit(
                repeatForever: true,
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Flutter Developer',
                    textStyle: GoogleFonts.montserrat(
                      color: AppColors.primaryLight,
                      fontWeight: FontWeight.w700,
                      fontSize: isMobile ? 20 : 32,
                    ),
                    speed: const Duration(milliseconds: 100),
                  ),
                  TypewriterAnimatedText(
                    'Mobile Developer',
                    textStyle: GoogleFonts.montserrat(
                      color: AppColors.accentLight,
                      fontWeight: FontWeight.w700,
                      fontSize: isMobile ? 20 : 32,
                    ),
                    speed: const Duration(milliseconds: 100),
                  ),
                  TypewriterAnimatedText(
                    'UI/UX Enthusiast',
                    textStyle: GoogleFonts.montserrat(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                      fontSize: isMobile ? 20 : 32,
                    ),
                    speed: const Duration(milliseconds: 100),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        FadeInUp(
          duration: const Duration(milliseconds: 1400),
          delay: const Duration(milliseconds: 600),
          child: SizedBox(
            width: isMobile ? double.infinity : 520,
            child: Text(
              AppConstants.bio,
              style: GoogleFonts.inter(
                fontSize: isMobile ? 14 : 16,
                fontWeight: FontWeight.w400,
                color: Colors.white60,
                height: 1.8,
                letterSpacing: 0.3,
              ),
              textAlign: isMobile ? TextAlign.center : TextAlign.left,
            ),
          ),
        ),
        const SizedBox(height: 40),
        FadeInUp(
          duration: const Duration(milliseconds: 1600),
          delay: const Duration(milliseconds: 800),
          child: _buildStylishCVButton(context, isMobile),
        ),
        const SizedBox(height: 40),
        FadeInUp(
          duration: const Duration(milliseconds: 1800),
          delay: const Duration(milliseconds: 1000),
          child: const SocialLinks(),
        ),
      ],
    );
  }

  Widget _buildStylishCVButton(BuildContext context, bool isMobile) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => DownloadHelper.downloadCV(context),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 32 : 48,
            vertical: isMobile ? 18 : 22,
          ),
          decoration: BoxDecoration(
            gradient: AppColors.luxuryGradient,
            borderRadius: BorderRadius.circular(isMobile ? 50 : 60),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.4),
                blurRadius: 24,
                spreadRadius: 0,
                offset: const Offset(0, 8),
              ),
              BoxShadow(
                color: AppColors.primaryLight.withOpacity(0.2),
                blurRadius: 40,
                spreadRadius: -4,
                offset: const Offset(0, 16),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.download_rounded,
                  color: Colors.black,
                  size: isMobile ? 20 : 24,
                ),
              ),
              SizedBox(width: isMobile ? 12 : 16),
              Text(
                AppStrings.downloadCV,
                style: GoogleFonts.montserrat(
                  fontSize: isMobile ? 15 : 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}

