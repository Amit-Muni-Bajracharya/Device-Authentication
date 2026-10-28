class DeviceAuthException implements Exception{
    final String message;
    const DeviceAuthException(this.message);

    @override
    String toString() => 'DeviceAuthException $message';
}