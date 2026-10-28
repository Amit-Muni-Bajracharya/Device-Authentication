import 'exception.dart';


void requireNonEmpty(String value , String fieldName){
    if(value.trim().isEmpty){
        throw DeviceAuthException('$fieldName must not be empty.');
    }
}
 
void requireValidIp(String value){
    requireNonEmpty(value, 'ipAddress');

    try{
        Uri.parseIPv4Address(value.trim());
    }on FormatException{
        try{
            Uri.parseIPv6Address(value.trim());
        } on FormatException{
            throw DeviceAuthException('ipAddress "$value" is not a valid IP');
        }
    }
}



String normalizeSha256(String value) {
  final hex = value.replaceAll(':', '').trim().toUpperCase();
  if (!RegExp(r'^[0-9A-F]{64}$').hasMatch(hex)) {
    throw const DeviceAuthException('sha256 must be 64 hex characters');
  }
  return RegExp(r'.{2}').allMatches(hex).map((m) => m.group(0)).join(':');
}