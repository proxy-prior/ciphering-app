# Ciphering Flutter App -- UI Design Spec

## Overview

Ciphering is a B2C alias phone number platform for Indian users. Users create and manage virtual alias phone numbers that receive inbound calls and SMS, keeping their real number private. Target use cases: e-commerce deliveries, insurance agents, OTP services.

Platform: Flutter (null-safe, Android + iOS). All data is mock for this UI build.

## Architecture

- **State management**: Riverpod
- **Navigation**: GoRouter with named routes (`lib/router.dart`)
- **Structure**: Classic screen/widget split (Approach B)
  - `lib/screens/` -- all screen files
  - `lib/widgets/` -- all reusable widgets
  - `lib/theme/app_theme.dart` -- all theme tokens
  - `lib/data/mock_data.dart` -- mock data
  - `lib/router.dart` -- GoRouter config
- **UI kit**: May use shadcn_flutter or similar for base components

## Design System

### Brand

- **Logo**: Square icon with purple-to-blue gradient (#7C6DD8 to #5B8DEF), rounded corners (18px radius), white square inset
- **Wordmark**: "Ciphering..." in Pacifico (script/cursive font), always with trailing ellipsis
- **Typography**: DM Sans for all body/heading text

### Color Palette (Ocean & Teal)

**Primary gradient**: #7C6DD8 (purple) to #5B8DEF (blue) -- used for CTA buttons, FAB, toggles, active nav, profile card

**Status colors**:
| Status | Color | Badge BG | Badge Text | Card Tint |
|---|---|---|---|---|
| Active | #14B8A6 | #F0FDFA | #14B8A6 | white |
| Expired | #F87171 | #FFF1F2 | #E11D48 | #FFFBFB |
| Disabled | #FB923C | #FFF7ED | #EA580C | #FFFCF8 |
| Answered | #14B8A6 | #F0FDFA | #14B8A6 | -- |
| Missed | #FB7185 | #FFF1F2 | #E11D48 | -- |
| Blocked | #A78BFA | #F5F3FF | #7C3AED | -- |

**Surfaces**:
- Screen background: #FFFFFF (white)
- Card: #FFFFFF with `box-shadow: 0 2px 8px rgba(0,0,0,0.04)`, border: 1px solid rgba(0,0,0,0.04)
- Input fields: #FAFAFE background, 1.5px #EDE9FE border
- Text primary: #1A1A2E
- Text secondary: #8E8EA0
- Text tertiary: #B0B0C0

**Background gradient**: Two blurred radial gradient circles (not linear)
- Blob 1 (purple): positioned top-left, offset (-40px, -60px), size ~260x260, color rgba(124,109,216,0.22), blur 30px, radial fade to transparent at 70%
- Blob 2 (blue): positioned top-right, offset (right: -50px, top: -40px), size ~240x240, color rgba(91,141,239,0.20), blur 30px, radial fade to transparent at 70%
- Implemented via Stack with positioned Containers + BoxDecoration + RadialGradient

### Typography Scale

| Level | Font | Size | Weight |
|---|---|---|---|
| Brand wordmark | Pacifico | 22-32px | Regular |
| Page title | DM Sans | 26px | Bold (700) |
| Heading | DM Sans | 18px | SemiBold (600) |
| Body | DM Sans | 15px | Regular (400) |
| Body small | DM Sans | 13px | Regular (400) |
| Caption | DM Sans | 11-12px | Regular/SemiBold |
| Section label | DM Sans | 11px | SemiBold (600), uppercase, letter-spacing 1.2px |

### Component Tokens

- Card border radius: 16px
- Input border radius: 14px
- Badge border radius: 20px (pill)
- Button border radius: 50px (full pill)
- Status card left border: 4px solid [status color]
- Stat pill: #F5F3FF background, 20px radius; special stat: #EDE9FE background, #7C3AED text
- FAB: 52px circle, gradient fill, shadow 0 6px 20px rgba(124,109,216,0.4)
- Bottom nav active color: #7C6DD8

## Screens

### Auth Flow

**1. Login Screen** (`login_screen.dart`)
- Radial gradient background blobs
- Centered: gradient logo icon (60x60) + "Ciphering..." wordmark
- Title: "Your Mobile Number" + subtitle
- Input: country code +91 (pre-filled, non-editable) + 10-digit phone field
- CTA: gradient pill button "Send OTP"
- Footer: ToS + Privacy Policy links in #7C6DD8

**2. OTP Verification Screen** (`otp_screen.dart`)
- Same header layout as login (logo + wordmark)
- Title: "Verify OTP" + masked number display (+91 xxxxx xxxxx)
- 6 OTP input boxes: 48x56px, 14px radius, #FAFAFE background
  - Empty: 1.5px #EDE9FE border
  - Filled: 2px #7C6DD8 border
  - Auto-advance on digit entry, backspace returns to previous
- Resend countdown: "Resend OTP in 20s" (timer in #7C6DD8)
- CTA: gradient pill "Verify OTP"

**3. Basic Details Screen** (`basic_details_screen.dart`) -- first-time users only
- Title: "Complete Your Profile" + subtitle
- Fields: Full Name, Email Address, Date of Birth (with calendar icon)
- 3-step progress bar (Login > Details > Done), teal fill for completed steps
- CTA: gradient pill "Continue"

### Main Tabs (Bottom Navigation)

Bottom nav: 4 tabs -- Alias, Call Log, Messages, Settings. Active tab uses #7C6DD8 for icon + label. Inactive: #B0B0C0.

**4. Alias Manager** (`alias_manager_screen.dart`) -- Home/Alias tab
- Top bar: "Ciphering..." wordmark + notification button (#F5F3FF bg, purple icon) + avatar (gradient circle)
- Page title: "Alias Manager" + "Manage your virtual numbers"
- Search bar + filter icon button
- Alias cards list:
  - Active: white card, left 4px teal border, full 5 stat pills, expiry date shown
  - Expired: #FFFBFB tint, left 4px coral border, collapsed to 2 stat pills
  - Disabled: #FFFCF8 tint, left 4px orange border, collapsed to 2 stat pills
  - Each card: label, number, status badge (pill), 3-dot overflow menu
  - Stat pills: pill-shaped chips in #F5F3FF, "new callers" stat in #EDE9FE with purple text
- FAB: gradient circle, plus icon, bottom-right

**5. Call Logs** (`call_logs_screen.dart`)
- Same top bar as Alias Manager
- Page title: "Call Logs" + "Your call history"
- Filter tabs: All (active, dark pill #1A1A2E) / Missed / Spam / Saved (inactive, white pill with #EDE9FE border)
- Section headers: uppercase, letter-spaced ("YESTERDAY", "LAST WEEK")
- Call rows: rounded card, icon (colored background matching status), caller name + number + "To: alias number", timestamp + status badge
- Missed rows: show callback phone icon (#7C6DD8) on right side
- Icon backgrounds: teal for answered, pink for missed, purple-light for blocked, orange-light for expired

**6. Messages** (`messages_screen.dart`)
- Same top bar
- Page title: "Messages" + "SMS received on your aliases"
- Search bar
- Message thread rows: icon + sender name + message preview (truncated) + timestamp + unread count badge (teal circle)
- Read-only notice in empty area: "Messages are read-only. Outbound SMS is not supported."
- Tapping thread opens read-only message view with explanatory banner

**7. Settings** (`settings_screen.dart`)
- Top bar: wordmark + avatar (no notification button)
- Page title: "Settings" + "Manage your account"
- Profile card: full gradient card (#7C6DD8 to #5B8DEF to #9BB5F0), avatar placeholder, name, phone, "Premium User" badge (white/20% opacity bg), Edit button
- Sections with uppercase labels:
  - APP PREFERENCES: toggle rows (Push Notifications on, Call Recording off). Toggle on: gradient fill. Toggle off: #E2E8F0.
  - ACCOUNT: icon rows with chevron (Profile Settings, Privacy & Security). Icons in #F5F3FF squares with #7C6DD8 stroke.
  - (Additional sections: App Settings with similar rows)
- Sign Out: destructive button (#FFF5F5 bg, #FFE4E6 border, #E11D48 text + icon). Triggers confirmation bottom sheet.

### Create Alias Flow

**8. DigiLocker Verification** (`digilocker_screen.dart`)
- eKYC verification via DigiLocker only (mock flow)
- Screen shows DigiLocker branding, "Verify your identity" title, explanation text, gradient CTA to proceed
- Mock: simulates redirect and return with success

**9. Purpose Screen** (`alias_purpose_screen.dart`)
- Title: "What's this alias for?"
- Predefined purpose chips (Insurance, E-commerce, Food Delivery, Banking, Other) + custom text input
- Single selection, gradient highlight on selected

**10. Plan Selection** (`plan_selection_screen.dart`)
- Title: "Choose Your Plan"
- Two plan cards: Free vs Premium
- Premium card: elevated, gradient border or badge "Recommended", highlighted visually
- Free card: basic outline style
- Feature comparison list per card
- CTA: gradient "Continue"

**11. Confirmation Screen** (`alias_confirmation_screen.dart`)
- Success state: checkmark animation, "Your new alias is ready!"
- Display: newly assigned number, purpose label, plan type
- CTA: "Go to Alias Manager"

### User Profile

**12. User Profile** (`user_profile_screen.dart`) -- from top-right avatar
- Activity Log: unified timeline of alias lifecycle events (created, expired, reactivated, deleted) + communication events (calls received, SMS received, spam blocked)
- Each entry: icon, description, timestamp, related alias number
- Premium upsell section (if not premium): gradient card with benefits list + upgrade CTA

## Reusable Widgets

| Widget | File | Purpose |
|---|---|---|
| AliasCard | `alias_card.dart` | Status-aware card with expandable stats grid |
| StatusBadge | `status_badge.dart` | Pill badge for Active/Expired/Disabled/Missed/Answered/Blocked |
| CallLogRow | `call_log_row.dart` | Call log entry with icon, info, status |
| MessageRow | `message_row.dart` | Message thread row with preview text |
| SettingsRow | `settings_row.dart` | Icon + label + subtitle + chevron |
| SectionHeader | `section_header.dart` | Uppercase label with letter-spacing |
| AppTextField | `app_text_field.dart` | Outlined, rounded, #FAFAFE bg, #EDE9FE border |
| PrimaryButton | `primary_button.dart` | Full-width gradient pill, shadow |
| OTPInputRow | `otp_input_row.dart` | 6 boxes, auto-advance, backspace-aware |
| BottomNavBar | `bottom_nav_bar.dart` | 4 tabs, active in #7C6DD8 |
| StatPill | `stat_pill.dart` | Pill chip for alias statistics |
| FilterPill | `filter_pill.dart` | Active (dark) / inactive (outline) filter tab |
| GradientBackground | `gradient_background.dart` | Two radial blob gradient behind content |

## Interaction Behaviors

- OTP boxes auto-advance on digit entry, backspace returns to previous box
- Filled OTP boxes get #7C6DD8 border, empty stay #EDE9FE
- Alias card stats collapse to first 2 for Expired/Disabled
- 3-dot overflow menu: "Disable"/"Delete" for Active; "Reactivate"/"Delete" for Disabled/Expired
- Missed call rows show callback icon on right
- Message threads are read-only, no compose UI
- Plan selection highlights recommended plan (Premium) with visual emphasis
- Settings toggles use gradient when on
- Sign Out triggers confirmation bottom sheet before proceeding
- Filter pills: active tab uses dark fill (#1A1A2E), inactive uses white with #EDE9FE border

## Mock Data Requirements (`mock_data.dart`)

- 3-5 alias entries covering Active, Expired, Disabled statuses with realistic Indian phone numbers (+91)
- 6-8 call log entries across Answered, Missed, Blocked, Expired statuses grouped by Yesterday/Last Week
- 3-4 message threads with preview text (OTP messages, delivery notifications)
- 8-10 activity log entries mixing alias lifecycle + communication events
- User profile: Danvish Muthu, +91 87783 41153, Premium User

## File Structure

```
lib/
  main.dart
  router.dart
  theme/
    app_theme.dart
  data/
    mock_data.dart
  screens/
    login_screen.dart
    otp_screen.dart
    basic_details_screen.dart
    alias_manager_screen.dart
    call_logs_screen.dart
    messages_screen.dart
    message_thread_screen.dart
    settings_screen.dart
    digilocker_screen.dart
    alias_purpose_screen.dart
    plan_selection_screen.dart
    alias_confirmation_screen.dart
    user_profile_screen.dart
  widgets/
    alias_card.dart
    status_badge.dart
    call_log_row.dart
    message_row.dart
    settings_row.dart
    section_header.dart
    app_text_field.dart
    primary_button.dart
    otp_input_row.dart
    bottom_nav_bar.dart
    stat_pill.dart
    filter_pill.dart
    gradient_background.dart
```

## Navigation Map

```
/ (login) -> /otp -> /basic-details (first-time only) -> /home
/home (shell route with bottom nav)
  /home/alias (Alias Manager)
  /home/calls (Call Logs)
  /home/messages (Messages)
  /home/messages/:threadId (Message Thread)
  /home/settings (Settings)
/create-alias/verify (DigiLocker)
/create-alias/purpose
/create-alias/plan
/create-alias/confirmation
/profile (User Profile)
```
