import 'facebook_sdk_platform_api.dart';

class FacebookSDK {
  Future<String?> sdkInit(
      {required String applicationId, required String clientToken}) {
    return FacebookSdkPlatformAPI.instance
        .sdkInit(applicationId: applicationId, clientToken: clientToken);
  }

  Future<String?> logEvent(
      {required String eventName, Map<String, dynamic>? parameters}) {
    return FacebookSdkPlatformAPI.instance
        .logEvent(eventName: eventName, parameters: parameters);
  }

  Future<String?> logPurchase(
      {required double purchaseAmount, required String currency}) {
    return FacebookSdkPlatformAPI.instance
        .logPurchase(purchaseAmount: purchaseAmount, currency: currency);
  }
}
