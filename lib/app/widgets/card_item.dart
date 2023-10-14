import 'package:dico/app/models/result_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class CardItem extends StatelessWidget {
  final ResultModel model;
  final Function onTap;
  const CardItem({Key? key, required this.model, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 1,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        title: Row(
          textDirection: TextDirection.ltr,
          textBaseline: TextBaseline.alphabetic,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          children: [
            const Icon(FeatherIcons.type, size: 20, color: Colors.black38),
            const SizedBox(width: 4),
            Text(model.word),
          ],
        ),
        subtitle: Row(
          textBaseline: TextBaseline.alphabetic,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(FeatherIcons.alignRight, size: 20, color: Colors.black38),
            const SizedBox(width: 4),
            Expanded(
              child: Text(model.mean, maxLines: 1, overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
        onTap: () => onTap(),
      ),
    );
  }
}
