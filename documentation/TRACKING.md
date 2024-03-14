# Tracking Events

To track an event, you must first construct the `AppFit` client. This configures all of the underlying event handeling and caching system to help track events directly to AppFit.

## Configuration & Tracking

```dart
final appFit = AppFit(configuration: configuration);
```

Once you have the client constructed, tracking an event is as simple as calling `trackEvent`

A full example can be found below.

```dart
import 'package:appfit_flutter_sdk/appfit_flutter_sdk.dart';

void main() {
    // Create the AppFitConfiguration
    final configuration = AppFitConfiguration(
        apiKey: 'YOUR_API_KEY',
    );

    // Create the AppFit Client
    final appFit = AppFit(configuration: configuration);

    // Use the client to track events
    appFit.trackEvent('event_name', properties: {'key': 'value'});
}
```

## Identifying Users

The AppFit SDK includes an `identify` call, that you can use to identify users in your analytic events.
This method supports any String-based identifier.

```dart
appfit.identifyUser("<id>");
```

Setting this to null, will remove all events going forward from including the userId.

```dart
appfit.identifyUser(null);
```
