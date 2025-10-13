import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'ime_language_detector_platform_interface.dart';

/// An implementation of [ImeLanguageDetectorPlatform] that uses method channels.
class MethodChannelImeLanguageDetector extends ImeLanguageDetectorPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('ime_language_detector');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<List<String>?> getImeLanguages() async {
    final languages =
        await methodChannel.invokeListMethod<String>('getImeLanguages');
    return languages;
  }
}
