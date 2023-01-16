import 'package:card_nft_app/common/state/store.dart';
import 'package:card_nft_app/features/card/application/card_model.dart'
    as card_model;
import 'package:card_nft_app/features/gumble/application/gumble_application.dart';
import 'package:card_nft_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';

class CardSwiperDeck extends StatefulWidget {
  const CardSwiperDeck({super.key});

  @override
  State<CardSwiperDeck> createState() => _CardSwiperDeckState();
}

class _CardSwiperDeckState extends State<CardSwiperDeck> {
  final imageBackLoading = 'assets/back-image-card.jpg';

  bool isStarded = false;

  List<card_model.Card> cards = [];

  SwiperController swiperControl = SwiperController();

  @override
  void initState() {
    super.initState();

    if (appStore.state.deck != null && appStore.state.deck!.gambles > 0) {
      for (var i = 0; i < appStore.state.deck!.gambles; i++) {
        cards.add(card_model.Card(
            thumbnail: [card_model.Thumbnail(path: imageBackLoading)]));
      }
    }
  }

  Future<card_model.Card> getCardGumble({int index = 0}) async {
    var cardFetch = await gumbleConnection.gumbleCard();

    var newCards = List<card_model.Card>.from(cards);

    newCards[index] = cardFetch;
    setState(() {
      cards = [...newCards];
    });

    return cardFetch;
  }

  void handleStartGumble() {
    setState(() {
      isStarded = true;
    });
    getCardGumble();
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
                var cardItem = cards[index];
                var thumb = cardItem.thumbnail!.first;

                return Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: AnimatedContainer(
                        duration: const Duration(seconds: 9),
                        child: thumb.path == imageBackLoading
                            ? Image.asset(
                                thumb.path!,
                                fit: BoxFit.fill,
                                height:
                                    MediaQuery.of(context).size.height * 0.90,
                              )
                            : Image.network(
                                thumb.path!,
                                fit: BoxFit.fill,
                                height:
                                    MediaQuery.of(context).size.height * 0.90,
                              ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        cardItem.name ?? '',
                        style: const TextStyle(color: AppTheme.white),
                      ),
                    )
                  ],
                );
              },
              itemCount: cards.length,
              itemWidth: 300.0,
              layout: SwiperLayout.STACK,
              allowImplicitScrolling: false,
              loop: false,
              axisDirection: AxisDirection.right,
              onIndexChanged: (newIndex) {
                getCardGumble(index: newIndex);
              },
              controller: swiperControl,
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
                  onPressed: isStarded
                      ? () {
                          swiperControl.next();
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(AppTheme.spacing * 2),
                    elevation: 3,
                    backgroundColor: AppTheme.red,
                  ),
                  child: const Icon(Icons.close, size: 32),
                ),
                ElevatedButton(
                  onPressed: isStarded ? () {} : null,
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(AppTheme.spacing * 2),
                    elevation: 3,
                    backgroundColor: AppTheme.green,
                  ),
                  child:
                      const Icon(Icons.check_circle_outline_rounded, size: 32),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (isStarded) {
                Navigator.pop(context);
              } else {
                handleStartGumble();
              }
            },
            style: ElevatedButton.styleFrom(
              elevation: 3,
              backgroundColor: AppTheme.blurple,
            ),
            child: Text(isStarded ? 'Cancel' : 'Start'),
          )
        ],
      ),
    );
  }
}
