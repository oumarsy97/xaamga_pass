import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Premium Colors
  static const Color primaryBlack = Color(0xFF050505); // Deepest Black
  static const Color surfaceDark = Color(
    0xFF141414,
  ); // Slightly lighter for cards
  static const Color goldAccent = Color.fromARGB(
    255,
    180,
    141,
    12,
  ); // Metallic Gold
  static const Color premiumPurple = Color(0xFF9D50FF); // Vibrant Purple
  static const Color softGrey = Color(0xFF9E9E9E); // Secondary text

  // Semantic Aliases
  static const Color darkBackgroundColor = primaryBlack;
  static const Color bottomNavBackgroundColor = Color(
    0xFF1E1E1E,
  ); // Keep slightly lighter for contrast (or glass)
  static const Color goldColor = goldAccent;

  // Spacing
  static const double spacingXS = 4.0;
  static const double spacingS = 8.0;
  static const double spacingM = 16.0;
  static const double spacingL = 24.0;
  static const double spacingXL = 32.0;

  // Border Radius
  static const double radiusS = 6.0;
  static const double radiusM = 12.0;
  static const double radiusL = 20.0;
  static const double radiusXL = 32.0;

  // Text Styles (Base) - Premium Typography
  static TextStyle get heading1 => GoogleFonts.outfit(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    letterSpacing: -0.5,
  );

  static TextStyle get heading2 => GoogleFonts.outfit(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    letterSpacing: -0.3,
  );

  static TextStyle get heading3 => GoogleFonts.outfit(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    letterSpacing: -0.2,
  );

  static TextStyle get bodyText1 => GoogleFonts.inter(
    fontSize: 16,
    color: Colors.white.withValues(alpha: 0.9),
    letterSpacing: 0.1,
  );

  static TextStyle get bodyText2 =>
      GoogleFonts.inter(fontSize: 14, color: softGrey, letterSpacing: 0.1);

  static TextStyle get caption =>
      GoogleFonts.inter(fontSize: 12, color: softGrey, letterSpacing: 0.2);

  static TextStyle get button => GoogleFonts.outfit(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
  );

  // Dark Theme Configuration
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: primaryBlack,
    primaryColor: goldAccent,

    // Typography - Premium Fonts
    textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme).copyWith(
      displayLarge: GoogleFonts.outfit(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      displayMedium: GoogleFonts.outfit(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      displaySmall: GoogleFonts.outfit(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      headlineMedium: GoogleFonts.outfit(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      titleLarge: GoogleFonts.outfit(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        color: Colors.white.withValues(alpha: 0.9),
      ),
      bodyMedium: GoogleFonts.inter(fontSize: 14, color: softGrey),
    ),

    // Color Scheme
    colorScheme: const ColorScheme.dark(
      primary: goldAccent,
      secondary: goldAccent,
      surface: surfaceDark,
      onPrimary: Colors.black,
      onSurface: Colors.white,
    ),

    // App Bar
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      scrolledUnderElevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
    ),

    // Card Theme
    cardTheme: CardThemeData(
      color: surfaceDark,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusM),
        side: BorderSide(color: Colors.white.withValues(alpha: 0.05)),
      ),
    ),

    // Input Decoration
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surfaceDark,
      hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.3)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusL),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusL),
        borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.05)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusL),
        borderSide: const BorderSide(color: goldAccent),
      ),
    ),
  );

  // Keep Light Theme minimal or mapped to dark for consistency if requested later,
  // but for now focus on the requested "Top Interface" which implies this dark premium look.
  static ThemeData lightTheme = darkTheme;
}
