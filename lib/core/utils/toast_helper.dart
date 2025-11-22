import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ToastHelper {
  static OverlayEntry? _currentToast;

  static void showToast(
    BuildContext context, {
    required String message,
    IconData? icon,
    Duration duration = const Duration(seconds: 3),
    bool isError = false,
  }) {
    // Remove existing toast if any
    _currentToast?.remove();

    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 24,
        right: 24,
        child: _AnimatedToast(
          message: message,
          icon: icon,
          isError: isError,
          onDismiss: () {
            overlayEntry.remove();
            _currentToast = null;
          },
        ),
      ),
    );

    _currentToast = overlayEntry;
    overlay.insert(overlayEntry);

    // Auto-dismiss after duration
    Future.delayed(duration, () {
      if (_currentToast == overlayEntry) {
        overlayEntry.remove();
        _currentToast = null;
      }
    });
  }

  static void showInfoToast(BuildContext context, String message) {
    showToast(
      context,
      message: message,
      icon: Icons.info_rounded,
      isError: false,
    );
  }

  static void showSuccessToast(BuildContext context, String message) {
    showToast(
      context,
      message: message,
      icon: Icons.check_circle_rounded,
      isError: false,
    );
  }

  static void showErrorToast(BuildContext context, String message) {
    showToast(
      context,
      message: message,
      icon: Icons.error_rounded,
      isError: true,
    );
  }
}

class _AnimatedToast extends StatefulWidget {
  final String message;
  final IconData? icon;
  final bool isError;
  final VoidCallback onDismiss;

  const _AnimatedToast({
    required this.message,
    this.icon,
    required this.isError,
    required this.onDismiss,
  });

  @override
  State<_AnimatedToast> createState() => _AnimatedToastState();
}

class _AnimatedToastState extends State<_AnimatedToast>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _slideAnimation = Tween<double>(begin: 100, end: 0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward();

    // Auto-dismiss animation
    Future.delayed(const Duration(milliseconds: 2600), () {
      if (mounted) {
        _controller.reverse().then((_) => widget.onDismiss());
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 640;
    
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_slideAnimation.value, 0),
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: Material(
              color: Colors.transparent,
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: isSmallScreen ? 300 : 400,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  gradient: widget.isError
                      ? LinearGradient(
                          colors: [
                            AppColors.error,
                            AppColors.error.withOpacity(0.8),
                          ],
                        )
                      : AppColors.luxuryGradient,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: widget.isError
                          ? AppColors.error.withOpacity(0.5)
                          : AppColors.primary.withOpacity(0.5),
                      blurRadius: 24,
                      spreadRadius: 0,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.icon != null) ...[
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          widget.icon,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                    ],
                    Flexible(
                      child: Text(
                        widget.message,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          _controller.reverse().then((_) => widget.onDismiss());
                        },
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          child: const Icon(
                            Icons.close_rounded,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

