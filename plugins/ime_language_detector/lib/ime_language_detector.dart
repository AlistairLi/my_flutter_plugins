import 'ime_language_detector_platform_interface.dart';

class ImeLanguageDetector {
  Future<String?> getPlatformVersion() {
    return ImeLanguageDetectorPlatform.instance.getPlatformVersion();
  }

  Future<List<String>?> getImeLanguages() {
    return ImeLanguageDetectorPlatform.instance.getImeLanguages();
  }
}
