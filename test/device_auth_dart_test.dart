import 'package:device_auth_dart/device_auth_dart.dart';
import 'package:test/test.dart';

void main() {
  group('iOS', () {
    test('only needs bundleId, accessToken, ipAddress and secretId', () {
      final c = DeviceAuthClient(
        platform: DevicePlatform.ios,
        accessToken: 't',
        ipAddress: '10.0.0.1',
        bundleId: 'com.example.app', secretId: 's',
      );

      final payload = c.buildPayload();
      expect(payload['platform'], 'ios');
      expect(payload['secretId'], 's');
      expect(payload.containsKey('teamId'), false);
    });

    test('includes teamId when provided', () {
      final c = DeviceAuthClient(
        platform: DevicePlatform.ios,
        accessToken: 't',
        ipAddress: '10.0.0.1',
        bundleId: 'com.example.app',
        teamId: 'ABCDE12345', secretId: 's',
      );

      expect(c.buildPayload()['teamId'], 'ABCDE12345');
    });

    test('fails without bundleId', () {
      expect(
        () => DeviceAuthClient(
          platform: DevicePlatform.ios,
          accessToken: 't',
          ipAddress: '10.0.0.1', secretId: 's',
        ),
        throwsA(isA<DeviceAuthException>()),
      );
    });

    test('fails without secretId', () {
      expect(
        () => DeviceAuthClient(
          platform: DevicePlatform.ios,
          accessToken: 't',
          ipAddress: '10.0.0.1',
          bundleId: 'com.example.app', secretId: '',
        ),
        throwsA(isA<DeviceAuthException>()),
      );
    });
  });

  group('Android', () {
    test('succeeds with all required fields', () {
      final c = DeviceAuthClient(
        platform: DevicePlatform.android,
        accessToken: 't',
        ipAddress: '10.0.0.1',
        packageName: 'com.example.app',
        sha256: 'A' * 64,
        secretId: '12312',
      );

      final payload = c.buildPayload();
      expect(payload['platform'], 'android');
      expect(payload['secretId'], '12312');
    });

    test('fails without secretId', () {
      expect(
        () => DeviceAuthClient(
          platform: DevicePlatform.android,
          accessToken: 't',
          ipAddress: '10.0.0.1',
          packageName: 'com.example.app',
          sha256: 'A' * 64, secretId: '',
        ),
        throwsA(isA<DeviceAuthException>()),
      );
    });

    test('fails with an invalid sha256', () {
      expect(
        () => DeviceAuthClient(
          platform: DevicePlatform.android,
          accessToken: 't',
          ipAddress: '10.0.0.1',
          packageName: 'com.example.app',
          sha256: 'not-a-hash',
          secretId: '12312',
        ),
        throwsA(isA<DeviceAuthException>()),
      );
    });
  });

  test('fails with an invalid IP address', () {
    expect(
      () => DeviceAuthClient(
        platform: DevicePlatform.ios,
        accessToken: 't',
        ipAddress: 'abc',
        bundleId: 'com.example.app', secretId: 's',
      ),
      throwsA(isA<DeviceAuthException>()),
    );
  });
}
