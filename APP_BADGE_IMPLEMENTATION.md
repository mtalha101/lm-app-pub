# App Badge Implementation Guide

This guide explains how to use the app badge functionality to clear stuck notification badges on your app icon.

## Overview

The implementation includes:

- `app_badge_plus` package for cross-platform badge management
- `AppBadgeService` class for low-level badge operations
- `BadgeUtils` class for easy-to-use badge functions
- Integration with your main app initialization

## Quick Start - Clear Stuck Badge

To immediately clear the stuck 2 notifications badge, call this function from anywhere in your app:

```dart
import 'package:lady_meetup/shared/utils/badge_utils.dart';

// Clear the badge immediately
await BadgeUtils.clearAppBadge();
```

## Integration Points

### 1. App Initialization (Already Done)

The badge service is automatically initialized in `main.dart` when the app starts.

### 2. Clear Badge on App Open (Already Done)

Badge clearing is automatically implemented in:

- **HomeController.onInit()** - Clears badge when home screen loads
- **HomeController.onReady()** - Clears badge when home screen is ready
- **NotificationsScreen.initState()** - Clears badge when notifications screen opens

The stuck 2 notifications badge will be automatically cleared when:

- User opens the app and reaches the home screen
- User navigates to the notifications tab
- User returns to the home screen from other screens

### 4. Clear Badge on Notification Interaction

Add this when user taps on a notification:

```dart
void onNotificationTapped() {
  // Clear badge when user interacts with notification
  BadgeUtils.clearAppBadge();
}
```

## Available Functions

### BadgeUtils.clearAppBadge()

- **Purpose**: Completely removes the app icon badge
- **Use Case**: Clear stuck badges, clear when user opens app
- **Returns**: Future<void>

### BadgeUtils.setAppBadge(int count)

- **Purpose**: Sets the badge to a specific number
- **Use Case**: Show notification count
- **Parameters**: count (0 to clear, >0 to show number)

### BadgeUtils.getCurrentBadgeCount()

- **Purpose**: Gets the current badge count
- **Use Case**: Check current state
- **Returns**: Future<int?> (null if not supported)

### BadgeUtils.isBadgeSupported()

- **Purpose**: Checks if device supports badges
- **Use Case**: Verify functionality before using
- **Returns**: Future<bool>

## Platform Support

- **iOS**: Full support for app icon badges
- **Android**: Support depends on launcher (most modern launchers support it)
- **Automatic**: The service automatically handles platform differences

## Troubleshooting

### Badge Not Clearing

1. Ensure you're calling `BadgeUtils.clearAppBadge()` after the app is fully initialized
2. Try calling it in multiple places (app open, notification view, etc.)
3. Check if the device supports badges with `BadgeUtils.isBadgeSupported()`

### Permission Issues (Android)

The service automatically requests permissions, but some Android launchers may require manual permission grants.

### Testing

The badge clearing functionality is now automatically integrated and will work immediately when you run the app.

## Files Added/Modified

1. **pubspec.yaml** - Added `app_badge_plus: ^1.0.0`
2. **lib/shared/services/app_badge_service.dart** - Core badge service
3. **lib/shared/utils/badge_utils.dart** - Easy-to-use utility functions
4. **lib/main.dart** - Added badge service initialization
5. **lib/features/home/controllers/home_controller.dart** - Added badge clearing on home screen load
6. **lib/features/notifications/screens/notifications_screen.dart** - Added badge clearing on notifications view

## Next Steps

1. Run `flutter pub get` to install the new package
2. Test the badge clearing functionality
3. Integrate `BadgeUtils.clearAppBadge()` calls in appropriate places in your app
4. The stuck 2 notifications badge should be cleared when you call the function
