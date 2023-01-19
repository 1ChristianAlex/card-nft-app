import 'dart:async';

import 'package:card_nft_app/common/state/app/app_state.dart';
import 'package:card_nft_app/common/state/deck/deck_state.dart';
import 'package:card_nft_app/common/state/store.dart';
import 'package:card_nft_app/constants.dart';
import 'package:card_nft_app/features/card/application/card_model.dart'
    as card_model;
import 'package:card_nft_app/features/gamble/application/gamble_application.dart';
import 'package:card_nft_app/features/gamble/application/gample_model.dart';
import 'package:card_nft_app/features/gamble/widgets/card_item_info.dart';
import 'package:card_nft_app/features/gamble/widgets/card_time_claim_progress.dart';
import 'package:card_nft_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter_redux/flutter_redux.dart';

class CardSwiperDeck extends StatefulWidget {
  const CardSwiperDeck({super.key});

  @override
  State<CardSwiperDeck> createState() => _CardSwiperDeckState();
}

class _CardSwiperDeckState extends State<CardSwiperDeck> {
  final imageBackLoading = 'assets/back-image-card.jpg';

  List<GambleModel> cards = [];
  GambleModel? currentCard;
  bool isLoading = false;

  bool isStarted = false;

  SwiperController swiperControl = SwiperController();

  @override
  void initState() {
    super.initState();

    if (appStore.state.deck != null && appStore.state.deck!.gambles > 0) {
      for (var i = 0; i < appStore.state.deck!.gambles; i++) {
        cards.add(GambleModel(
          card: card_model.CardModel(
            thumbnail: [card_model.Thumbnail(path: imageBackLoading)],
          ),
          expiresIn: null,
        ));
      }
    }
  }

  Future<void> getCardGamble({int index = 0}) async {
    try {
      setState(() {
        isLoading = true;
      });

      var cardFetch = await gambleConnection.gambleCard();

      var newCards = List<GambleModel>.from(cards);

      newCards[index] = cardFetch;
      cards = [...newCards];

      setState(() {
        isLoading = false;
        currentCard = cardFetch;
      });

      schedulerExpiration(cardFetch);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  void schedulerExpiration(GambleModel gambleItem) {
    var diff = gambleItem.diffInSeconds();

    Timer(
      Duration(seconds: diff),
      () {
        setState(() {});
      },
    );
  }

  void navigateToDashboard() {
    Navigator.pushNamed(context, RouterPaths.home);
  }

  bool isAbleToClaim(DeckState deck) {
    if (deck.claims == 0) {
      return false;
    }

    if (isStarted && currentCard != null) {
      return !currentCard!.isExpired();
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: kToolbarHeight,
        left: AppTheme.spacing,
        right: AppTheme.spacing,
        bottom: AppTheme.spacing,
      ),
      child: Column(
        children: [
          Expanded(
            child: Swiper(
              itemBuilder: (BuildContext context, int index) {
                var currentItem = cards[index];
                var thumb = currentItem.card.thumbnail!.first;

                var cardHeight = MediaQuery.of(context).size.height * 0.90;
                var cardWidth = MediaQuery.of(context).size.width * 0.85;

                if (thumb.path == imageBackLoading) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      thumb.path!,
                      fit: BoxFit.fill,
                      height: cardHeight,
                      width: cardWidth,
                    ),
                  );
                }

                var duration = Duration(
                  seconds: currentItem.diffInSecondsByNow(),
                );
                return Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        thumb.path!,
                        fit: BoxFit.fill,
                        height: cardHeight,
                        width: cardWidth,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Stack(
                            children: [
                              Image.asset(
                                imageBackLoading,
                                fit: BoxFit.fill,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      padding: const EdgeInsets.all(AppTheme.spacing * 2),
                      child: CardTimeClaimProgress(
                        expiresInDuration: duration,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black87,
                          ],
                        ),
                      ),
                    ),
                    CardItemInfo(currentCard: currentCard!.card),
                  ],
                );
              },
              itemCount: cards.length,
              itemWidth: MediaQuery.of(context).size.width * 0.85,
              itemHeight: MediaQuery.of(context).size.height * 0.90,
              layout: SwiperLayout.STACK,
              allowImplicitScrolling: true,
              loop: true,
              axisDirection: AxisDirection.right,
              onTap: (newIndex) {
                setState(() {
                  isStarted = true;
                });
                if (cards[newIndex].expiresIn == null) {
                  getCardGamble(index: newIndex);
                }
              },
              controller: swiperControl,
              onIndexChanged: (index) {
                setState(() {
                  currentCard = cards[index];
                });
              },
            ),
          ),
          const SizedBox(
            height: AppTheme.spacing,
          ),
          Container(
            margin: const EdgeInsets.all(AppTheme.spacing * 1),
            width: MediaQuery.of(context).size.width * 0.4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () => navigateToDashboard(),
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(AppTheme.spacing * 2),
                    elevation: 3,
                    backgroundColor: AppTheme.red,
                  ),
                  child: const Icon(Icons.close, size: 32),
                ),
                StoreConnector<AppState, DeckState>(
                  converter: (store) => store.state.deck!,
                  builder: (context, deck) => ElevatedButton(
                    onPressed: isAbleToClaim(deck)
                        ? () {
                            gambleConnection.claimCard(currentCard!.card.id!);
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(AppTheme.spacing * 2),
                      elevation: 3,
                      backgroundColor: AppTheme.green,
                    ),
                    child: const Icon(
                      Icons.check_circle_outline_rounded,
                      size: 32,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
