import 'package:flutter/services.dart';

import 'facebook_sdk_platform_api.dart';

class FacebookSdkMethodChannel extends FacebookSdkPlatformAPI {
  /// The method channel used to interact with the native platform.
  final methodChannel = const MethodChannel('PlatformFacebookPlugin');

  @override
  Future<String?> sdkInit(
      {required String applicationId, required String clientToken}) async {
    return methodChannel.invokeMethod<String>('sdkInit',
        {"applicationId": applicationId, "clientToken": clientToken});
  }

  @override
  Future<String?> logEvent(
      {required String eventName, Map<String, dynamic>? parameters}) async {
    return methodChannel.invokeMethod<String>(
        'event', {"eventName": eventName, "parameters": parameters});
  }

  @override
  Future<String?> logPurchase(
      {required double purchaseAmount,
      required String currency,
      Map<String, dynamic>? parameters}) async {
    return methodChannel.invokeMethod<String>('purchase', {
      "purchaseAmount": purchaseAmount,
      "currency": currency,
      "parameters": parameters
    });
  }
}
