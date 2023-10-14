import 'dart:ui';

import 'package:dico/app/animations/fade_widget.dart';
import 'package:dico/app/providers/search_provider.dart';
import 'package:dico/app/models/result_model.dart';
import 'package:dico/app/utils/clipper.dart';
import 'package:dico/app/utils/colors.dart';
import 'package:dico/app/widgets/custom_animated_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';

class InfoPage extends ConsumerWidget {
  final ResultModel model;
  const InfoPage(this.model, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(searchProvider);
    final theme = Theme.of(context);
    return WillPopScope(
      onWillPop: () async {
        provider.setSpeed(0.2);
        return true;
      },
      child: Stack(
        children: [
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: const SizedBox.expand(),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: MediaQuery.sizeOf(context).height / 2,
            child: FadeWidget(
              child: ClipPath(
                clipper: OvalClipper(true),
                child: Material(
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Material(
                              color: Colors.orange,
                              elevation: 0,
                              clipBehavior: Clip.antiAlias,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12)),
                              ),
                              child: IconButton(
                                onPressed: () => Navigator.of(context).pop(),
                                icon: const Icon(FeatherIcons.x, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              children: [
                                Expanded(
                                  child: SingleChildScrollView(
                                    padding: const EdgeInsets.all(8),
                                    child: Column(
                                      children: [
                                        Text(
                                          model.word,
                                          style: theme.textTheme.titleLarge,
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          model.mean,
                                          style: theme.textTheme.titleMedium,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'سرعت خواندن : ' + provider.speedRate.toStringAsFixed(1),
                                      style: theme.textTheme.titleMedium!.copyWith(),
                                    ),
                                    Expanded(
                                      child: Directionality(
                                        textDirection: TextDirection.ltr,
                                        child: IgnorePointer(
                                          ignoring: provider.speacking,
                                          child: FutureBuilder<SpeechRateValidRange>(
                                            future: provider.tts.getSpeechRateValidRange,
                                            builder: (context, snapshot) {
                                              SpeechRateValidRange? range = snapshot.data;
                                              if (range != null) {
                                                return Slider(
                                                  min: range.min,
                                                  max: range.max,
                                                  label: provider.speedRate.toStringAsFixed(1),
                                                  value: provider.speedRate,
                                                  inactiveColor: AppColors.color1.withOpacity(0.2),
                                                  activeColor: AppColors.color1,
                                                  divisions: 10,
                                                  onChanged: (value) => provider.setSpeed(value),
                                                );
                                              }
                                              return const SizedBox();
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                FilledButton.icon(
                                  style: FilledButton.styleFrom(
                                    backgroundColor: AppColors.primaryColor,
                                  ),
                                  onPressed: () => provider.speak(model.word),
                                  icon: CustomAnimatedSwitcher(
                                    firstChild: const Icon(
                                      FeatherIcons.playCircle,
                                      color: Colors.white,
                                    ),
                                    secondChild: const Icon(
                                      FeatherIcons.pauseCircle,
                                      color: Colors.white,
                                    ),
                                    toggle: !provider.speacking,
                                  ),
                                  label: Text(
                                    'پخش',
                                    style: theme.textTheme.titleMedium!.copyWith(color: Colors.white),
                                  ),
                                ),
                                const SizedBox(height: 16),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
