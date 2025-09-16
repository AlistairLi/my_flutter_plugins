import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'facebook_sdk_method_channel.dart';

abstract class FacebookSdkPlatformAPI extends PlatformInterface {
  /// Constructs a FacebookSdkPlatformAPI.
  FacebookSdkPlatformAPI() : super(token: _token);

  static final Object _token = Object();

  static FacebookSdkPlatformAPI _instance = FacebookSdkMethodChannel();

  /// The default instance of [FacebookSdkPlatformAPI] to use.
  ///
  /// Defaults to [FacebookSdkMethodChannel].
  static FacebookSdkPlatformAPI get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FacebookSdkPlatformAPI] when
  /// they register themselves.
  static set instance(FacebookSdkPlatformAPI instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> sdkInit(
      {required String applicationId, required String clientToken}) async {
    throw UnimplementedError('sdkInit() has not been implemented.');
  }

  Future<String?> logEvent(
      {required String eventName, Map<String, dynamic>? parameters}) async {
    throw UnimplementedError('logEvent() has not been implemented.');
  }

  Future<String?> logPurchase(
      {required double purchaseAmount,
      required String currency,
      Map<String, dynamic>? parameters}) async {
    throw UnimplementedError('logPurchase() has not been implemented.');
  }
}
