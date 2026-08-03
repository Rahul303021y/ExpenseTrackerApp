import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfoHelper{
  static Future<Map<String, String>> getDeviceInfo() async{
    final deviceInfo = DeviceInfoPlugin();
    if(Platform.isAndroid){
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      return {
        'deviceId':androidDeviceInfo.id,
        'deviceName':'${androidDeviceInfo.manufacturer} ${androidDeviceInfo.name}'
      };
    }

    if(Platform.isIOS){
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      return{
        'deviceId':iosDeviceInfo.identifierForVendor??'',
        'deviceName': iosDeviceInfo.name
      };
    }

    return {
      'deviceId': '',
      'deviceName': '',
    };
  }
}