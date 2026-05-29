import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Backgrounds
  static const screenBg = Color(0xFFF8F8F8);
  static const inputBg = Color(0xFFFFFFFF);
  static const navBg = Color(0xFF1A1A1A);
  static const btnPrimary = Color(0xFF1A1A1A);
  static const accentBg = Color(0xFFF5F3FF);
  static const divider = Color(0xFFF1F5F9);
  static const pillBorder = Color(0xFFE2E8F0);

  // Text
  static const textPrimary = Color(0xFF0F172A);
  static const textSecondary = Color(0xFF64748B);
  static const textTertiary = Color(0xFF94A3B8);
  static const textQuaternary = Color(0xFFCBD5E1);

  // Borders
  static const border = Color(0xFFEAEAEA);

  // Accent
  static const accent = Color(0xFF7C3AED);

  // Status
  static const red = Color(0xFFEF4444);
  static const redText = Color(0xFFDC2626);
  static const green = Color(0xFF16A34A);
  static const yellow = Color(0xFFCA8A04);
  static const purple = Color(0xFF7C3AED);
  static const blue = Color(0xFF3B82F6);

  // Badge backgrounds
  static const activeBadgeBg = Color(0xFFF0FDF4);
  static const pausedBadgeBg = Color(0xFFFEFCE8);
  static const expiredBadgeBg = Color(0xFFFEF2F2);
  static const blockedBadgeBg = Color(0xFFF5F3FF);

  // Call type icon backgrounds
  static const answeredIconBg = Color(0xFFF0FDF4);
  static const missedIconBg = Color(0xFFFEF2F2);
  static const blockedIconBg = Color(0xFFF5F3FF);
  static const outgoingIconBg = Color(0xFFEFF6FF);

  // Category tints
  static const workTint = Color(0xFFEFF6FF);
  static const personalTint = Color(0xFFFDF2F8);
  static const freelanceTint = Color(0xFFF0FDF4);
  static const marketplaceTint = Color(0xFFFFF7ED);
  static const spamTint = Color(0xFFF5F3FF);

  // Notification badge
  static const notifBadgeBg = Color(0xFFEF4444);

  // Profile gradient
  static const profileGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF8B5CF6), Color(0xFF6366F1)],
  );
}

class AppRadius {
  static const card = 16.0;
  static const statCard = 14.0;
  static const input = 12.0;
  static const activityIcon = 12.0;
  static const iconButton = 50.0;
  static const badge = 8.0;
  static const tabOuter = 12.0;
  static const tabInner = 10.0;
  static const nav = 9999.0;
  static const profileAvatar = 20.0;
  static const filterPill = 9999.0;
}

class AppTheme {
  static TextStyle get welcomeName => GoogleFonts.dmSans(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        letterSpacing: -0.4,
        height: 1.3,
      );

  static TextStyle get statementHeadline => GoogleFonts.dmSans(
        fontSize: 34,
        fontWeight: FontWeight.w800,
        color: AppColors.textPrimary,
        letterSpacing: -1.36,
        height: 1.1,
      );

  static TextStyle get statementAccent => GoogleFonts.dmSans(
        fontSize: 34,
        fontWeight: FontWeight.w700,
        color: AppColors.textTertiary,
        letterSpacing: -1.36,
        height: 1.1,
      );

  static TextStyle get pageTitle => GoogleFonts.dmSans(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        letterSpacing: -0.36,
      );

  static TextStyle get contactName => GoogleFonts.dmSans(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        letterSpacing: -0.44,
      );

  static TextStyle get aliasDetailName => GoogleFonts.dmSans(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        letterSpacing: -0.48,
      );

  static TextStyle get profileName => GoogleFonts.dmSans(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        letterSpacing: -0.44,
      );

  static TextStyle get loginHeadline => GoogleFonts.dmSans(
        fontSize: 30,
        fontWeight: FontWeight.w800,
        color: AppColors.textPrimary,
        letterSpacing: -1.05,
        height: 1.1,
      );

  static TextStyle get loginHeadlineGray => GoogleFonts.dmSans(
        fontSize: 30,
        fontWeight: FontWeight.w700,
        color: AppColors.textTertiary,
        letterSpacing: -1.05,
        height: 1.1,
      );

  static TextStyle get otpTitle => GoogleFonts.dmSans(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        letterSpacing: -0.48,
      );

  static TextStyle get cardName => GoogleFonts.dmSans(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        letterSpacing: -0.15,
      );

  static TextStyle get callerName => GoogleFonts.dmSans(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        letterSpacing: -0.14,
      );

  static TextStyle get body => GoogleFonts.dmSans(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
      );

  static TextStyle get bodySmall => GoogleFonts.dmSans(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
      );

  static TextStyle get cardNumber => GoogleFonts.dmSans(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
      );

  static TextStyle get sectionLabel => GoogleFonts.dmSans(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: AppColors.textTertiary,
        letterSpacing: 0.48,
      );

  static TextStyle get statValue => GoogleFonts.dmSans(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        letterSpacing: -0.44,
      );

  static TextStyle get statValueDetail => GoogleFonts.dmSans(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        letterSpacing: -0.4,
      );

  static TextStyle get statLabel => GoogleFonts.dmSans(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: AppColors.textTertiary,
      );

  static TextStyle get navLabel => GoogleFonts.dmSans(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      );

  static TextStyle get settingTitle => GoogleFonts.dmSans(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      );

  static TextStyle get settingDesc => GoogleFonts.dmSans(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.textTertiary,
      );

  static TextStyle get sectionCount => GoogleFonts.dmSans(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: AppColors.textTertiary,
      );

  static TextStyle get terms => GoogleFonts.dmSans(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        color: AppColors.textTertiary,
      );

  static TextStyle get version => GoogleFonts.dmSans(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: AppColors.textQuaternary,
      );

  static TextStyle get heading => GoogleFonts.dmSans(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  static TextStyle get caption => GoogleFonts.dmSans(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        color: AppColors.textTertiary,
      );

  static ThemeData get theme => ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.screenBg,
        textTheme: GoogleFonts.dmSansTextTheme(),
        colorScheme: ColorScheme.light(
          primary: AppColors.accent,
          secondary: AppColors.blue,
          surface: AppColors.screenBg,
        ),
      );
}
