import 'package:get/get_navigation/src/root/internacionalization.dart';

class LocalStrings extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {

        /// English texts

        'en_US': {

          /// TEXTS

          // -- GLOBAL Texts

          'and': 'and',
          'skip': 'Skip',
          'done': 'Done',
          'submit': 'Submit',
          'appName': 'STT and Translation App',
          'cancel': 'Cancel',
          'tContinue': 'Continue',
          'verify': 'Verify',
          'verified': 'Verified',
          'tryAgain': 'Try Again',
          'edit': 'Edit',


          // --  Microphone Texts
          'startListening': 'Start Listening',
          'stopListening': 'Stop Listening',
          'clearText': 'Clear Text',
          'recognizedText': 'Recognized Text',
          'translate': 'Translate',
          'translateTo': 'Translate to',
          'translatedText': 'Translated Text',


          // --  Messages Texts

          'success': 'Success',
          'error': 'Error',
          'info': 'Info',


          /// ERRORS

          // -- GLOBAL Error Texts

          'unknownError': 'An unknown error occurred! Try again later.',
          'noConnection': 'Your internet connection is currently not available. Please check or try again.',

          // -- Translation Error Texts

          'translationError': 'An error occurred while translating text. Try again later.',

          /// SUCCESSES

        },
        'fr_FR': {},
        'ar_AR': {},
      };
}
