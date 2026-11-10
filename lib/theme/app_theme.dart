import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// From Style Guide:
/// Display and Screen Titles: Poppins, 600-700 weight
/// Body: inter, 400-600 weight
/// Form labels: label style - uppercase with letter-spacing. inter

/// Button and Input Specifications
/// always have visible focus-ring in accentSky

// Colors
class AppColors {
  // Primary Colors:
  static const Color brandNavy = Color.fromARGB(255, 28, 37, 65);
  static const Color accentSky = Color.fromARGB(255, 79, 142, 247);
  static const Color backgroundDark = Color.fromARGB(255, 15, 21, 38);

  // Form Colors:
  static const Color surfaceLight = Color.fromARGB(255, 244, 246, 250);
  static const Color surfaceDark = Color.fromARGB(255, 26, 34, 56);
  static const Color border = Color.fromARGB(255, 226, 230, 238);
  static const Color success = Color.fromARGB(255, 47, 158, 99);
  static const Color warning = Color.fromARGB(255, 217, 164, 65);
  static const Color danger = Color.fromARGB(255, 224, 86, 79);

  // Text Colors:
  static const Color textSecondary = Color.fromARGB(255, 91, 100, 114);
  static const Color successTextLight = Color.fromARGB(255, 16, 86, 48);
  static const Color successTextDark = Color.fromARGB(255, 140, 222, 176);
  static const Color warningTextLight = Color.fromARGB(255, 107, 67, 0);
  static const Color warningTextDark = Color.fromARGB(255, 250, 214, 140);
  static const Color dangerTextLight = Color.fromARGB(255, 147, 22, 22);
  static const Color dangerTextDark = Color.fromARGB(255, 255, 172, 166);
  }

class AppTheme{
  // Color Modes
  /// Light Mode
  static final ColorScheme lightMode = ColorScheme.fromSeed(
    dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
    seedColor: AppColors.brandNavy,
    brightness: Brightness.light,
  );

  /// To Do: Dark Mode

  // Text Theme
  static final TextTheme font = GoogleFonts.interTextTheme().copyWith(
    displayLarge: GoogleFonts.poppins(fontWeight: FontWeight(700), fontSize: 32.0),
    displayMedium: GoogleFonts.poppins(fontWeight: FontWeight(600), fontSize: 24.0),
    displaySmall: GoogleFonts.poppins(fontWeight: FontWeight(600), fontSize: 20.0),
    titleLarge: GoogleFonts.poppins(fontWeight: FontWeight(700), fontSize: 32.0),
    titleMedium: GoogleFonts.poppins(fontWeight: FontWeight(600), fontSize: 24.0),
    titleSmall: GoogleFonts.poppins(fontWeight: FontWeight(600), fontSize: 20.0),
    );

  // Base Button Theme --> Default values: Text = Label Large, Fill color = primary
  static final ButtonStyle baseButtonStyle = ButtonStyle(
    shape: WidgetStatePropertyAll(StadiumBorder()), // shape
    minimumSize: WidgetStatePropertyAll(Size(250, 80)),
    );

  // Base Textfield Theme --> Surface / OnSurface color, Primary for Text
    static final InputDecorationTheme formInputStyle = InputDecorationTheme(
      filled: true,
    );

  // Helper Method to build dynamic theme
  static ThemeData buildTheme(ColorScheme scheme) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      textTheme: font,

      // Button Styling
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: baseButtonStyle,
        ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: baseButtonStyle
        ),
      filledButtonTheme: FilledButtonThemeData(
        style: baseButtonStyle,
        ),

      // Input Form Styling
      inputDecorationTheme: formInputStyle,

      // App Bar Styling
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        centerTitle: true,
        elevation: 0,
      ),

    );
  }

  // Expose themes to MaterialApp
  static ThemeData get light => buildTheme(lightMode);
  //static ThemeData get dark => buildTheme(darkColorScheme);
}