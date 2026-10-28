import 'package:device_auth_dart/device_auth_dart.dart';

void main() {
  final client = DeviceAuthClient(
    platform: DevicePlatform.android,
    accessToken: 'example-access-token',
    ipAddress: '10.0.0.1',
    packageName: 'com.example.app',
    sha256: 'A' * 64,
    secretId: 'example-secret-id',
  );

  print(client.buildPayload());
}
