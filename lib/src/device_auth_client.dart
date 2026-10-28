import 'credentials.dart';
import 'exception.dart';

enum DevicePlatform { android, ios }

class DeviceAuthClient {
  final PlatformCredentials credentials;

  DeviceAuthClient._(this.credentials) {
    credentials.validate();
  }

  factory DeviceAuthClient({
    required DevicePlatform platform,
    required String accessToken,
    required String ipAddress,
    // Android
    String? packageName,
    String? sha256,
   required String secretId,

    String? bundleId,
    String? teamId, // optional
  }) {
    switch (platform) {
      case DevicePlatform.android:
        if (packageName == null || sha256 == null) {
          throw const DeviceAuthException(
              'Android requires packageName, sha256 and secretId');
        }
        return DeviceAuthClient._(AndroidCredentials(
          accessToken: accessToken,
          ipAddress: ipAddress,
          packageName: packageName,
         
         secretKey: secretId, sha256FingerPrint: sha256,
        ));

      case DevicePlatform.ios:
        if (bundleId == null) {
          throw const DeviceAuthException('iOS requires bundleId');
        }
        return DeviceAuthClient._(IOSCredentials(
          accessToken: accessToken,
          ipAddress: ipAddress,
          bundleId: bundleId,
          teamId: teamId, secretKey: secretId,
        ));
    }
  }


  factory DeviceAuthClient.fromMap(Map<String, dynamic> map) {
    final platform = switch (map['platform']) {
      'android' => DevicePlatform.android,
      'ios' => DevicePlatform.ios,
      _ => throw const DeviceAuthException('platform must be "android" or "ios"'),
    };
    return DeviceAuthClient(
      platform: platform,
      accessToken: map['accessToken'] ?? '',
      ipAddress: map['ipAddress'] ?? '',
      packageName: map['packageName'],
      sha256: map['sha256'],
      secretId: map['secretId'],
      bundleId: map['bundleId'],
      teamId: map['teamId'],
    );
  }

  Map<String, dynamic> buildPayload() => credentials.toMap();
}