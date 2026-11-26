import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_palette.dart';
import '../../core/theme/app_tokens.dart';
import '../../core/utils/toast_helper.dart';
import '../../core/utils/url_helper.dart';
import '../../core/utils/validators.dart';
import '../providers/contact_provider.dart';
import '../widgets/social_links.dart';
import '../widgets/ui/app_button.dart';
import '../widgets/ui/app_card.dart';
import '../widgets/ui/app_section.dart';
import '../widgets/ui/open_link.dart';

/// Contact: a validated form beside direct-contact cards.
class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.of(context).size.width >= 900;

    const form = _ContactForm();
    const info = _ContactInfo();

    return AppSection(
      alt: true,
      eyebrow: '06 · Contact',
      title: 'Get in touch',
      subtitle:
          'Have a project or an opportunity in mind? Send a message and I\'ll reply by email.',
      child: wide
          ? const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 6, child: form),
                SizedBox(width: AppSpace.x6),
                Expanded(flex: 5, child: info),
              ],
            )
          : const Column(
              children: [
                form,
                SizedBox(height: AppSpace.x5),
                info,
              ],
            ),
    );
  }
}

// ── Form ────────────────────────────────────────────────────────────────────

class _ContactForm extends StatefulWidget {
  const _ContactForm();

  @override
  State<_ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<_ContactForm> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _message = TextEditingController();

  // Validate live only after the first failed submit, so the form is not
  // covered in errors while the visitor is still typing.
  bool _attempted = false;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _message.dispose();
    super.dispose();
  }

  Future<void> _submit(ContactProvider provider) async {
    setState(() => _attempted = true);
    if (!(_formKey.currentState?.validate() ?? false)) return;

    await provider.sendMessage(
      name: _name.text.trim(),
      email: _email.text.trim(),
      message: _message.text.trim(),
    );

    if (!mounted) return;
    if (provider.isSuccess) {
      _name.clear();
      _email.clear();
      _message.clear();
      setState(() => _attempted = false);
      _formKey.currentState?.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    final mode = _attempted
        ? AutovalidateMode.onUserInteraction
        : AutovalidateMode.disabled;
    final small = MediaQuery.of(context).size.width < Breakpoints.mobile;

    return FadeInUp(
      from: 16,
      duration: const Duration(milliseconds: 600),
      child: AppCard(
        padding: EdgeInsets.all(small ? AppSpace.x2 : AppSpace.x4),
        child: Consumer<ContactProvider>(
          builder: (context, provider, _) {
            return Form(
              key: _formKey,
              autovalidateMode: mode,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _name,
                    enabled: !provider.isLoading,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    autofillHints: const [AutofillHints.name],
                    textCapitalization: TextCapitalization.words,
                    maxLength: Validators.nameMax,
                    buildCounter: _noCounter,
                    decoration: const InputDecoration(
                      labelText: 'Your name',
                      prefixIcon: Icon(Icons.person_outline_rounded),
                    ),
                    validator: Validators.name,
                  ),
                  const SizedBox(height: AppSpace.x2),
                  TextFormField(
                    controller: _email,
                    enabled: !provider.isLoading,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    autofillHints: const [AutofillHints.email],
                    maxLength: 254,
                    buildCounter: _noCounter,
                    decoration: const InputDecoration(
                      labelText: 'Your email',
                      prefixIcon: Icon(Icons.mail_outline_rounded),
                    ),
                    validator: Validators.email,
                  ),
                  const SizedBox(height: AppSpace.x2),
                  TextFormField(
                    controller: _message,
                    enabled: !provider.isLoading,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    maxLines: 6,
                    minLines: 5,
                    maxLength: Validators.messageMax,
                    decoration: const InputDecoration(
                      labelText: 'Your message',
                      alignLabelWithHint: true,
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(bottom: 88),
                        child: Icon(Icons.chat_bubble_outline_rounded),
                      ),
                    ),
                    validator: Validators.message,
                  ),
                  const SizedBox(height: AppSpace.x3),
                  AppButton(
                    label: provider.isLoading ? 'Sending…' : 'Send message',
                    icon: Icons.send_rounded,
                    expand: true,
                    loading: provider.isLoading,
                    onPressed: () => _submit(provider),
                  ),
                  _StatusBanner(provider: provider),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // Hide the per-field character counters except on the message box.
  static Widget? _noCounter(
    BuildContext context, {
    required int currentLength,
    required bool isFocused,
    required int? maxLength,
  }) => null;
}

/// Inline result of the last send. A live region, so screen readers announce
/// it without moving focus.
class _StatusBanner extends StatelessWidget {
  const _StatusBanner({required this.provider});

  final ContactProvider provider;

  @override
  Widget build(BuildContext context) {
    final message = provider.message;
    if (provider.isLoading || message == null) return const SizedBox.shrink();

    final p = context.palette;
    final ok = provider.isSuccess;
    final color = ok ? p.success : p.error;
    // The provider's copy carries a leading emoji; the icon replaces it.
    final text = message.replaceFirst(RegExp(r'^[^\w\s]+\s*'), '');

    return Semantics(
      liveRegion: true,
      container: true,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: AppSpace.x2),
        padding: const EdgeInsets.all(AppSpace.x2),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.10),
          borderRadius: AppRadius.mdAll,
          border: Border.all(color: color.withValues(alpha: 0.45)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              ok
                  ? Icons.check_circle_outline_rounded
                  : Icons.error_outline_rounded,
              color: color,
              size: 20,
            ),
            const SizedBox(width: AppSpace.x15),
            Expanded(
              child: Text(
                text,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: p.textPrimary),
              ),
            ),
            IconButton(
              tooltip: 'Dismiss',
              visualDensity: VisualDensity.compact,
              iconSize: 18,
              onPressed: context.read<ContactProvider>().clearMessage,
              icon: const Icon(Icons.close_rounded),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Direct contact ──────────────────────────────────────────────────────────

class _ContactInfo extends StatelessWidget {
  const _ContactInfo();

  /// Tries the native handler (mail / dialer); if the device has none, copies
  /// the value so the visitor can still use it.
  Future<void> _launchOrCopy(
    BuildContext context, {
    required Future<void> Function() launch,
    required String copyValue,
    required String label,
  }) async {
    try {
      await launch();
    } catch (_) {
      await Clipboard.setData(ClipboardData(text: copyValue));
      if (context.mounted) {
        ToastHelper.showInfoToast(context, '$label copied to clipboard.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;

    return FadeInUp(
      from: 16,
      delay: const Duration(milliseconds: 120),
      duration: const Duration(milliseconds: 600),
      child: Column(
        children: [
          _InfoTile(
            icon: FontAwesomeIcons.envelope,
            label: 'Email',
            value: AppConstants.email,
            onTap: () => _launchOrCopy(
              context,
              launch: () => UrlHelper.launchEmail(AppConstants.email),
              copyValue: AppConstants.email,
              label: 'Email address',
            ),
          ),
          const SizedBox(height: AppSpace.x2),
          _InfoTile(
            icon: FontAwesomeIcons.phone,
            label: 'Phone',
            value: AppConstants.phone,
            onTap: () => _launchOrCopy(
              context,
              launch: () => UrlHelper.launchPhone(AppConstants.phone),
              copyValue: AppConstants.phone,
              label: 'Phone number',
            ),
          ),
          const SizedBox(height: AppSpace.x2),
          const _InfoTile(
            icon: FontAwesomeIcons.locationDot,
            label: 'Location',
            value: AppConstants.location,
          ),
          const SizedBox(height: AppSpace.x2),
          _InfoTile(
            icon: FontAwesomeIcons.linkedinIn,
            label: 'LinkedIn',
            value: 'Connect with me',
            onTap: () => openLink(context, AppConstants.linkedin),
          ),
          const SizedBox(height: AppSpace.x3),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Also on',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: p.textTertiary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: AppSpace.x1),
          const Align(alignment: Alignment.centerLeft, child: SocialLinks()),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final text = Theme.of(context).textTheme;

    return SizedBox(
      width: double.infinity,
      child: AppCard(
        onTap: onTap,
        semanticLabel: '$label: $value',
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpace.x3,
          vertical: AppSpace.x2,
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: p.gold.withValues(alpha: p.isDark ? 0.12 : 0.14),
                borderRadius: AppRadius.mdAll,
              ),
              child: Center(child: FaIcon(icon, size: 18, color: p.accent)),
            ),
            const SizedBox(width: AppSpace.x2),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: text.bodySmall?.copyWith(color: p.textTertiary),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: text.titleSmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if (onTap != null)
              Icon(
                Icons.arrow_outward_rounded,
                size: 18,
                color: p.textTertiary,
              ),
          ],
        ),
      ),
    );
  }
}
