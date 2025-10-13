import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ime_language_detector/ime_language_detector.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _imeLanguages = 'Unknown';
  final _imeLanguageDetectorPlugin = ImeLanguageDetector();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String imeLanguages;
    try {
      imeLanguages =
          (await _imeLanguageDetectorPlugin.getImeLanguages())?.join(',') ?? '';
    } on PlatformException {
      imeLanguages = 'Failed to get ime languages.';
    }
    if (!mounted) return;

    setState(() {
      _imeLanguages = imeLanguages;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_imeLanguages\n'),
        ),
      ),
    );
  }
}
