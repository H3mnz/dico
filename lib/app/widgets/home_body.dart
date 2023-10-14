import 'package:dico/app/providers/search_provider.dart';
import 'package:dico/app/models/result_model.dart';
import 'package:dico/app/pages/info_page.dart';
import 'package:dico/app/utils/constants.dart';
import 'package:dico/app/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'card_item.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          top: appBarHeight(context) - kToolbarHeight,
          child: Consumer(
            builder: (context, ref, child) {
              final provider = ref.watch(searchProvider);
              return body(context, provider.results);
            },
          ),
        ),
        const Positioned(
          left: 0,
          right: 0,
          top: 0,
          child: CustomAppBar(),
        ),
      ],
    );
  }

  Widget body(BuildContext context, List<ResultModel> results) {
    if (results.isEmpty) {
      return Column(
        children: [
          const SizedBox(height: kToolbarHeight),
          Expanded(
            child: Center(
              child: Image.asset(logo, height: 56),
            ),
          ),
        ],
      );
    }
    return ListView.separated(
      itemCount: results.length,
      padding: const EdgeInsets.only(
        top: kToolbarHeight + 24,
        left: 16,
        right: 16,
        bottom: 16,
      ),
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) => CardItem(
        key: UniqueKey(),
        model: results[index],
        onTap: () => showDialog(
          context: context,
          builder: (_) => InfoPage(results[index]),
        ),
      ),
    );
  }
}
