import 'dart:async';

import 'package:card_nft_app/features/gamble/application/gamble_application.dart';
import 'package:card_nft_app/features/gamble/application/gample_model.dart';
import 'package:card_nft_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

class CardActionBottomSheets {
  final BuildContext context;

  CardActionBottomSheets({required this.context});

  Future<void> _showClaimed(GambleModel currentGamble) async {
    await showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          var name = currentGamble.card.name;

          return Container(
            color: AppTheme.arsenic,
            child: Container(
              margin: const EdgeInsets.all(AppTheme.spacing * 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: AppTheme.spacing * 2,
                  ),
                  Text(
                    'You claim $name?',
                    style: const TextStyle(
                      color: AppTheme.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: AppTheme.spacing * 3,
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> showClaimBottomSheet(GambleModel currentGamble) async {
    await showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          var name = currentGamble.card.name;

          return Container(
            color: AppTheme.arsenic,
            child: Container(
              margin: const EdgeInsets.all(AppTheme.spacing * 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: AppTheme.spacing * 2,
                  ),
                  Text(
                    'Do you wanna claim $name?',
                    style: const TextStyle(
                      color: AppTheme.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: AppTheme.spacing * 3,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(AppTheme.green),
                      minimumSize:
                          MaterialStateProperty.all(const Size.fromHeight(50)),
                    ),
                    onPressed: () async {
                      Navigator.pop(context);

                      context.loaderOverlay.show();
                      await gambleConnection.claimCard(currentGamble.card.id!);
                      context.loaderOverlay.hide();
                      await _showClaimed(currentGamble);
                    },
                    child: const Text(
                      'Yes',
                      style: TextStyle(fontSize: 14, color: AppTheme.white),
                    ),
                  ),
                  const SizedBox(
                    height: AppTheme.spacing * 1,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(AppTheme.red),
                      minimumSize:
                          MaterialStateProperty.all(const Size.fromHeight(50)),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'No',
                      style: TextStyle(fontSize: 14, color: AppTheme.white),
                    ),
                  ),
                  const SizedBox(
                    height: AppTheme.spacing * 3,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
