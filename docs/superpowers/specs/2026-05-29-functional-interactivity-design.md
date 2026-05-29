# Ciphering App -- Functional Interactivity Spec

## Goal

Wire up all stub interactions in the Ciphering Flutter app with mock data, making every non-disabled menu, button, and action fully functional within a session. State changes persist across screen transitions via Riverpod.

## Locked/Disabled (NOT touched)

- SMS tab in bottom nav (stays locked)
- Subscription setting (stays locked)
- Dark Mode setting (stays locked)

## Architecture

### State Management: Riverpod StateNotifier per domain

Four providers in `lib/providers/`:

| Provider | File | State Type | Purpose |
|---|---|---|---|
| `aliasProvider` | `alias_provider.dart` | `List<AliasModel>` | Alias CRUD + status mutations |
| `callLogProvider` | `call_log_provider.dart` | `List<CallLogModel>` | Call log mutations |
| `notificationProvider` | `notification_provider.dart` | `List<NotificationModel>` | Notification read state |
| `userProfileProvider` | `user_profile_provider.dart` | `UserProfile` | Profile edits, sign out |

### Derived Providers (computed, read-only)

| Provider | Derives From | Purpose |
|---|---|---|
| `aliasStatsProvider` | `aliasProvider` | Total count, active count, total calls for QuickStatsRibbon |
| `unreadNotificationCountProvider` | `notificationProvider` | Bell badge number |
| `filteredAliasProvider` | `aliasProvider` + search query + status filter | Filtered alias list |
| `filteredCallLogProvider` | `callLogProvider` + filter selection | Filtered call log list |

### Model Changes (`mock_data.dart`)

Add `copyWith()` methods to: `AliasModel`, `CallLogModel`, `NotificationModel`, `UserProfile`.
Add `isBlocked` and `isSaved` boolean fields to `CallLogModel`.

### Shared Widget: `ConfirmationDialog`

New file `lib/widgets/confirmation_dialog.dart`. Reusable dialog with title, message, confirm button text, destructive flag (red button styling). Returns `true`/`false`.

## Interaction Wiring -- Per Screen

### Alias Manager Screen

- **Search box**: `onChanged` filters aliases by label, number, or purpose (case-insensitive substring match). Driven by a local `searchQueryProvider` or `StateProvider<String>`.
- **Filter button**: Opens bottom sheet with status options (All, Active, Paused, Expired). Selection stored in `StateProvider<AliasStatus?>`. `null` = All.
- **Alias cards**: Read from `filteredAliasProvider`. Tap navigates to detail as before.
- **QuickStatsRibbon**: Reads from `aliasStatsProvider` (total aliases, active count, total calls across all aliases).

### Alias Detail Screen

Bottom sheet menu actions (all pop the bottom sheet first):

- **Pause alias**: Sets status to `AliasStatus.paused`. Shows snackbar "Alias paused".
- **Resume alias**: Sets status to `AliasStatus.active`. Shows snackbar "Alias resumed".
- **Extend alias**: Shows dialog with 3 options (7 days / 30 days / 90 days). Updates `expiryDate` by adding selected days. Snackbar "Alias extended by {N} days".
- **Share number**: Copies alias number to clipboard via `Clipboard.setData()`. Snackbar "Number copied to clipboard".
- **Delete alias**: Shows `ConfirmationDialog` ("Delete Alias?", "This alias and all its data will be permanently deleted. This cannot be undone."). On confirm: removes alias from provider list, pops to alias manager, snackbar "Alias deleted".

### Call Logs Screen

- **Filter pills**: Read from `filteredCallLogProvider`. "All" shows everything, "Missed" filters `CallStatus.missed`, "Spam" filters `CallStatus.blocked`, "Saved" filters by `isSaved == true`.
- **Call log rows**: Tap navigates to call detail as before.

### Call Detail Screen

Bottom sheet menu actions:

- **Block number**: `ConfirmationDialog` ("Block this number?", "You won't receive calls from this number on any alias."). On confirm: marks all call logs from that number as `CallStatus.blocked`. Snackbar "Number blocked".
- **Save contact**: Shows dialog with name text field (pre-filled with `callerName`). On save: sets `isSaved = true` on matching call logs, updates `callerName` if changed. Snackbar "Contact saved".
- **Copy number**: Copies `callerNumber` to clipboard. Snackbar "Number copied".
- **Report spam**: `ConfirmationDialog` ("Report as spam?", "This number will be flagged and blocked."). On confirm: marks as blocked. Snackbar "Number reported as spam".
- **Call Back button**: Shows snackbar "Calling {callerName}..." (simulated, no actual call).

### Notifications Screen

- **Mark all read button**: Sets `isRead = true` on all notifications. Button disables when all are already read.
- **Tap notification**: Sets `isRead = true` on that notification. Blue dot disappears.
- **Tab filters**: "All" shows everything, "Activity" shows `call`/`missedCall`/`block` types, "Alerts" shows `alias`/`security`/`system` types.
- **Bell badge** (on alias manager & call logs top bar): Reads `unreadNotificationCountProvider`. Shows count or hides when 0.

### User Profile Screen

- **Edit button**: Toggles profile into edit mode (same screen). Name and email fields become editable `AppTextField` widgets. Save button replaces Edit. Cancel button to discard.
- **Save**: Updates `userProfileProvider` with new name/email. Snackbar "Profile updated". Exits edit mode.
- **Personal Info row**: Same as edit button -- toggles edit mode.
- **KYC Verification row**: Shows snackbar "Identity verified via DigiLocker".
- **Notification toggle**: Reads/writes a `notificationsEnabled` field on `UserProfile`. Toggle updates provider state.
- **Call Settings row**: Shows dialog with two toggles: "Call Forwarding" and "Voicemail" (local state, snackbar on close).
- **Privacy & Security row**: Shows dialog with info text about data handling + "Clear Call History" button (clears call log provider, snackbar).
- **About row**: Shows `showAboutDialog()` with app name "Ciphering", version "1.0.0", brief description.
- **Sign Out button**: `ConfirmationDialog` ("Sign Out?", "You'll need to verify your number again to sign back in."). On confirm: resets all providers to initial state, navigates to login screen (`context.go('/')`), clears navigation stack.

### Create Alias Flow

- **Confirmation screen**: Generates a random alias number from a pool of mock numbers. Purpose comes from the selected purpose in the flow. Plan comes from selected plan.
- **"Go to Alias Manager" button**: Adds the new alias to `aliasProvider` (with generated number, selected purpose, selected plan, status: active, today's creation date, expiry 30 days out for free / 365 days for premium). Then navigates to `/home/alias`.

### Onboarding Flow

- **Basic Details form validation**: Name field required (shows "Name is required" error on empty submit). Email field validates format with regex (shows "Enter a valid email" on invalid). Continue button only enables when both valid.
- **Photo upload tap**: Shows snackbar "Camera not available in demo mode".
- **Terms & Privacy links**: Show `showDialog` with placeholder text "Terms of Service" / "Privacy Policy" and a Close button.

## UI Feedback Patterns

| Action Type | Feedback |
|---|---|
| Non-destructive success | `SnackBar` with message, 2s duration |
| Destructive action | `ConfirmationDialog` before executing, then `SnackBar` |
| Data entry | `AlertDialog` with input fields |
| Info display | `showDialog` or `showAboutDialog` |
| State toggle | Immediate UI update (no snackbar needed) |

## Files

### New (5)
- `lib/providers/alias_provider.dart`
- `lib/providers/call_log_provider.dart`
- `lib/providers/notification_provider.dart`
- `lib/providers/user_profile_provider.dart`
- `lib/widgets/confirmation_dialog.dart`

### Modified (~12)
- `lib/data/mock_data.dart` -- copyWith methods, new fields
- `lib/screens/alias_manager_screen.dart` -- search, filter, provider reads
- `lib/screens/alias_detail_screen.dart` -- bottom sheet action handlers
- `lib/screens/call_logs_screen.dart` -- provider reads, filter wiring
- `lib/screens/call_detail_screen.dart` -- bottom sheet action handlers
- `lib/screens/notifications_screen.dart` -- mark read, tap-to-read, tab filters
- `lib/screens/user_profile_screen.dart` -- edit mode, sign out, settings dialogs
- `lib/screens/alias_confirmation_screen.dart` -- add alias to provider
- `lib/screens/basic_details_screen.dart` -- form validation
- `lib/screens/login_screen.dart` -- terms/privacy dialogs
- `lib/widgets/bottom_nav_bar.dart` -- notification badge from provider (if applicable)
- `lib/main.dart` -- verify ProviderScope wraps app
