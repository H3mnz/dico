import 'package:dico/app/providers/search_provider.dart';
import 'package:dico/app/utils/clipper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/colors.dart';
import 'custom_animated_switcher.dart';

class SearchTextField extends ConsumerWidget {
  const SearchTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(searchProvider);
    return ClipPath(
      clipper: OvalClipper(),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: kToolbarHeight + 16,
              padding: const EdgeInsets.symmetric(horizontal: 0),
              color: Colors.white,
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: CupertinoTextField(
                            // focusNode: FocusNode()..canRequestFocus = false,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            controller: provider.textEditingController,
                            onSubmitted: (keyword) => provider.searchKeyword(),
                            onChanged: (keyword) => provider.searchKeyword(),
                            padding: const EdgeInsets.all(8),
                            placeholder: 'لغت خود را وارد نمایید',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          SizedBox(
            height: kToolbarHeight + 16,
            width: kToolbarHeight,
            child: ClipPath(
              clipper: OvalClipper2(),
              child: Material(
                elevation: 0,
                color: AppColors.color1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                child: InkWell(
                  onTap: () {
                    if (provider.isEmpty) {
                      provider.searchKeyword();
                    } else {
                      provider.clear();
                    }
                  },
                  child: Column(
                    children: [
                      Expanded(
                        child: CustomAnimatedSwitcher(
                          firstChild: const Icon(FeatherIcons.search, color: Colors.white, key: ValueKey('search')),
                          secondChild: const Icon(FeatherIcons.x, color: Colors.white, key: ValueKey('clear')),
                          toggle: provider.isEmpty,
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
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
