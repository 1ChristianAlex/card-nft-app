import 'package:card_nft_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class ButtonCardList extends StatefulWidget {
  final String label;

  final String? value;

  final Icon iconLabel;

  const ButtonCardList({
    super.key,
    required this.label,
    required this.value,
    required this.iconLabel,
  });

  @override
  State<ButtonCardList> createState() => _ButtonCardListState();
}

class _ButtonCardListState extends State<ButtonCardList> {
  @override
  Widget build(BuildContext context) {
    var cardWidth = (MediaQuery.of(context).size.width + AppTheme.spacing) / 2;
    var cardHeight = cardWidth + (cardWidth * 0.1);

    if (!(widget.value != null && widget.value!.isNotEmpty)) {
      return SkeletonLine(
        style: SkeletonLineStyle(
          height: cardHeight,
          width: cardWidth,
          borderRadius: BorderRadius.circular(8),
        ),
      );
    }
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.darkCharcoal,
        elevation: 2,
        alignment: Alignment.centerLeft,
        // minimumSize: const Size.fromHeight(30), // NEW
        padding: const EdgeInsets.all(AppTheme.spacing * 2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: AppTheme.spacing / 2),
                child: widget.iconLabel,
              ),
              Text(
                widget.label,
                style: const TextStyle(fontSize: 22),
              ),
            ],
          ),
          const SizedBox(
            height: AppTheme.spacing,
          ),
          Text(
            widget.value!,
            style: const TextStyle(fontSize: 26),
          ),
        ],
      ),
    );
  }
}
