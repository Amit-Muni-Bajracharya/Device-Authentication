import 'validators.dart';


sealed class PlatformCredentials {
    final String accessToken;
    final String ipAddress;
    final String secretKey;

    const PlatformCredentials({
        required this.accessToken,
        required this.ipAddress,
        required this.secretKey
    });

    void validate(){
        requireNonEmpty(accessToken, 'AccessToken');
        requireNonEmpty(secretKey, 'SecretKey');
        requireValidIp(ipAddress);
    }
    Map<String , dynamic> toMap();
}


class AndroidCredentials extends PlatformCredentials{
 final String packageName;
 final String sha256FingerPrint;


 const AndroidCredentials({
    required super.accessToken,
    required super.secretKey,
    required super.ipAddress,
    required this.packageName,
    required this.sha256FingerPrint,


 });

    @override
    void validate(){
    super.validate();
    requireNonEmpty(packageName, 'Pacakge name');

    normalizeSha256(sha256FingerPrint);
    }

    @override
    Map<String, dynamic> toMap() =>{
     'platform' : 'android',
     'accessToken' : accessToken,
     'ipAddress' : ipAddress.trim(),
     'secretId' : secretKey,
    'packageName': packageName.trim(),
     'sha256FingerPrint': normalizeSha256(sha256FingerPrint),
    };
}


class IOSCredentials extends PlatformCredentials{
    final String bundleId;
    final String? teamId;
    const IOSCredentials({
        required super.accessToken,
        required super.ipAddress,
        required super.secretKey,
        required this.bundleId,
        this.teamId
    });

    @override
    void validate(){
        super.validate();
        requireNonEmpty(bundleId, 'bundleId');
    }

    @override
    Map<String, dynamic> toMap() =>{
        'platform' : 'ios',
        'accessToken' : accessToken ,
        'ipAddress' : ipAddress.trim(),
        'secretId' : secretKey,
        'bundleId' : bundleId.trim(),
        if(teamId != null && teamId!.trim().isNotEmpty) 'teamId': teamId!.trim(),
    };
}
    
