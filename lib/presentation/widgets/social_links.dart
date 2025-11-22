import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animate_do/animate_do.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/url_helper.dart';
import '../../core/utils/toast_helper.dart';
import '../../core/constants/app_constants.dart';

class SocialLinks extends StatelessWidget {
  final bool vertical;

  const SocialLinks({super.key, this.vertical = false});

  @override
  Widget build(BuildContext context) {
    final links = [
      _SocialLink(
        icon: FontAwesomeIcons.github,
        url: AppConstants.github,
        color: Colors.black,
      ),
      _SocialLink(
        icon: FontAwesomeIcons.linkedin,
        url: AppConstants.linkedin,
        color: const Color(0xFF0077B5),
      ),
      _SocialLink(
        icon: FontAwesomeIcons.twitter,
        url: AppConstants.twitter,
        color: const Color(0xFF1DA1F2),
      ),
    ];

    return vertical
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: links.asMap().entries.map((entry) {
              return _buildSocialButton(context, entry.value, entry.key);
            }).toList(),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: links.asMap().entries.map((entry) {
              return _buildSocialButton(context, entry.value, entry.key);
            }).toList(),
          );
  }

  Widget _buildSocialButton(
    BuildContext context,
    _SocialLink link,
    int index,
  ) {
    return FadeIn(
      duration: const Duration(milliseconds: 800),
      delay: Duration(milliseconds: index * 100),
      child: Padding(
        padding: vertical
            ? const EdgeInsets.only(bottom: 16)
            : const EdgeInsets.only(right: 16),
        child: _HoverSocialButton(link: link),
      ),
    );
  }
}

class _HoverSocialButton extends StatefulWidget {
  final _SocialLink link;

  const _HoverSocialButton({required this.link});

  @override
  State<_HoverSocialButton> createState() => _HoverSocialButtonState();
}

class _HoverSocialButtonState extends State<_HoverSocialButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () {
          if (widget.link.url.isEmpty) {
            ToastHelper.showInfoToast(
              context,
              '🐦 Twitter coming soon! Stay tuned for updates.',
            );
          } else {
            UrlHelper.launchURL(widget.link.url);
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.identity()
            ..translate(0.0, _isHovered ? -4.0 : 0.0, 0.0),
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: _isHovered
                ? AppColors.primary
                : Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _isHovered
                  ? AppColors.primaryLight
                  : AppColors.primary.withOpacity(0.2),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(_isHovered ? 0.4 : 0.1),
                blurRadius: _isHovered ? 16 : 8,
                offset: Offset(0, _isHovered ? 8 : 4),
              ),
            ],
          ),
          child: Center(
            child: FaIcon(
              widget.link.icon,
              size: 20,
              color: _isHovered ? Colors.black : AppColors.primary,
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialLink {
  final IconData icon;
  final String url;
  final Color color;

  _SocialLink({
    required this.icon,
    required this.url,
    required this.color,
  });
}

