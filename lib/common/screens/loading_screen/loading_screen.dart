import 'package:flutter/material.dart';
import 'package:stt_and_translation_app/common/widgets/loading/loading.dart';
import 'package:stt_and_translation_app/utils/helpers/helper_functions.dart';

class LoadingScreen extends StatelessWidget {

  final double? loadingSize;

  const LoadingScreen({super.key, this.loadingSize});

  @override
  Widget build(BuildContext context) {
    THelperFunctions.setSystemUIOverlay(context);

    return Scaffold(body: Center(child: TLoading(size: loadingSize)));
  }
}
