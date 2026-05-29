import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const purplePrimary = Color(0xFF7C6DD8);
  static const bluePrimary = Color(0xFF5B8DEF);
  static const blueLight = Color(0xFF9BB5F0);

  static const activeColor = Color(0xFF14B8A6);
  static const expiredColor = Color(0xFFF87171);
  static const disabledColor = Color(0xFFFB923C);
  static const answeredColor = Color(0xFF14B8A6);
  static const missedColor = Color(0xFFFB7185);
  static const blockedColor = Color(0xFFA78BFA);

  static const activeBadgeBg = Color(0xFFF0FDFA);
  static const activeBadgeText = Color(0xFF14B8A6);
  static const expiredBadgeBg = Color(0xFFFFF1F2);
  static const expiredBadgeText = Color(0xFFE11D48);
  static const disabledBadgeBg = Color(0xFFFFF7ED);
  static const disabledBadgeText = Color(0xFFEA580C);
  static const blockedBadgeBg = Color(0xFFF5F3FF);
  static const blockedBadgeText = Color(0xFF7C3AED);

  static const expiredCardTint = Color(0xFFFFFBFB);
  static const disabledCardTint = Color(0xFFFFFCF8);

  static const screenBg = Color(0xFFFFFFFF);
  static const cardBorder = Color(0x0A000000);
  static const inputBg = Color(0xFFFAFAFE);
  static const inputBorder = Color(0xFFEDE9FE);
  static const statPillBg = Color(0xFFF5F3FF);
  static const statSpecialBg = Color(0xFFEDE9FE);
  static const statSpecialText = Color(0xFF7C3AED);

  static const textPrimary = Color(0xFF1A1A2E);
  static const textSecondary = Color(0xFF8E8EA0);
  static const textTertiary = Color(0xFFB0B0C0);

  static const filterActiveBg = Color(0xFF1A1A2E);
  static const navDivider = Color(0xFFF0EDF5);

  static const destructiveBg = Color(0xFFFFF5F5);
  static const destructiveBorder = Color(0xFFFFE4E6);
  static const destructiveText = Color(0xFFE11D48);

  static const notifBtnBg = Color(0xFFF5F3FF);

  static const gradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [purplePrimary, bluePrimary],
  );

  static const profileGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [purplePrimary, bluePrimary, blueLight],
  );
}

class AppRadius {
  static const card = 16.0;
  static const input = 14.0;
  static const badge = 20.0;
  static const button = 50.0;
  static const statusBorder = 4.0;
  static const statPill = 20.0;
  static const logo = 18.0;
  static const rowIcon = 12.0;
}

class AppTheme {
  static TextStyle get wordmark => GoogleFonts.pacifico(
        fontSize: 22,
        color: AppColors.textPrimary,
      );

  static TextStyle get wordmarkLarge => GoogleFonts.pacifico(
        fontSize: 32,
        color: AppColors.textPrimary,
      );

  static TextStyle get pageTitle => GoogleFonts.dmSans(
        fontSize: 26,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      );

  static TextStyle get heading => GoogleFonts.dmSans(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  static TextStyle get body => GoogleFonts.dmSans(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
      );

  static TextStyle get bodySmall => GoogleFonts.dmSans(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
      );

  static TextStyle get caption => GoogleFonts.dmSans(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        color: AppColors.textTertiary,
      );

  static TextStyle get sectionLabel => GoogleFonts.dmSans(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: AppColors.textSecondary,
        letterSpacing: 1.2,
      );

  static ThemeData get theme => ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.screenBg,
        textTheme: GoogleFonts.dmSansTextTheme(),
        colorScheme: ColorScheme.light(
          primary: AppColors.purplePrimary,
          secondary: AppColors.bluePrimary,
          surface: AppColors.screenBg,
        ),
      );
}
