import 'package:card_nft_app/features/card/application/card_model.dart';
import 'package:card_nft_app/theme/theme.dart';
import 'package:flutter/material.dart';

class CardItemInfo extends StatelessWidget {
  final CardModel currentCard;
  late final int thumbCurrent;
  late final int thumbLenght;

  CardItemInfo({super.key, required this.currentCard}) {
    thumbCurrent = currentCard.thumbnail!.first.position! + 1;
    thumbLenght = currentCard.thumbnail!.length;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacing * 1),
      alignment: Alignment.bottomLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  currentCard.name ?? '',
                  style: const TextStyle(
                    color: AppTheme.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                '$thumbCurrent/$thumbLenght',
                style: const TextStyle(
                  color: AppTheme.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: AppTheme.spacing,
          ),
          Row(
            children: [
              const Icon(
                Icons.edit,
                color: AppTheme.white,
                size: 20,
              ),
              const SizedBox(
                width: AppTheme.spacing,
              ),
              Expanded(
                child: Text(
                  currentCard.description ?? '',
                  style: const TextStyle(
                    color: AppTheme.white,
                    fontSize: 18,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 1,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: AppTheme.spacing,
          ),
          Row(
            children: [
              const Icon(
                Icons.diamond_outlined,
                color: AppTheme.blurple,
                size: 20,
              ),
              const SizedBox(
                width: AppTheme.spacing,
              ),
              Expanded(
                child: Text(
                  currentCard.price.toString(),
                  style: const TextStyle(
                    color: AppTheme.white,
                    fontSize: 18,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
