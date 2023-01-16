import 'package:card_nft_app/features/gumble/widgets/card_swiper_deck.dart';
import 'package:card_nft_app/theme/theme.dart';
import 'package:flutter/material.dart';

class GumbleScreen extends StatelessWidget {
  const GumbleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppTheme.arsenic,
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
