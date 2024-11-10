import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:stt_and_translation_app/common/widgets/alt_elevated_button/alt_elevated_button.dart';
import 'package:stt_and_translation_app/common/widgets/outlined_button/outlined_button.dart';
import 'package:stt_and_translation_app/utils/constants/colors.dart';
import '../../../../common/screens/loading_screen/loading_screen.dart';
import '../../../../common/widgets/elevated_button/elevated_button.dart';
import '../../../../utils/constants/errors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../controllers/home_controller/home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final textTheme = Theme.of(context).textTheme;
    final controller = Get.put(HomeController());
    THelperFunctions.setSystemUIOverlay(context);

    return Obx(
      () => controller.isLoading.value
          ?
      /// Loading Screen
      const LoadingScreen()
          :
      controller.isError.value
          ?
      /// Error Screen
      Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(TSizes.md),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(TErrors.unknownError.tr, style: textTheme.headlineLarge),

                const Gap(TSizes.spaceBtwSections),

                TElevatedButton(onPress: controller.fetchAndAssign, text: TTexts.tryAgain.tr),
              ],
            ),
          ),
        ),
      )
          :
      /// Main Screen
      Scaffold(
        appBar: AppBar(title: Text(TTexts.appName.tr, style: textTheme.titleLarge)),

        body: SingleChildScrollView(
          padding: const EdgeInsets.all(TSizes.md),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: controller.recognizedText.value.isNotEmpty,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(TTexts.recognizedText.tr, style: textTheme.headlineMedium),

                      const Gap(TSizes.md),

                      Text(controller.recognizedText.value, style: textTheme.titleLarge),

                      const Gap(TSizes.spaceBtwItems),
                    ],
                  ),
                ),

                Visibility(
                  visible: controller.recognizedText.value.isNotEmpty && controller.isListening.value == false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(TSizes.spaceBtwItems),

                      TOutlinedButton(onPress: controller.clearRecognizedText, text: TTexts.clearText.tr),

                      const Gap(TSizes.spaceBtwSections),

                      Row(
                        children: [
                          Text('Translate to:', style: textTheme.titleMedium),

                          const Gap(TSizes.spaceBtwSections),

                          Expanded(
                            child: DropdownButton<String>(
                              dropdownColor: TColors.primary,
                              iconEnabledColor: isDark ? TColors.darkIcon : TColors.lightIcon,
                              value: controller.selectedLanguage.value,
                              items: controller.languages.entries.map((entry) => DropdownMenuItem(value: entry.value, child: Text(entry.key))).toList(),
                              onChanged: (value) => controller.onLanguageChange(value),
                            ),
                          ),
                        ],
                      ),

                      // Translate button
                      const Gap(TSizes.spaceBtwItems),

                      TAltElevatedButton(loading: controller.translateLoading, onPress: controller.translateRecognizedText, text: TTexts.translate.tr),

                      Visibility(
                        visible: controller.translatedText.value.isNotEmpty,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Gap(TSizes.spaceBtwSections),

                            Text(TTexts.translatedText.tr, style: textTheme.headlineMedium),

                            const Gap(TSizes.md),

                            Text(controller.translatedText.value, style: textTheme.titleMedium),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(TSizes.md),
          child: TElevatedButton(
            onPress: controller.handleListening,
            text: controller.isListening.value ? TTexts.stopListening.tr : TTexts.startListening.tr,
          ),
        ),
      ),
    );
  }
}
