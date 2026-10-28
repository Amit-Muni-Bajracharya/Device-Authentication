# device_auth_dart

Validates and builds device-auth payloads for Android and iOS clients.

## Usage

```dart
import 'package:device_auth_dart/device_auth_dart.dart';

final client = DeviceAuthClient(
  platform: DevicePlatform.android,
  accessToken: 'access-token',
  ipAddress: '10.0.0.1',
  packageName: 'com.example.app',
  sha256: 'AA...64 hex chars',
  secretId: 'secret-id',
);

final payload = client.buildPayload();
```

For iOS, pass `bundleId` (and optionally `teamId`) instead of `packageName`/`sha256`.

`DeviceAuthClient` throws a `DeviceAuthException` if required fields are missing,
the IP address is invalid, or the SHA-256 fingerprint isn't 64 hex characters.

See [example/device_auth_dart_example.dart](example/device_auth_dart_example.dart) for a full example.
