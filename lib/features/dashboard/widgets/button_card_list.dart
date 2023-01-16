import 'package:card_nft_app/theme/theme.dart';
import 'package:flutter/material.dart';

class ButtonCardList extends StatelessWidget {
  final String label;

  final String value;

  final Icon iconLabel;

  const ButtonCardList({
    super.key,
    required this.label,
    required this.value,
    required this.iconLabel,
  });

  @override
  Widget build(BuildContext context) {
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
                child: iconLabel,
              ),
              Text(
                label,
                style: const TextStyle(fontSize: 22),
              ),
            ],
          ),
          const SizedBox(
            height: AppTheme.spacing,
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 26),
          ),
        ],
      ),
    );
  }
}
