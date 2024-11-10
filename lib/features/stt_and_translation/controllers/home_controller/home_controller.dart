/// Controller for [HomeScreen]

import 'package:get/get.dart';
import 'package:stt_and_translation_app/utils/constants/errors.dart';
import 'package:stt_and_translation_app/utils/device/device_utility.dart';
import 'package:stt_and_translation_app/utils/loaders/loaders.dart';
import 'package:translator/translator.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/logging/logger.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;


class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  /*------------------------------------Variables------------------------------------*/
  /// STT instance
  final speech = stt.SpeechToText();

  /// Google Translator instance
  final translator = GoogleTranslator();

  /// Bool values for loading and error
  var isLoading = false.obs;
  var isError = false.obs;
  var isListening = false.obs;
  var translateLoading = false.obs;

  /// Text values
  var recognizedText = ''.obs;
  var translatedText = ''.obs;
  var microphoneStatus = TMicrophoneStatus.stop.obs;

  /// Language options and selected language
  final languages = {
    'German': 'de',
    'French': 'fr',
    'Spanish': 'es',
    'Italian': 'it',
    'Japanese': 'ja',
  };
  var selectedLanguage = 'de'.obs;  // Default to German


  /*------------------------------------ On init and close ------------------------------------*/

  @override
  void onInit() {
    fetchAndAssign();
    super.onInit();
  }

  @override
  void onClose() {
    onScreenClose();
    super.onClose();
  }

  /*------------------------------------Functions------------------------------------*/

  /// Function to fetch and assign all values
  void fetchAndAssign() async {
    isLoading.value = true;
    try {

      await initSpeechRecognition(); // Initialize speech recognition

      isError.value = false;

    } catch (e) {
      isError.value = true;
      TLoggerHelper.error("Error during fetch and assign: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// Function to call on screen close
  void onScreenClose() async {
    await speech.stop();
  }

  /// Function to initiate speech recognition functionality
  Future<void> initSpeechRecognition() async {
    bool available = await speech.initialize(
      onStatus: (status) => microphoneStatus.value =
      status == 'listening' ? TMicrophoneStatus.listening : TMicrophoneStatus.stop,
      onError: (error) => TLoggerHelper.error("Speech recognition error: $error"),
    );
    if (available) {
      microphoneStatus.value = TMicrophoneStatus.stop;
    } else {
      TLoggerHelper.error("Speech recognition not available.");
    }
  }

  /// Function to start listening to user using microphone
  void startListening() async {
    isListening.value = true;
    recognizedText.value = ''; // Reset text before listening
    await speech.listen(onResult: (result) => recognizedText.value = result.recognizedWords);
    microphoneStatus.value = TMicrophoneStatus.listening;
  }

  /// Function to stop listening to user
  void stopListening() async {
    await speech.stop();
    isListening.value = false;
    microphoneStatus.value = TMicrophoneStatus.stop;
  }


  /// Function to handle listening
  void handleListening() async => isListening.value ? stopListening() : startListening();

  /// Function to clear recognized text
  void clearRecognizedText() {
    recognizedText.value = '';
    translatedText.value = '';
  }

  /// Function to translate recognized text to selected text
  void translateRecognizedText() async {
    final isConnected = await TDeviceUtils.hasInternetConnection();

    if (isConnected) {
      translateLoading.value = true;

      try {

        if (recognizedText.value.isNotEmpty) {
          final translation = await translator.translate(recognizedText.value, from: 'auto', to: selectedLanguage.value);

          translatedText.value = translation.text;
        }

      } catch (e) {
        TLoggerHelper.error('Error during translating recognized text - $e');
        TLoaders.showError(TErrors.translationError.tr);
      } finally {
        translateLoading.value = false;
      }
    } else {
      TLoaders.showError(TErrors.noConnection.tr);
    }
  }


  /// Function to call on selected language change
  void onLanguageChange(value) {
    if (value != null) {
      selectedLanguage.value = value;
    }
  }

}
