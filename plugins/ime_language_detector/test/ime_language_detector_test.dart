import 'package:flutter_test/flutter_test.dart';
import 'package:ime_language_detector/ime_language_detector.dart';
import 'package:ime_language_detector/ime_language_detector_method_channel.dart';
import 'package:ime_language_detector/ime_language_detector_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockImeLanguageDetectorPlatform
    with MockPlatformInterfaceMixin
    implements ImeLanguageDetectorPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<List<String>?> getImeLanguages() => Future.value(["en", "fr"]);
}

void main() {
  final ImeLanguageDetectorPlatform initialPlatform =
      ImeLanguageDetectorPlatform.instance;

  test('$MethodChannelImeLanguageDetector is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelImeLanguageDetector>());
  });

  test('getPlatformVersion', () async {
    ImeLanguageDetector imeLanguageDetectorPlugin = ImeLanguageDetector();
    MockImeLanguageDetectorPlatform fakePlatform =
        MockImeLanguageDetectorPlatform();
    ImeLanguageDetectorPlatform.instance = fakePlatform;

    expect(await imeLanguageDetectorPlugin.getPlatformVersion(), '42');
  });
}
