import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/constants/app_constants.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/app_tokens.dart';
import 'core/services/firebase_service.dart';
import 'core/services/theme_store_factory.dart';
import 'presentation/providers/theme_provider.dart';
import 'presentation/providers/scroll_provider.dart';
import 'presentation/providers/contact_provider.dart';
import 'presentation/providers/cursor_provider.dart';
import 'presentation/screens/portfolio_screen.dart';
import 'presentation/widgets/custom_cursor.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase only powers the contact form. If it fails to initialise (blocked
  // network, privacy extensions) the portfolio must still render; the form
  // reports its own error when used.
  try {
    await FirebaseService.initialize();
  } catch (e) {
    debugPrint('Firebase unavailable, contact form will be degraded: $e');
  }

  GoogleFonts.config.allowRuntimeFetching = true;

  // Reads the saved theme synchronously, so the first frame already uses it and
  // the page never flashes the wrong theme.
  final themeProvider = ThemeProvider(store: createThemeStore());

  runApp(MyApp(themeProvider: themeProvider));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.themeProvider});

  final ThemeProvider themeProvider;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>.value(value: themeProvider),
        ChangeNotifierProvider(create: (_) => ScrollProvider()),
        ChangeNotifierProvider(create: (_) => ContactProvider()),
        ChangeNotifierProvider(create: (_) => CursorProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            // Flutter sets document.title from this at runtime, so it must
            // match the <title> in web/index.html.
            title: AppConstants.siteTitle,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme(),
            darkTheme: AppTheme.darkTheme(),
            themeMode: themeProvider.themeMode,
            // Subtle cross-fade between themes (palette lerps colour by colour).
            themeAnimationDuration: AppLayout.theme,
            themeAnimationCurve: Curves.easeInOut,
            builder: (context, child) {
              return CustomCursor(child: child ?? const SizedBox());
            },
            home: const PortfolioScreen(),
          );
        },
      ),
    );
  }
}
