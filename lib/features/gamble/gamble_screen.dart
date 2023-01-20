import 'package:card_nft_app/features/gamble/widgets/card_swiper_deck.dart';
import 'package:card_nft_app/theme/theme.dart';
import 'package:flutter/material.dart';

class GambleScreen extends StatelessWidget {
  const GambleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppTheme.darkCharcoal,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     authConnetion.logout();

      //     Navigator.pushNamed(context, RouterPaths.login);
      //   },
      //   backgroundColor: Colors.pink,
      //   child: const Icon(Icons.logout_outlined),
      // ),
      body: CardSwiperDeck(),
    );
  }
}
