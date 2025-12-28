# Stripe Checkout Implementation

This document describes the implementation of Stripe Checkout for the LadyMeetups app.

## Overview

The new implementation replaces the previous Apple Pay/Google Pay flow with a Stripe Checkout session that opens in a WebView within the app. This provides a more consistent and reliable payment experience.

## Key Features

1. **WebView Integration**: The checkout page is displayed within the app using a WebView
2. **Deep Link Handling**: Success and cancel URLs redirect back to the app
3. **Real-time Status Updates**: Webhook handles payment status updates
4. **Error Handling**: Comprehensive error handling for network issues and payment failures

## Implementation Details

### 1. Stripe Service (`lib/shared/services/stripe.dart`)

- `createCheckoutSession()`: Creates a Stripe checkout session with success/cancel URLs
- `openCheckoutUrl()`: Opens checkout URL in external browser (fallback)

### 2. Payment Controller (`lib/features/booking/controllers/payment_controller.dart`)

- `createBooking()`: Creates booking and navigates to checkout screen
- `handlePaymentRedirect()`: Handles deep link redirects from Stripe
- `checkPaymentStatus()`: Checks payment status for a booking

### 3. Checkout Screen (`lib/features/booking/screens/stripe_checkout_screen.dart`)

- WebView-based checkout interface
- Loading and error states
- Deep link navigation handling
- Confirmation dialog for closing

### 4. Cloud Functions

#### Checkout Session Creation (`webhook/create_checkout_session.py`)
- Creates Stripe checkout sessions
- Handles metadata for event and user tracking
- Returns checkout URL

#### Webhook Handler (`webhook/index.py`)
- `handle_checkout_session_completed()`: Updates booking status to 'paid'
- `handle_checkout_session_expired()`: Updates booking status to 'failed'

### 5. Deep Link Configuration

#### Android (`android/app/src/main/AndroidManifest.xml`)
```xml
<intent-filter>
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.DEFAULT" />
    <category android:name="android.intent.category.BROWSABLE" />
    <data android:scheme="ladymeetups" />
</intent-filter>
```

#### iOS (`ios/Runner/Info.plist`)
```xml
<dict>
    <key>CFBundleTypeRole</key>
    <string>Editor</string>
    <key>CFBundleURLSchemes</key>
    <array>
        <string>ladymeetups</string>
    </array>
</dict>
```

## Flow Diagram

```
User initiates booking
    ↓
Create booking with 'pending' status
    ↓
Create Stripe checkout session
    ↓
Open WebView with checkout URL
    ↓
User completes payment on Stripe
    ↓
Stripe redirects to success/cancel URL
    ↓
Deep link handled by app
    ↓
Webhook updates booking status
    ↓
Show success/failure UI
```

## URL Schemes

- **Success**: `ladymeetups://payment/success`
- **Cancel**: `ladymeetups://payment/cancel`

## Testing

1. **Test Mode**: Uses Stripe test keys and test mode
2. **Live Mode**: Uses Stripe live keys and production mode
3. **Test Cards**: Use Stripe test card numbers for testing

## Error Handling

- Network connectivity issues
- Payment method failures
- Session expiration
- User cancellation
- WebView loading errors

## Security Considerations

- All sensitive data handled by Stripe
- No payment data stored in app
- Webhook signature verification
- HTTPS for all API calls

## Dependencies

- `webview_flutter`: For displaying checkout page
- `url_launcher`: For fallback external browser
- `flutter_stripe`: For Stripe integration
- `cloud_functions`: For server-side processing

## Deployment

1. Deploy cloud functions to Firebase
2. Configure webhook endpoints in Stripe dashboard
3. Update environment variables for live mode
4. Test with real payment methods

## Monitoring

- Webhook event logging
- Payment success/failure rates
- User journey analytics
- Error tracking and reporting 