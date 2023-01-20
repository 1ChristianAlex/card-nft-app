import 'dart:async';

import 'package:card_nft_app/common/state/app/app_state.dart';
import 'package:card_nft_app/common/state/deck/deck_state.dart';
import 'package:card_nft_app/common/state/store.dart';
import 'package:card_nft_app/constants.dart';
import 'package:card_nft_app/features/card/application/card_model.dart'
    as card_model;
import 'package:card_nft_app/features/card/application/card_model.dart';
import 'package:card_nft_app/features/gamble/application/gamble_application.dart';
import 'package:card_nft_app/features/gamble/application/gample_model.dart';
import 'package:card_nft_app/features/gamble/widgets/card_item_info.dart';
import 'package:card_nft_app/features/gamble/widgets/card_time_claim_progress.dart';
import 'package:card_nft_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:skeletons/skeletons.dart';

class CardSwiperDeck extends StatefulWidget {
  const CardSwiperDeck({super.key});

  @override
  State<CardSwiperDeck> createState() => _CardSwiperDeckState();
}

class _CardSwiperDeckState extends State<CardSwiperDeck> {
  final imageBackLoading = 'assets/card-back-lol.png';

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
            thumbnail: [card_model.ThumbnailModel(path: imageBackLoading)],
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

  void changeCurrentThumbnail(int indexCard) {
    var currentCartToChange = cards[indexCard];

    var thumbList = currentCartToChange.card.thumbnail!;

    List<ThumbnailModel> newOrderThumb = [];

    for (var indexThumb = 1; indexThumb < thumbList.length; indexThumb++) {
      newOrderThumb.add(thumbList[indexThumb]);
    }

    newOrderThumb.add(thumbList.first);

    currentCartToChange.card.thumbnail = newOrderThumb;

    var newCardsList = [...cards];

    newCardsList[indexCard] = currentCartToChange;

    setState(() {
      cards = newCardsList;
    });
  }

  @override
  Widget build(BuildContext context) {
    const fullSize = Size.fromWidth(double.infinity);

    var cardHeight = fullSize.height;
    var cardWidth = fullSize.width;

    return Container(
      margin: const EdgeInsets.only(
        bottom: AppTheme.spacing,
      ),
      child: Column(
        children: [
          Expanded(
            child: Swiper(
              itemCount: cards.length,
              itemWidth: cardWidth,
              itemHeight: cardHeight,
              layout: SwiperLayout.TINDER,
              allowImplicitScrolling: true,
              loop: true,
              axisDirection: AxisDirection.right,
              onTap: (newIndex) {
                setState(() {
                  isStarted = true;
                });
                if (cards[newIndex].expiresIn == null) {
                  getCardGamble(index: newIndex);
                } else {
                  changeCurrentThumbnail(newIndex);
                }
              },
              controller: swiperControl,
              onIndexChanged: (index) {
                setState(() {
                  currentCard = cards[index];
                });
              },
              itemBuilder: (BuildContext context, int index) {
                var currentItem = cards[index];
                var thumb = currentItem.card.thumbnail!.first;
                var isLoading = true;

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
                        fit: BoxFit.cover,
                        height: cardHeight,
                        width: cardWidth,
                        frameBuilder:
                            (context, child, frame, wasSynchronouslyLoaded) {
                          isLoading = frame == null;
                          return child;
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null && !isLoading) {
                            return child;
                          }
                          return SkeletonLine(
                            style: SkeletonLineStyle(
                              height: cardHeight,
                              width: cardWidth,
                            ),
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
                          stops: [0.5, 1],
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      margin: const EdgeInsets.all(AppTheme.spacing * 1),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CardItemInfo(currentCard: currentItem.card),
                          const SizedBox(
                            height: AppTheme.spacing * 2,
                          ),
                          SizedBox(
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
                                  builder: (context, deck) => OutlinedButton(
                                    onPressed: isAbleToClaim(deck)
                                        ? () {
                                            gambleConnection.claimCard(
                                                currentItem.card.id!);
                                          }
                                        : () {},
                                    style: OutlinedButton.styleFrom(
                                      shape: const CircleBorder(),
                                      padding: const EdgeInsets.all(
                                        AppTheme.spacing * 2.3,
                                      ),
                                      elevation: 3,
                                      backgroundColor: Colors.transparent,
                                      side: const BorderSide(
                                        width: 2.0,
                                        color: AppTheme.green,
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.check_circle_outline_rounded,
                                      size: 32,
                                      color: AppTheme.green,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: AppTheme.spacing * 2,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(
            height: AppTheme.spacing,
          ),
        ],
      ),
    );
  }
}
