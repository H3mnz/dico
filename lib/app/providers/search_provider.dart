import 'dart:developer';

import 'package:dico/app/database/database_helper.dart';
import 'package:dico/app/models/result_model.dart';
import 'package:dico/app/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';

final searchProvider = ChangeNotifierProvider<SearchNotifier>((ref) {
  return SearchNotifier()..init();
});

class SearchNotifier extends ChangeNotifier {
  //
  TextEditingController textEditingController = TextEditingController();
  List<ResultModel> results = <ResultModel>[];
  bool isEmpty = true;
  double speedRate = 0.2;
  late FlutterTts tts;
  TtsState ttsState = TtsState.stopped;
  DatabaseHelper database = DatabaseHelper.instance;

  bool get speacking => ttsState == TtsState.playing;

  void searchKeyword() async {
    if (textEditingController.text.isNotEmpty) {
      log(textEditingController.text);
      try {
        List<ResultModel> data = await database.search(textEditingController.text);
        results.clear();
        results.addAll(data);
        notifyListeners();
      } catch (e) {
        log(e.toString());
        results.clear();
        notifyListeners();
      }
    } else {
      clear();
    }
  }

  void clear() {
    textEditingController.clear();
    results.clear();
    notifyListeners();
  }

  void initTts() async {
    tts = FlutterTts();
    await tts.getDefaultEngine;
  }

  void setSpeed(double value) {
    speedRate = value;
    notifyListeners();
  }

  void speak(String text) async {
    if (text.isNotEmpty) {
      await tts.stop();
      await tts.setVolume(1);
      await tts.setSpeechRate(speedRate);
      await tts.setPitch(1.2);
      await tts.awaitSpeakCompletion(true);
      ttsState = TtsState.playing;
      notifyListeners();
      await tts.speak(text);
      ttsState = TtsState.stopped;
      notifyListeners();
    }
  }

  void init() {
    initTts();
    textEditingController.addListener(() {
      isEmpty = textEditingController.text.isEmpty;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    tts.stop();
    textEditingController.removeListener(() {});
    textEditingController.dispose();
    super.dispose();
  }
}
