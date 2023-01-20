import 'package:card_nft_app/common/state/app/app_state.dart';
import 'package:card_nft_app/common/state/deck/deck_state.dart';
import 'package:card_nft_app/constants.dart';
import 'package:card_nft_app/features/gamble/application/gample_model.dart';
import 'package:card_nft_app/features/gamble/widgets/card_action_bottom_sheets.dart';
import 'package:card_nft_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class CardActionButton extends StatelessWidget {
  final GambleModel currentGamble;

  const CardActionButton({super.key, required this.currentGamble});

  bool isAbleToClaim(DeckState deck) {
    if (deck.claims == 0) {
      return false;
    }

    return !currentGamble.isExpired();
  }

  @override
  Widget build(BuildContext context) {
    void navigateToDashboard() {
      Navigator.pushNamed(context, RouterPaths.home);
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.45,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          OutlinedButton(
            onPressed: () => navigateToDashboard(),
            style: OutlinedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(
                AppTheme.spacing * 2.3,
              ),
              elevation: 3,
              backgroundColor: Colors.transparent,
              side: const BorderSide(
                width: 2.0,
                color: AppTheme.red,
              ),
            ),
            child: const Icon(
              Icons.arrow_back_outlined,
              size: 32,
              color: AppTheme.red,
            ),
          ),
          StoreConnector<AppState, DeckState>(
            converter: (store) => store.state.deck!,
            builder: (context, deck) {
              var onClaimPress = isAbleToClaim(deck)
                  ? () {
                      CardActionBottomSheets(context: context)
                          .showClaimBottomSheet(currentGamble);
                    }
                  : null;

              return OutlinedButton(
                onPressed: onClaimPress,
                style: OutlinedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(
                    AppTheme.spacing * 2.3,
                  ),
                  elevation: 3,
                  backgroundColor: Colors.transparent,
                  side: BorderSide(
                    width: 2.0,
                    color: onClaimPress == null
                        ? AppTheme.darkCharcoal
                        : AppTheme.green,
                  ),
                ),
                child: Icon(
                  Icons.check_circle_outline_rounded,
                  size: 32,
                  color: onClaimPress == null
                      ? AppTheme.darkCharcoal
                      : AppTheme.green,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
