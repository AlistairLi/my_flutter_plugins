import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'ime_language_detector_method_channel.dart';

abstract class ImeLanguageDetectorPlatform extends PlatformInterface {
  /// Constructs a ImeLanguageDetectorPlatform.
  ImeLanguageDetectorPlatform() : super(token: _token);

  static final Object _token = Object();

  static ImeLanguageDetectorPlatform _instance =
      MethodChannelImeLanguageDetector();

  /// The default instance of [ImeLanguageDetectorPlatform] to use.
  ///
  /// Defaults to [MethodChannelImeLanguageDetector].
  static ImeLanguageDetectorPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ImeLanguageDetectorPlatform] when
  /// they register themselves.
  static set instance(ImeLanguageDetectorPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<List<String>?> getImeLanguages() {
    throw UnimplementedError('getImeLanguages() has not been implemented.');
  }
}
