import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/theme/app_theme.dart';
import 'core/services/firebase_service.dart';
import 'presentation/providers/theme_provider.dart';
import 'presentation/providers/scroll_provider.dart';
import 'presentation/providers/contact_provider.dart';
import 'presentation/screens/portfolio_screen.dart';

void main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await FirebaseService.initialize();
  
  // Ensure Google Fonts are properly initialized
  GoogleFonts.config.allowRuntimeFetching = true;
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => ScrollProvider()),
        ChangeNotifierProvider(create: (_) => ContactProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
    return MaterialApp(
            title: 'Akash Madhu N P - Flutter Developer',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme(),
            darkTheme: AppTheme.darkTheme(),
            themeMode: ThemeMode.dark, // Force dark mode for luxury black theme
            home: const PortfolioScreen(),
          );
        },
        ),
    );
  }
}
