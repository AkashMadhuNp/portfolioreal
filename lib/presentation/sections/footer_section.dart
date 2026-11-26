import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_palette.dart';
import '../../core/theme/app_tokens.dart';
import '../widgets/social_links.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final width = MediaQuery.of(context).size.width;
    final narrow = width < Breakpoints.tablet;
    final text = Theme.of(context).textTheme;

    final copy = Column(
      crossAxisAlignment: narrow
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.start,
      children: [
        Text(
          '© ${DateTime.now().year} ${AppConstants.name}',
          style: text.bodyMedium?.copyWith(color: p.textPrimary),
        ),
        const SizedBox(height: AppSpace.x05),
        Text(
          'Designed and built with Flutter.',
          style: text.bodySmall?.copyWith(color: p.textTertiary),
        ),
      ],
    );

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: p.border)),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: AppSpace.gutter(width),
        vertical: AppSpace.x5,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppLayout.maxContentWidth,
          ),
          child: narrow
              // Full width, otherwise the Center above shrink-wraps this
              // column and floats it away from the page gutter.
              ? SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      copy,
                      const SizedBox(height: AppSpace.x3),
                      const SocialLinks(),
                    ],
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [copy, const SocialLinks()],
                ),
        ),
      ),
    );
  }
}
