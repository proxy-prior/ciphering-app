# Ciphering Flutter App Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build the complete Ciphering Flutter app UI with all 13 screens, 13 reusable widgets, custom theme, mock data, and GoRouter navigation.

**Architecture:** Flutter app using Riverpod for state, GoRouter for navigation, classic screen/widget file split. All data is mock. Two blurred radial gradient blobs as background treatment. Ocean & Teal color palette with purple brand gradient.

**Tech Stack:** Flutter 3.x, Dart, flutter_riverpod, go_router, google_fonts (DM Sans + Pacifico)

**Spec:** `docs/superpowers/specs/2026-05-29-ciphering-flutter-app-design.md`

**Visual mockups:** `.superpowers/brainstorm/11513-1780058210/content/revised-design-v3.html` (open in browser for reference)

---

### Task 1: Scaffold Flutter Project

**Files:**
- Create: `pubspec.yaml`
- Create: `lib/main.dart`
- Create: `analysis_options.yaml`
- Modify: `.gitignore`

- [ ] **Step 1: Create Flutter project**

Run from the repo root (`Z:\work\ciphering\ciphering`):

```bash
flutter create . --org com.ciphering --project-name ciphering --platforms android,ios
```

This scaffolds `pubspec.yaml`, `lib/main.dart`, `android/`, `ios/`, `test/`, etc.

- [ ] **Step 2: Update pubspec.yaml with dependencies**

Replace the generated `pubspec.yaml`:

```yaml
name: ciphering
description: Alias phone number platform for Indian users
publish_to: 'none'
version: 1.0.0+1

environment:
  sdk: ^3.0.0

dependencies:
  flutter:
    sdk: flutter
  flutter_riverpod: ^2.6.1
  go_router: ^14.8.1
  google_fonts: ^6.2.1
  intl: ^0.19.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0

flutter:
  uses-material-design: true
```

- [ ] **Step 3: Update .gitignore for Flutter**

Append to the existing `.gitignore`:

```
# Flutter
*.iml
*.ipr
*.iws
.idea/
build/
.dart_tool/
.flutter-plugins
.flutter-plugins-dependencies
.packages
.pub-cache/
.pub/
pubspec.lock
*.g.dart
```

- [ ] **Step 4: Install dependencies**

```bash
flutter pub get
```

Expected: `Resolving dependencies...` followed by `Got dependencies!`

- [ ] **Step 5: Verify project runs**

```bash
flutter analyze
```

Expected: `No issues found!` (or only info-level notes from generated code)

- [ ] **Step 6: Commit**

```bash
git add pubspec.yaml lib/ analysis_options.yaml .gitignore android/ ios/ test/ web/
git commit -m "feat: scaffold Flutter project with Riverpod, GoRouter, google_fonts"
```

---

### Task 2: Theme & Design System

**Files:**
- Create: `lib/theme/app_theme.dart`

- [ ] **Step 1: Create theme file with all design tokens**

```dart
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
```

- [ ] **Step 2: Verify it compiles**

```bash
flutter analyze lib/theme/app_theme.dart
```

Expected: No issues

- [ ] **Step 3: Commit**

```bash
git add lib/theme/app_theme.dart
git commit -m "feat: add complete design system with colors, typography, and tokens"
```

---

### Task 3: Data Models & Mock Data

**Files:**
- Create: `lib/data/mock_data.dart`

- [ ] **Step 1: Create models and mock data**

```dart
import 'package:flutter/material.dart';

enum AliasStatus { active, expired, disabled }
enum CallStatus { answered, missed, blocked, expired }

class AliasModel {
  final String label;
  final String number;
  final AliasStatus status;
  final DateTime? expiryDate;
  final int incomingCalls;
  final int incomingMins;
  final int outgoingCalls;
  final int outgoingMins;
  final int newCallers;

  const AliasModel({
    required this.label,
    required this.number,
    required this.status,
    this.expiryDate,
    this.incomingCalls = 0,
    this.incomingMins = 0,
    this.outgoingCalls = 0,
    this.outgoingMins = 0,
    this.newCallers = 0,
  });
}

class CallLogModel {
  final String callerName;
  final String callerNumber;
  final String aliasNumber;
  final CallStatus status;
  final DateTime timestamp;
  final String timeGroup;

  const CallLogModel({
    required this.callerName,
    required this.callerNumber,
    required this.aliasNumber,
    required this.status,
    required this.timestamp,
    required this.timeGroup,
  });
}

class MessageThreadModel {
  final String id;
  final String senderName;
  final String senderNumber;
  final String aliasNumber;
  final String lastMessage;
  final DateTime timestamp;
  final int unreadCount;
  final List<MessageModel> messages;

  const MessageThreadModel({
    required this.id,
    required this.senderName,
    required this.senderNumber,
    required this.aliasNumber,
    required this.lastMessage,
    required this.timestamp,
    this.unreadCount = 0,
    this.messages = const [],
  });
}

class MessageModel {
  final String text;
  final DateTime timestamp;
  final bool isIncoming;

  const MessageModel({
    required this.text,
    required this.timestamp,
    this.isIncoming = true,
  });
}

class ActivityLogEntry {
  final String description;
  final DateTime timestamp;
  final String aliasNumber;
  final IconData icon;
  final Color iconColor;

  const ActivityLogEntry({
    required this.description,
    required this.timestamp,
    required this.aliasNumber,
    required this.icon,
    required this.iconColor,
  });
}

class UserProfile {
  final String name;
  final String phone;
  final String email;
  final DateTime dateOfBirth;
  final bool isPremium;

  const UserProfile({
    required this.name,
    required this.phone,
    required this.email,
    required this.dateOfBirth,
    this.isPremium = false,
  });
}

class MockData {
  static final userProfile = UserProfile(
    name: 'Danvish Muthu',
    phone: '+91 87783 41153',
    email: 'danvish@example.com',
    dateOfBirth: DateTime(1995, 6, 15),
    isPremium: true,
  );

  static final aliases = <AliasModel>[
    AliasModel(
      label: 'Insurance number',
      number: '+91 76890 65432',
      status: AliasStatus.active,
      expiryDate: DateTime(2025, 12, 12),
      incomingCalls: 240,
      incomingMins: 1233,
      outgoingCalls: 48,
      outgoingMins: 123,
      newCallers: 65,
    ),
    AliasModel(
      label: 'E-commerce number',
      number: '+91 98123 32343',
      status: AliasStatus.expired,
      incomingCalls: 240,
      incomingMins: 1233,
      outgoingCalls: 12,
      outgoingMins: 45,
      newCallers: 30,
    ),
    AliasModel(
      label: 'Other misc. number',
      number: '+91 98123 78667',
      status: AliasStatus.disabled,
      incomingCalls: 240,
      incomingMins: 1233,
      outgoingCalls: 8,
      outgoingMins: 20,
      newCallers: 15,
    ),
    AliasModel(
      label: 'Food delivery',
      number: '+91 98765 43210',
      status: AliasStatus.active,
      expiryDate: DateTime(2026, 3, 1),
      incomingCalls: 56,
      incomingMins: 120,
      outgoingCalls: 10,
      outgoingMins: 35,
      newCallers: 22,
    ),
  ];

  static final callLogs = <CallLogModel>[
    CallLogModel(
      callerName: 'Insurance HDFC',
      callerNumber: '+91 98123 23434',
      aliasNumber: '+91 76890 65432',
      status: CallStatus.answered,
      timestamp: DateTime(2025, 6, 14, 22, 23),
      timeGroup: 'Yesterday',
    ),
    CallLogModel(
      callerName: 'Amazon Delivery',
      callerNumber: '+91 98123 23434',
      aliasNumber: '+91 76890 65432',
      status: CallStatus.missed,
      timestamp: DateTime(2025, 6, 14, 21, 15),
      timeGroup: 'Yesterday',
    ),
    CallLogModel(
      callerName: 'Unknown Caller',
      callerNumber: '+91 98123 23434',
      aliasNumber: '+91 76890 65432',
      status: CallStatus.blocked,
      timestamp: DateTime(2025, 6, 14, 20, 42),
      timeGroup: 'Yesterday',
    ),
    CallLogModel(
      callerName: 'Flipkart Support',
      callerNumber: '+91 98765 11223',
      aliasNumber: '+91 98123 32343',
      status: CallStatus.answered,
      timestamp: DateTime(2025, 6, 13, 14, 30),
      timeGroup: 'Yesterday',
    ),
    CallLogModel(
      callerName: 'Swiggy Agent',
      callerNumber: '+91 98123 23434',
      aliasNumber: '+91 98123 32343',
      status: CallStatus.expired,
      timestamp: DateTime(2025, 6, 9, 10, 0),
      timeGroup: 'Last Week',
    ),
    CallLogModel(
      callerName: 'ICICI Bank',
      callerNumber: '+91 44567 89012',
      aliasNumber: '+91 76890 65432',
      status: CallStatus.answered,
      timestamp: DateTime(2025, 6, 8, 16, 45),
      timeGroup: 'Last Week',
    ),
  ];

  static final messageThreads = <MessageThreadModel>[
    MessageThreadModel(
      id: '1',
      senderName: 'HDFC Bank',
      senderNumber: '+91 98123 23434',
      aliasNumber: '+91 76890 65432',
      lastMessage: 'Your OTP for transaction is 482931. Valid for 5 mins.',
      timestamp: DateTime(2025, 6, 14, 22, 23),
      unreadCount: 2,
      messages: [
        MessageModel(
          text: 'Your OTP for transaction is 482931. Valid for 5 mins.',
          timestamp: DateTime(2025, 6, 14, 22, 23),
        ),
        MessageModel(
          text: 'Your account has been credited with INR 5,000.',
          timestamp: DateTime(2025, 6, 14, 10, 15),
        ),
      ],
    ),
    MessageThreadModel(
      id: '2',
      senderName: 'Amazon',
      senderNumber: '+91 98765 11223',
      aliasNumber: '+91 98123 32343',
      lastMessage: 'Your package has been delivered to your doorstep.',
      timestamp: DateTime(2025, 6, 13, 16, 40),
      messages: [
        MessageModel(
          text: 'Your package has been delivered to your doorstep.',
          timestamp: DateTime(2025, 6, 13, 16, 40),
        ),
        MessageModel(
          text: 'Your order #12345 has been shipped. Track: amzn.in/track123',
          timestamp: DateTime(2025, 6, 12, 9, 0),
        ),
      ],
    ),
    MessageThreadModel(
      id: '3',
      senderName: 'Swiggy',
      senderNumber: '+91 98123 55667',
      aliasNumber: '+91 98765 43210',
      lastMessage: 'Your order is out for delivery. ETA 15 mins.',
      timestamp: DateTime(2025, 6, 10, 19, 30),
      messages: [
        MessageModel(
          text: 'Your order is out for delivery. ETA 15 mins.',
          timestamp: DateTime(2025, 6, 10, 19, 30),
        ),
      ],
    ),
  ];

  static final activityLog = <ActivityLogEntry>[
    ActivityLogEntry(
      description: 'Alias "Food delivery" created',
      timestamp: DateTime(2025, 6, 14, 10, 0),
      aliasNumber: '+91 98765 43210',
      icon: Icons.add_circle_outline,
      iconColor: const Color(0xFF14B8A6),
    ),
    ActivityLogEntry(
      description: 'Call received from Insurance HDFC',
      timestamp: DateTime(2025, 6, 14, 22, 23),
      aliasNumber: '+91 76890 65432',
      icon: Icons.call_received,
      iconColor: const Color(0xFF14B8A6),
    ),
    ActivityLogEntry(
      description: 'SMS received from HDFC Bank',
      timestamp: DateTime(2025, 6, 14, 22, 23),
      aliasNumber: '+91 76890 65432',
      icon: Icons.message_outlined,
      iconColor: const Color(0xFF5B8DEF),
    ),
    ActivityLogEntry(
      description: 'Spam call blocked from Unknown Caller',
      timestamp: DateTime(2025, 6, 14, 20, 42),
      aliasNumber: '+91 76890 65432',
      icon: Icons.block,
      iconColor: const Color(0xFFA78BFA),
    ),
    ActivityLogEntry(
      description: 'Alias "E-commerce number" expired',
      timestamp: DateTime(2025, 6, 12, 0, 0),
      aliasNumber: '+91 98123 32343',
      icon: Icons.timer_off_outlined,
      iconColor: const Color(0xFFF87171),
    ),
    ActivityLogEntry(
      description: 'Missed call from Amazon Delivery',
      timestamp: DateTime(2025, 6, 14, 21, 15),
      aliasNumber: '+91 76890 65432',
      icon: Icons.call_missed,
      iconColor: const Color(0xFFFB7185),
    ),
    ActivityLogEntry(
      description: 'Alias "Other misc. number" disabled',
      timestamp: DateTime(2025, 6, 10, 12, 0),
      aliasNumber: '+91 98123 78667',
      icon: Icons.pause_circle_outline,
      iconColor: const Color(0xFFFB923C),
    ),
    ActivityLogEntry(
      description: 'Call received from ICICI Bank',
      timestamp: DateTime(2025, 6, 8, 16, 45),
      aliasNumber: '+91 76890 65432',
      icon: Icons.call_received,
      iconColor: const Color(0xFF14B8A6),
    ),
  ];
}
```

- [ ] **Step 2: Verify it compiles**

```bash
flutter analyze lib/data/mock_data.dart
```

- [ ] **Step 3: Commit**

```bash
git add lib/data/mock_data.dart
git commit -m "feat: add data models and mock data for aliases, calls, messages, activity"
```

---

### Task 4: Reusable Widgets (Foundation)

**Files:**
- Create: `lib/widgets/gradient_background.dart`
- Create: `lib/widgets/primary_button.dart`
- Create: `lib/widgets/app_text_field.dart`
- Create: `lib/widgets/status_badge.dart`
- Create: `lib/widgets/section_header.dart`
- Create: `lib/widgets/stat_pill.dart`
- Create: `lib/widgets/filter_pill.dart`

These are the building-block widgets used across multiple screens. Each is a single-file widget.

- [ ] **Step 1: Create GradientBackground widget**

Create `lib/widgets/gradient_background.dart`:

```dart
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;

  const GradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -60,
          left: -40,
          child: Container(
            width: 260,
            height: 260,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.purplePrimary.withValues(alpha: 0.22),
                  AppColors.purplePrimary.withValues(alpha: 0.08),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.4, 0.7],
              ),
            ),
          ),
        ),
        Positioned(
          top: -40,
          right: -50,
          child: Container(
            width: 240,
            height: 240,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.bluePrimary.withValues(alpha: 0.20),
                  AppColors.bluePrimary.withValues(alpha: 0.06),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.4, 0.7],
              ),
            ),
          ),
        ),
        child,
      ],
    );
  }
}
```

- [ ] **Step 2: Create PrimaryButton widget**

Create `lib/widgets/primary_button.dart`:

```dart
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const PrimaryButton({super.key, required this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          gradient: AppColors.gradient,
          borderRadius: BorderRadius.circular(AppRadius.button),
          boxShadow: [
            BoxShadow(
              color: AppColors.purplePrimary.withValues(alpha: 0.3),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: AppTheme.body.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
```

- [ ] **Step 3: Create AppTextField widget**

Create `lib/widgets/app_text_field.dart`:

```dart
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AppTextField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController? controller;
  final Widget? prefix;
  final Widget? suffix;
  final TextInputType? keyboardType;
  final bool readOnly;

  const AppTextField({
    super.key,
    required this.label,
    required this.hint,
    this.controller,
    this.prefix,
    this.suffix,
    this.keyboardType,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTheme.bodySmall.copyWith(
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: AppColors.inputBg,
            borderRadius: BorderRadius.circular(AppRadius.input),
            border: Border.all(color: AppColors.inputBorder, width: 1.5),
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            readOnly: readOnly,
            style: AppTheme.body,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: AppTheme.body.copyWith(color: AppColors.textTertiary),
              prefixIcon: prefix != null
                  ? Padding(
                      padding: const EdgeInsets.only(left: 16, right: 12),
                      child: prefix,
                    )
                  : null,
              prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
              suffixIcon: suffix,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
          ),
        ),
      ],
    );
  }
}
```

- [ ] **Step 4: Create StatusBadge widget**

Create `lib/widgets/status_badge.dart`:

```dart
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/mock_data.dart';

class StatusBadge extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color textColor;

  const StatusBadge({
    super.key,
    required this.label,
    required this.backgroundColor,
    required this.textColor,
  });

  factory StatusBadge.fromAliasStatus(AliasStatus status) {
    switch (status) {
      case AliasStatus.active:
        return const StatusBadge(label: 'Active', backgroundColor: AppColors.activeBadgeBg, textColor: AppColors.activeBadgeText);
      case AliasStatus.expired:
        return const StatusBadge(label: 'Expired', backgroundColor: AppColors.expiredBadgeBg, textColor: AppColors.expiredBadgeText);
      case AliasStatus.disabled:
        return const StatusBadge(label: 'Disabled', backgroundColor: AppColors.disabledBadgeBg, textColor: AppColors.disabledBadgeText);
    }
  }

  factory StatusBadge.fromCallStatus(CallStatus status) {
    switch (status) {
      case CallStatus.answered:
        return const StatusBadge(label: 'Answered', backgroundColor: AppColors.activeBadgeBg, textColor: AppColors.activeBadgeText);
      case CallStatus.missed:
        return const StatusBadge(label: 'Missed', backgroundColor: AppColors.expiredBadgeBg, textColor: AppColors.expiredBadgeText);
      case CallStatus.blocked:
        return const StatusBadge(label: 'Blocked', backgroundColor: AppColors.blockedBadgeBg, textColor: AppColors.blockedBadgeText);
      case CallStatus.expired:
        return const StatusBadge(label: 'Expired', backgroundColor: AppColors.disabledBadgeBg, textColor: AppColors.disabledBadgeText);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppRadius.badge),
      ),
      child: Text(
        label,
        style: AppTheme.caption.copyWith(
          color: textColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
```

- [ ] **Step 5: Create SectionHeader widget**

Create `lib/widgets/section_header.dart`:

```dart
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 20),
      child: Text(
        title.toUpperCase(),
        style: AppTheme.sectionLabel,
      ),
    );
  }
}
```

- [ ] **Step 6: Create StatPill widget**

Create `lib/widgets/stat_pill.dart`:

```dart
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class StatPill extends StatelessWidget {
  final String value;
  final String label;
  final bool isSpecial;

  const StatPill({
    super.key,
    required this.value,
    required this.label,
    this.isSpecial = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
      decoration: BoxDecoration(
        color: isSpecial ? AppColors.statSpecialBg : AppColors.statPillBg,
        borderRadius: BorderRadius.circular(AppRadius.statPill),
      ),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: value,
              style: AppTheme.caption.copyWith(
                fontWeight: FontWeight.w700,
                color: isSpecial ? AppColors.statSpecialText : AppColors.textPrimary,
              ),
            ),
            TextSpan(
              text: ' $label',
              style: AppTheme.caption.copyWith(
                color: isSpecial ? AppColors.statSpecialText : AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

- [ ] **Step 7: Create FilterPill widget**

Create `lib/widgets/filter_pill.dart`:

```dart
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class FilterPill extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback? onTap;

  const FilterPill({
    super.key,
    required this.label,
    this.isActive = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? AppColors.filterActiveBg : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: isActive ? null : Border.all(color: AppColors.inputBorder),
        ),
        child: Text(
          label,
          style: AppTheme.caption.copyWith(
            fontSize: 12,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
            color: isActive ? Colors.white : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
```

- [ ] **Step 8: Verify all widgets compile**

```bash
flutter analyze lib/widgets/
```

Expected: No issues

- [ ] **Step 9: Commit**

```bash
git add lib/widgets/
git commit -m "feat: add foundation widgets - gradient bg, button, text field, badges, pills"
```

---

### Task 5: Compound Widgets (AliasCard, CallLogRow, MessageRow, SettingsRow, OTPInputRow, BottomNavBar)

**Files:**
- Create: `lib/widgets/alias_card.dart`
- Create: `lib/widgets/call_log_row.dart`
- Create: `lib/widgets/message_row.dart`
- Create: `lib/widgets/settings_row.dart`
- Create: `lib/widgets/otp_input_row.dart`
- Create: `lib/widgets/bottom_nav_bar.dart`

- [ ] **Step 1: Create AliasCard**

Create `lib/widgets/alias_card.dart`:

```dart
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/mock_data.dart';
import 'status_badge.dart';
import 'stat_pill.dart';

class AliasCard extends StatelessWidget {
  final AliasModel alias;
  final VoidCallback? onMenuTap;

  const AliasCard({super.key, required this.alias, this.onMenuTap});

  Color get _cardTint {
    switch (alias.status) {
      case AliasStatus.active: return Colors.white;
      case AliasStatus.expired: return AppColors.expiredCardTint;
      case AliasStatus.disabled: return AppColors.disabledCardTint;
    }
  }

  Color get _borderColor {
    switch (alias.status) {
      case AliasStatus.active: return AppColors.activeColor;
      case AliasStatus.expired: return AppColors.expiredColor;
      case AliasStatus.disabled: return AppColors.disabledColor;
    }
  }

  bool get _showAllStats => alias.status == AliasStatus.active;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _cardTint,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border(left: BorderSide(color: _borderColor, width: AppRadius.statusBorder)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(alias.label, style: AppTheme.body.copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 2),
                    Text(alias.number, style: AppTheme.bodySmall),
                  ],
                ),
              ),
              Row(
                children: [
                  StatusBadge.fromAliasStatus(alias.status),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: onMenuTap,
                    child: Text('...', style: TextStyle(fontSize: 18, color: AppColors.textTertiary, letterSpacing: 1)),
                  ),
                ],
              ),
            ],
          ),
          if (alias.status == AliasStatus.active && alias.expiryDate != null) ...[
            const SizedBox(height: 4),
            Text(
              'Expires on ${alias.expiryDate!.day} ${_monthName(alias.expiryDate!.month)} ${alias.expiryDate!.year}',
              style: AppTheme.caption,
            ),
          ],
          const SizedBox(height: 10),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              StatPill(value: '${alias.incomingCalls}', label: 'calls in'),
              StatPill(value: '${alias.incomingMins}', label: 'min in'),
              if (_showAllStats) ...[
                StatPill(value: '${alias.outgoingCalls}', label: 'calls out'),
                StatPill(value: '${alias.outgoingMins}', label: 'min out'),
                StatPill(value: '${alias.newCallers}', label: 'new callers', isSpecial: true),
              ],
            ],
          ),
        ],
      ),
    );
  }

  String _monthName(int month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month - 1];
  }
}
```

- [ ] **Step 2: Create CallLogRow**

Create `lib/widgets/call_log_row.dart`:

```dart
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/mock_data.dart';
import 'status_badge.dart';

class CallLogRow extends StatelessWidget {
  final CallLogModel call;
  final VoidCallback? onCallBack;

  const CallLogRow({super.key, required this.call, this.onCallBack});

  Color get _iconBg {
    switch (call.status) {
      case CallStatus.answered: return AppColors.activeBadgeBg;
      case CallStatus.missed: return AppColors.expiredBadgeBg;
      case CallStatus.blocked: return AppColors.blockedBadgeBg;
      case CallStatus.expired: return AppColors.disabledBadgeBg;
    }
  }

  Color get _iconColor {
    switch (call.status) {
      case CallStatus.answered: return AppColors.activeColor;
      case CallStatus.missed: return AppColors.missedColor;
      case CallStatus.blocked: return AppColors.blockedColor;
      case CallStatus.expired: return AppColors.disabledColor;
    }
  }

  IconData get _icon {
    switch (call.status) {
      case CallStatus.answered: return Icons.call_received;
      case CallStatus.missed: return Icons.call_missed;
      case CallStatus.blocked: return Icons.block;
      case CallStatus.expired: return Icons.access_time;
    }
  }

  String get _timeStr {
    final h = call.timestamp.hour;
    final m = call.timestamp.minute.toString().padLeft(2, '0');
    final ampm = h >= 12 ? 'PM' : 'AM';
    final hour = h > 12 ? h - 12 : (h == 0 ? 12 : h);
    return '$hour:$m $ampm';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.cardBorder),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 4, offset: const Offset(0, 1)),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40, height: 40,
            decoration: BoxDecoration(color: _iconBg, borderRadius: BorderRadius.circular(AppRadius.rowIcon)),
            child: Icon(_icon, size: 18, color: _iconColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(call.callerName, style: AppTheme.body.copyWith(fontSize: 14, fontWeight: FontWeight.w600)),
                Text(call.callerNumber, style: AppTheme.bodySmall.copyWith(fontSize: 12)),
                Text('To: ${call.aliasNumber}', style: AppTheme.caption),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(_timeStr, style: AppTheme.bodySmall.copyWith(fontSize: 12)),
              const SizedBox(height: 3),
              StatusBadge.fromCallStatus(call.status),
              if (call.status == CallStatus.missed) ...[
                const SizedBox(height: 4),
                GestureDetector(
                  onTap: onCallBack,
                  child: Icon(Icons.call, size: 16, color: AppColors.purplePrimary),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
```

- [ ] **Step 3: Create MessageRow**

Create `lib/widgets/message_row.dart`:

```dart
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/mock_data.dart';

class MessageRow extends StatelessWidget {
  final MessageThreadModel thread;
  final VoidCallback? onTap;

  const MessageRow({super.key, required this.thread, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.cardBorder),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 4, offset: const Offset(0, 1)),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 40, height: 40,
              decoration: BoxDecoration(
                color: AppColors.activeBadgeBg,
                borderRadius: BorderRadius.circular(AppRadius.rowIcon),
              ),
              child: Icon(Icons.message_outlined, size: 18, color: AppColors.activeColor),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(thread.senderName, style: AppTheme.body.copyWith(fontSize: 14, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 1),
                  Text(
                    thread.lastMessage,
                    style: AppTheme.bodySmall.copyWith(fontSize: 12, color: AppColors.textTertiary),
                    maxLines: 1, overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(_formatTime(thread.timestamp), style: AppTheme.bodySmall.copyWith(fontSize: 12)),
                if (thread.unreadCount > 0) ...[
                  const SizedBox(height: 4),
                  Container(
                    width: 18, height: 18,
                    decoration: const BoxDecoration(color: AppColors.activeColor, shape: BoxShape.circle),
                    child: Center(
                      child: Text('${thread.unreadCount}', style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600)),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime dt) {
    final now = DateTime.now();
    final diff = now.difference(dt);
    if (diff.inDays == 0) {
      final h = dt.hour > 12 ? dt.hour - 12 : (dt.hour == 0 ? 12 : dt.hour);
      return '$h:${dt.minute.toString().padLeft(2, '0')} ${dt.hour >= 12 ? 'PM' : 'AM'}';
    } else if (diff.inDays == 1) {
      return 'Yesterday';
    } else {
      return '${dt.day}/${dt.month}';
    }
  }
}
```

- [ ] **Step 4: Create SettingsRow**

Create `lib/widgets/settings_row.dart`:

```dart
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SettingsRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final VoidCallback? onTap;

  const SettingsRow({
    super.key,
    required this.icon,
    required this.label,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 32, height: 32,
              decoration: BoxDecoration(
                color: AppColors.notifBtnBg,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, size: 16, color: AppColors.purplePrimary),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: AppTheme.body.copyWith(fontSize: 14, fontWeight: FontWeight.w500)),
                  Text(subtitle, style: AppTheme.caption.copyWith(fontSize: 12, color: AppColors.textTertiary)),
                ],
              ),
            ),
            Icon(Icons.chevron_right, size: 16, color: AppColors.textTertiary),
          ],
        ),
      ),
    );
  }
}
```

- [ ] **Step 5: Create OTPInputRow**

Create `lib/widgets/otp_input_row.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_theme.dart';

class OTPInputRow extends StatefulWidget {
  final int length;
  final ValueChanged<String>? onCompleted;

  const OTPInputRow({super.key, this.length = 6, this.onCompleted});

  @override
  State<OTPInputRow> createState() => _OTPInputRowState();
}

class _OTPInputRowState extends State<OTPInputRow> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.length, (_) => TextEditingController());
    _focusNodes = List.generate(widget.length, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final c in _controllers) { c.dispose(); }
    for (final f in _focusNodes) { f.dispose(); }
    super.dispose();
  }

  void _onChanged(int index, String value) {
    if (value.length == 1 && index < widget.length - 1) {
      _focusNodes[index + 1].requestFocus();
    }
    final otp = _controllers.map((c) => c.text).join();
    if (otp.length == widget.length) {
      widget.onCompleted?.call(otp);
    }
  }

  void _onKey(int index, RawKeyEvent event) {
    if (event is RawKeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace &&
        _controllers[index].text.isEmpty &&
        index > 0) {
      _controllers[index - 1].clear();
      _focusNodes[index - 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.length, (i) {
        final hasFocus = _controllers[i].text.isNotEmpty;
        return Container(
          width: 48, height: 56,
          margin: EdgeInsets.only(right: i < widget.length - 1 ? 10 : 0),
          child: RawKeyboardListener(
            focusNode: FocusNode(),
            onKey: (event) => _onKey(i, event),
            child: TextField(
              controller: _controllers[i],
              focusNode: _focusNodes[i],
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              maxLength: 1,
              style: AppTheme.pageTitle.copyWith(fontSize: 22),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: (v) => _onChanged(i, v),
              decoration: InputDecoration(
                counterText: '',
                filled: true,
                fillColor: AppColors.inputBg,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(
                    color: hasFocus ? AppColors.purplePrimary : AppColors.inputBorder,
                    width: hasFocus ? 2 : 1.5,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(
                    color: hasFocus ? AppColors.purplePrimary : AppColors.inputBorder,
                    width: hasFocus ? 2 : 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: AppColors.purplePrimary, width: 2),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
```

- [ ] **Step 6: Create BottomNavBar**

Create `lib/widgets/bottom_nav_bar.dart`:

```dart
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavBar({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.navDivider)),
      ),
      padding: const EdgeInsets.only(top: 10, bottom: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavItem(icon: Icons.grid_view_rounded, label: 'Alias', isActive: currentIndex == 0, onTap: () => onTap(0)),
          _NavItem(icon: Icons.call, label: 'Call Log', isActive: currentIndex == 1, onTap: () => onTap(1)),
          _NavItem(icon: Icons.chat_bubble_outline, label: 'Messages', isActive: currentIndex == 2, onTap: () => onTap(2)),
          _NavItem(icon: Icons.settings_outlined, label: 'Settings', isActive: currentIndex == 3, onTap: () => onTap(3)),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({required this.icon, required this.label, required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final color = isActive ? AppColors.purplePrimary : AppColors.textTertiary;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(height: 3),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: color,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
```

- [ ] **Step 7: Verify all compound widgets compile**

```bash
flutter analyze lib/widgets/
```

Expected: No issues

- [ ] **Step 8: Commit**

```bash
git add lib/widgets/alias_card.dart lib/widgets/call_log_row.dart lib/widgets/message_row.dart lib/widgets/settings_row.dart lib/widgets/otp_input_row.dart lib/widgets/bottom_nav_bar.dart
git commit -m "feat: add compound widgets - alias card, call/message rows, OTP input, nav bar"
```

---

### Task 6: Router & App Shell

**Files:**
- Create: `lib/router.dart`
- Modify: `lib/main.dart`

- [ ] **Step 1: Create GoRouter configuration**

Create `lib/router.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'screens/login_screen.dart';
import 'screens/otp_screen.dart';
import 'screens/basic_details_screen.dart';
import 'screens/alias_manager_screen.dart';
import 'screens/call_logs_screen.dart';
import 'screens/messages_screen.dart';
import 'screens/message_thread_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/digilocker_screen.dart';
import 'screens/alias_purpose_screen.dart';
import 'screens/plan_selection_screen.dart';
import 'screens/alias_confirmation_screen.dart';
import 'screens/user_profile_screen.dart';
import 'screens/home_shell.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (_, __) => const LoginScreen()),
    GoRoute(path: '/otp', builder: (_, __) => const OtpScreen()),
    GoRoute(path: '/basic-details', builder: (_, __) => const BasicDetailsScreen()),
    ShellRoute(
      builder: (_, __, child) => HomeShell(child: child),
      routes: [
        GoRoute(path: '/home/alias', builder: (_, __) => const AliasManagerScreen()),
        GoRoute(path: '/home/calls', builder: (_, __) => const CallLogsScreen()),
        GoRoute(path: '/home/messages', builder: (_, __) => const MessagesScreen()),
        GoRoute(
          path: '/home/messages/:threadId',
          builder: (_, state) => MessageThreadScreen(threadId: state.pathParameters['threadId']!),
        ),
        GoRoute(path: '/home/settings', builder: (_, __) => const SettingsScreen()),
      ],
    ),
    GoRoute(path: '/create-alias/verify', builder: (_, __) => const DigilockerScreen()),
    GoRoute(path: '/create-alias/purpose', builder: (_, __) => const AliasPurposeScreen()),
    GoRoute(path: '/create-alias/plan', builder: (_, __) => const PlanSelectionScreen()),
    GoRoute(path: '/create-alias/confirmation', builder: (_, __) => const AliasConfirmationScreen()),
    GoRoute(path: '/profile', builder: (_, __) => const UserProfileScreen()),
  ],
);
```

- [ ] **Step 2: Create HomeShell with bottom nav**

Create `lib/screens/home_shell.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/bottom_nav_bar.dart';

class HomeShell extends StatelessWidget {
  final Widget child;

  const HomeShell({super.key, required this.child});

  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/home/calls')) return 1;
    if (location.startsWith('/home/messages')) return 2;
    if (location.startsWith('/home/settings')) return 3;
    return 0;
  }

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0: context.go('/home/alias');
      case 1: context.go('/home/calls');
      case 2: context.go('/home/messages');
      case 3: context.go('/home/settings');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex(context),
        onTap: (i) => _onTap(context, i),
      ),
    );
  }
}
```

- [ ] **Step 3: Update main.dart**

Replace `lib/main.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'router.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const ProviderScope(child: CipheringApp()));
}

class CipheringApp extends StatelessWidget {
  const CipheringApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Ciphering',
      theme: AppTheme.theme,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
```

- [ ] **Step 4: Create stub screen files**

Create all 13 screen files as stubs so the router compiles. Each stub follows this pattern (adjust class name and title for each):

For each of these files, create a stub:
- `lib/screens/login_screen.dart` -> `LoginScreen` / "Login"
- `lib/screens/otp_screen.dart` -> `OtpScreen` / "OTP"
- `lib/screens/basic_details_screen.dart` -> `BasicDetailsScreen` / "Basic Details"
- `lib/screens/alias_manager_screen.dart` -> `AliasManagerScreen` / "Alias Manager"
- `lib/screens/call_logs_screen.dart` -> `CallLogsScreen` / "Call Logs"
- `lib/screens/messages_screen.dart` -> `MessagesScreen` / "Messages"
- `lib/screens/message_thread_screen.dart` -> `MessageThreadScreen` / "Message Thread" (takes `threadId` param)
- `lib/screens/settings_screen.dart` -> `SettingsScreen` / "Settings"
- `lib/screens/digilocker_screen.dart` -> `DigilockerScreen` / "DigiLocker"
- `lib/screens/alias_purpose_screen.dart` -> `AliasPurposeScreen` / "Alias Purpose"
- `lib/screens/plan_selection_screen.dart` -> `PlanSelectionScreen` / "Plan Selection"
- `lib/screens/alias_confirmation_screen.dart` -> `AliasConfirmationScreen` / "Alias Confirmation"
- `lib/screens/user_profile_screen.dart` -> `UserProfileScreen` / "User Profile"

Stub template (example for login):

```dart
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Login')));
  }
}
```

For `MessageThreadScreen`, add the threadId parameter:

```dart
import 'package:flutter/material.dart';

class MessageThreadScreen extends StatelessWidget {
  final String threadId;
  const MessageThreadScreen({super.key, required this.threadId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Thread $threadId')));
  }
}
```

- [ ] **Step 5: Verify the app compiles and router works**

```bash
flutter analyze
```

Expected: No issues

- [ ] **Step 6: Commit**

```bash
git add lib/router.dart lib/main.dart lib/screens/
git commit -m "feat: add GoRouter config, home shell with bottom nav, all screen stubs"
```

---

### Task 7: Auth Screens (Login, OTP, Basic Details)

**Files:**
- Modify: `lib/screens/login_screen.dart`
- Modify: `lib/screens/otp_screen.dart`
- Modify: `lib/screens/basic_details_screen.dart`

- [ ] **Step 1: Implement LoginScreen**

Replace `lib/screens/login_screen.dart` with the full implementation using GradientBackground, PrimaryButton, the brand logo+wordmark header, phone input with +91 prefix, and ToS footer. Navigate to `/otp` on "Send OTP" tap.

Key elements:
- `GradientBackground` wrapping a `SafeArea` + `Column`
- Centered logo (60x60 gradient container with white inset) + `Ciphering...` wordmark (Pacifico 32px)
- Title "Your Mobile Number" (pageTitle style) + subtitle
- Phone input: `AppTextField` with +91 prefix as a Row with divider
- `PrimaryButton(label: 'Send OTP', onPressed: () => context.go('/otp'))`
- Footer with ToS/Privacy links in `AppColors.purplePrimary`

- [ ] **Step 2: Implement OtpScreen**

Replace `lib/screens/otp_screen.dart` with:
- Same logo+wordmark header as login
- "Verify OTP" title + masked number "+91 xxxxx xxxxx"
- `OTPInputRow(onCompleted: (otp) => ...)`
- Resend countdown using `StatefulWidget` with a `Timer` counting down from 30
- `PrimaryButton(label: 'Verify OTP', onPressed: () => context.go('/basic-details'))`

- [ ] **Step 3: Implement BasicDetailsScreen**

Replace `lib/screens/basic_details_screen.dart` with:
- "Complete Your Profile" title + subtitle
- Three `AppTextField` fields: Full Name, Email, DOB (DOB with calendar suffix icon)
- Progress bar: Row of 3 containers, first 2 filled with `AppColors.activeColor`, third neutral
- `PrimaryButton(label: 'Continue', onPressed: () => context.go('/home/alias'))`

- [ ] **Step 4: Verify auth flow navigation**

```bash
flutter analyze lib/screens/login_screen.dart lib/screens/otp_screen.dart lib/screens/basic_details_screen.dart
```

- [ ] **Step 5: Commit**

```bash
git add lib/screens/login_screen.dart lib/screens/otp_screen.dart lib/screens/basic_details_screen.dart
git commit -m "feat: implement auth flow - login, OTP verification, basic details screens"
```

---

### Task 8: Alias Manager Screen

**Files:**
- Modify: `lib/screens/alias_manager_screen.dart`

- [ ] **Step 1: Implement full Alias Manager screen**

Replace stub with full implementation:
- `GradientBackground` wrapper
- Top bar: Row with wordmark, notif button (purple bell icon in #F5F3FF container), gradient avatar circle
- Page header: "Alias Manager" (pageTitle) + "Manage your virtual numbers" (page-sub)
- Search bar + filter icon button
- `ListView` of `AliasCard` widgets built from `MockData.aliases`
- 3-dot overflow menu uses `showModalBottomSheet` with options based on status
- Gradient FAB positioned bottom-right using `floatingActionButton` on Scaffold, navigates to `/create-alias/verify`

- [ ] **Step 2: Verify**

```bash
flutter analyze lib/screens/alias_manager_screen.dart
```

- [ ] **Step 3: Commit**

```bash
git add lib/screens/alias_manager_screen.dart
git commit -m "feat: implement alias manager screen with cards, search, FAB"
```

---

### Task 9: Call Logs Screen

**Files:**
- Modify: `lib/screens/call_logs_screen.dart`

- [ ] **Step 1: Implement full Call Logs screen**

Replace stub with:
- `GradientBackground` + top bar (same as alias manager)
- Page header: "Call Logs" + "Your call history"
- Filter pills row: `FilterPill` widgets for All/Missed/Spam/Saved with state management via `useState` or local `StatefulWidget`
- Group call logs by `timeGroup` and render `SectionHeader` + list of `CallLogRow` widgets from `MockData.callLogs`
- Filter logic: "All" shows everything, "Missed" filters to `CallStatus.missed`, "Spam" to `CallStatus.blocked`, "Saved" to `CallStatus.answered`

- [ ] **Step 2: Commit**

```bash
git add lib/screens/call_logs_screen.dart
git commit -m "feat: implement call logs screen with filters and grouped rows"
```

---

### Task 10: Messages Screen & Thread

**Files:**
- Modify: `lib/screens/messages_screen.dart`
- Modify: `lib/screens/message_thread_screen.dart`

- [ ] **Step 1: Implement Messages screen**

Replace stub with:
- `GradientBackground` + top bar
- Page header: "Messages" + "SMS received on your aliases"
- Search bar
- `ListView` of `MessageRow` from `MockData.messageThreads`, tapping navigates to `/home/messages/:threadId`
- Below the list (or in empty space): centered read-only notice icon + text "Messages are read-only.\nOutbound SMS is not supported."

- [ ] **Step 2: Implement MessageThreadScreen**

Replace stub with:
- AppBar with back button and sender name
- Banner at top: "This conversation is read-only. Outbound SMS is not supported." in a tinted container
- ListView of message bubbles (incoming only, left-aligned) showing text + timestamp
- No compose/reply UI

- [ ] **Step 3: Commit**

```bash
git add lib/screens/messages_screen.dart lib/screens/message_thread_screen.dart
git commit -m "feat: implement messages list and read-only thread view"
```

---

### Task 11: Settings Screen

**Files:**
- Modify: `lib/screens/settings_screen.dart`

- [ ] **Step 1: Implement full Settings screen**

Replace stub with:
- `GradientBackground` + top bar (wordmark + avatar, no notif button)
- Page header: "Settings" + "Manage your account"
- Gradient profile card: Container with `AppColors.profileGradient`, avatar circle, user name/phone from `MockData.userProfile`, "Premium User" badge, Edit button
- APP PREFERENCES section: `SectionHeader` + card with toggle rows (Switch widget styled with gradient when on)
- ACCOUNT section: `SectionHeader` + card with `SettingsRow` items (Profile Settings, Privacy & Security)
- APP SETTINGS section: similar `SettingsRow` items
- Sign Out button: destructive styled container with icon + text, `onTap` shows `showModalBottomSheet` confirmation

- [ ] **Step 2: Commit**

```bash
git add lib/screens/settings_screen.dart
git commit -m "feat: implement settings screen with profile card, toggles, sign out"
```

---

### Task 12: Create Alias Flow (4 screens)

**Files:**
- Modify: `lib/screens/digilocker_screen.dart`
- Modify: `lib/screens/alias_purpose_screen.dart`
- Modify: `lib/screens/plan_selection_screen.dart`
- Modify: `lib/screens/alias_confirmation_screen.dart`

- [ ] **Step 1: Implement DigiLocker screen**

Replace stub with:
- `GradientBackground` + back button
- DigiLocker branding (blue gradient icon)
- "Verify your identity" title + explanation text about DigiLocker eKYC
- Gradient CTA "Verify with DigiLocker" -> mock delay (2s with loading indicator) then navigate to `/create-alias/purpose`

- [ ] **Step 2: Implement Purpose screen**

Replace stub with:
- "What's this alias for?" title
- Grid of purpose chips: Insurance, E-commerce, Food Delivery, Banking, Other
- Each chip is a selectable container: selected gets gradient border + fill, unselected is outline
- Custom text input appears when "Other" selected
- Gradient CTA "Continue" -> `/create-alias/plan`

- [ ] **Step 3: Implement Plan Selection screen**

Replace stub with:
- "Choose Your Plan" title
- Two plan cards side by side or stacked:
  - Free: outline card, basic features list
  - Premium: elevated card with gradient border, "Recommended" badge, premium features list, highlighted
- Feature bullets per card (e.g., "1 alias", "Basic call forwarding" vs "Unlimited aliases", "Call recording", etc.)
- Gradient CTA "Continue" -> `/create-alias/confirmation`

- [ ] **Step 4: Implement Confirmation screen**

Replace stub with:
- Animated checkmark (use `AnimatedContainer` or simple `Icon` with scale animation)
- "Your new alias is ready!" title
- Card showing: assigned number (+91 mock), purpose label, plan type
- Gradient CTA "Go to Alias Manager" -> `context.go('/home/alias')`

- [ ] **Step 5: Commit**

```bash
git add lib/screens/digilocker_screen.dart lib/screens/alias_purpose_screen.dart lib/screens/plan_selection_screen.dart lib/screens/alias_confirmation_screen.dart
git commit -m "feat: implement create alias flow - DigiLocker, purpose, plan, confirmation"
```

---

### Task 13: User Profile Screen

**Files:**
- Modify: `lib/screens/user_profile_screen.dart`

- [ ] **Step 1: Implement User Profile screen**

Replace stub with:
- AppBar with "Profile" title and back button
- `GradientBackground`
- Activity Log section: `SectionHeader("Activity Log")` + ListView of activity entries from `MockData.activityLog`
- Each entry: Row with colored icon circle, description text, timestamp, related alias number
- Premium upsell section (conditionally shown if `!userProfile.isPremium`): gradient card with benefits and upgrade CTA

- [ ] **Step 2: Commit**

```bash
git add lib/screens/user_profile_screen.dart
git commit -m "feat: implement user profile with activity log and premium upsell"
```

---

### Task 14: Polish & Final Verification

- [ ] **Step 1: Run full analysis**

```bash
flutter analyze
```

Fix any warnings or errors.

- [ ] **Step 2: Test on emulator/device**

```bash
flutter run
```

Walk through: Login -> OTP -> Basic Details -> Alias Manager -> Call Logs -> Messages -> Message Thread -> Settings -> Create Alias flow -> User Profile. Verify all navigation works and screens render correctly.

- [ ] **Step 3: Commit any fixes**

```bash
git add -A
git commit -m "fix: polish and resolve analysis warnings"
```
