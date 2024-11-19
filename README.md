
# Speech-to-Text & Translation App 🎙️🌐

This Flutter application allows users to convert their speech into text and translate it into different languages. Using the `speech_to_text` package for speech recognition and `translator` for translation, the app provides a simple interface to convert audio input into text and translate it to a selected language.

## Features 📱

-   **Speech-to-Text Conversion**: Converts microphone input into text using the `speech_to_text` package.
-   **Language Translation**: Translates the recognized text into multiple languages via Google Translator.
-   **Language Selection**: Allows users to choose a target language for translation (default: German).
-   **Error Handling**: Displays error messages and provides options to retry if issues arise during speech recognition or translation.
-   **Simple UI**: User-friendly interface to start/stop listening, view recognized text, select languages, and display translations.


## Installation 📲

1. Clone this repository:
    ```bash
    git clone https://github.com/talhaiqbal01/STT-and-Translation-App-Flutter-.git
    ```
2. Navigate into the project directory:
    ```bash
    cd weather_app
    ```
3. Install dependencies:
    ```bash
    flutter pub get
    ```
4. Run the app on an emulator or a connected device:
    ```bash
    flutter run
    ```
## Code Overview 🧩

-   **`HomeScreen`**: The main screen that displays recognized text, a language dropdown for translation, and a translate button. Users can start/stop listening and view translation results.
-   **`HomeController`**: Manages the speech-to-text and translation processes, handles language selection, error states, and updates the UI based on user actions.
-   **Language Dropdown**: Allows users to select a target language from a list of options (e.g., German, French, Spanish).
-   **Translate Button**: Initiates translation of the recognized text into the selected language.

## Dependencies 📦

-   **GetX**: For state management and dependency injection.
-   **speech_to_text**: Enables real-time speech-to-text conversion from microphone input.
-   **translator**: Integrates with Google Translate for language translation.