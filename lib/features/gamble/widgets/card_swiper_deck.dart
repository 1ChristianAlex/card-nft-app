import 'dart:async';
import 'package:card_nft_app/common/state/store.dart';
import 'package:card_nft_app/features/card/application/card_model.dart'
    as card_model;
import 'package:card_nft_app/features/card/application/card_model.dart';
import 'package:card_nft_app/features/gamble/application/gamble_application.dart';
import 'package:card_nft_app/features/gamble/application/gample_model.dart';
import 'package:card_nft_app/features/gamble/widgets/card_item_info.dart';
import 'package:card_nft_app/features/gamble/widgets/card_action_button.dart';
import 'package:card_nft_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:skeletons/skeletons.dart';

class CardSwiperDeck extends StatefulWidget {
  const CardSwiperDeck({super.key});

  @override
  State<CardSwiperDeck> createState() => _CardSwiperDeckState();
}

class _CardSwiperDeckState extends State<CardSwiperDeck> {
  final imageBackLoading = 'assets/card-back-lol.png';

  List<GambleModel> gambles = [];
  GambleModel? currentGamble;
  bool isLoading = false;

  SwiperController swiperControl = SwiperController();

  @override
  void initState() {
    super.initState();

    if (appStore.state.deck != null && appStore.state.deck!.gambles > 0) {
      for (var i = 0; i < appStore.state.deck!.gambles; i++) {
        gambles.add(GambleModel(
          card: CardModel(
            thumbnail: [card_model.ThumbnailModel(path: imageBackLoading)],
          ),
          expiresInSeconds: null,
        ));
      }
    }
  }

  Future<void> getGamble(int index) async {
    try {
      setState(() {
        isLoading = true;
      });

      var gambleFetch = await gambleConnection.gambleCard();

      var newGambles = List<GambleModel>.from(gambles);

      newGambles[index] = gambleFetch;

      gambles = [...newGambles];

      setState(() {
        isLoading = false;
        currentGamble = gambleFetch;
      });

      schedulerExpiration(gambleFetch);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  void schedulerExpiration(GambleModel gambleItem) {
    Timer(
      Duration(seconds: gambleItem.expiresInSeconds!),
      () {
        setState(() {});
      },
    );
  }

  void changeCurrentThumbnail(int indexCard) {
    var currentCartToChange = gambles[indexCard];

    var thumbList = currentCartToChange.card.thumbnail!;

    List<ThumbnailModel> newOrderThumb = [];

    for (var indexThumb = 1; indexThumb < thumbList.length; indexThumb++) {
      newOrderThumb.add(thumbList[indexThumb]);
    }

    newOrderThumb.add(thumbList.first);

    currentCartToChange.card.thumbnail = newOrderThumb;

    var newCardsList = [...gambles];

    newCardsList[indexCard] = currentCartToChange;

    setState(() {
      gambles = newCardsList;
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
              itemCount: gambles.length,
              itemWidth: cardWidth,
              itemHeight: cardHeight,
              layout: SwiperLayout.TINDER,
              allowImplicitScrolling: true,
              loop: true,
              axisDirection: AxisDirection.right,
              onTap: (newIndex) {
                if (gambles[newIndex].expiresInSeconds == null) {
                  getGamble(newIndex);
                } else {
                  changeCurrentThumbnail(newIndex);
                }
              },
              controller: swiperControl,
              onIndexChanged: (index) {
                setState(() {
                  currentGamble = gambles[index];
                });
              },
              itemBuilder: (BuildContext context, int index) {
                var gambleItem = gambles[index];
                var thumb = gambleItem.card.thumbnail!.first;
                var isLoading = true;

                if (thumb.path == imageBackLoading) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      imageBackLoading,
                      fit: BoxFit.cover,
                      height: cardHeight,
                      width: cardWidth,
                    ),
                  );
                }

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
                    // Container(
                    //   alignment: Alignment.topRight,
                    //   padding: const EdgeInsets.all(AppTheme.spacing * 2),
                    //   child: CardTimeClaimProgress(
                    //     maxSeconds: gambleItem.expiresInSeconds!,
                    //     currentLastSeconds: gambleItem.diffNow().inSeconds,
                    //   ),
                    // ),
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
                          CardItemInfo(currentCard: gambleItem.card),
                          const SizedBox(
                            height: AppTheme.spacing * 2,
                          ),
                          CardActionButton(
                            currentGamble: gambleItem,
                            swiperControl: swiperControl,
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
