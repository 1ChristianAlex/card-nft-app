import 'package:card_nft_app/common/widgets/appBar/app_scaffold.dart';
import 'package:card_nft_app/features/gamble/widgets/card_swiper_deck.dart';
import 'package:card_nft_app/theme/theme.dart';
import 'package:flutter/material.dart';

class GambleScreen extends StatelessWidget {
  const GambleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: const Padding(
        padding: EdgeInsets.only(bottom: AppTheme.spacing),
        child: CardSwiperDeck(),
      ),
    );
  }
}
