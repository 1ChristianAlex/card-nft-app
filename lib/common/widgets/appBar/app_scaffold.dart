import 'package:card_nft_app/common/state/app/app_state.dart';
import 'package:card_nft_app/common/state/deck/deck_state.dart';
import 'package:card_nft_app/constants.dart';
import 'package:card_nft_app/features/auth/application/auth_application.dart';
import 'package:card_nft_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

// ignore: must_be_immutable
class AppScaffold extends StatelessWidget {
  final Widget body;

  AppBar? appBar;

  AppScaffold({super.key, required this.body, this.appBar});

  @override
  Widget build(BuildContext context) {
    bool isCurrentPage(String pageTest) {
      var currentRoute = ModalRoute.of(context)?.settings.name;

      if (currentRoute != null && currentRoute.isNotEmpty) {
        return currentRoute == pageTest;
      }
      return false;
    }

    Color getIconColor(String pageTest) {
      return isCurrentPage(pageTest) ? AppTheme.blurple : AppTheme.white;
    }

    IconData gambleIcon() {
      return isCurrentPage(RouterPaths.gamble)
          ? Icons.navigate_before_outlined
          : Icons.casino_sharp;
    }

    void navigateToRoute(String pathname) {
      Navigator.pushReplacementNamed(context, pathname);
    }

    return Scaffold(
      appBar: appBar,
      backgroundColor: AppTheme.arsenic,
      body: body,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: AppTheme.darkCharcoal,
        elevation: 20.0,
        child: SizedBox(
          height: 50.0,
          child: Row(
            children: [
              IconButton(
                tooltip: 'Dashboard',
                icon: Icon(
                  Icons.dashboard_outlined,
                  color: getIconColor(RouterPaths.home),
                ),
                onPressed: () {
                  navigateToRoute(RouterPaths.home);
                },
              ),
              IconButton(
                tooltip: 'Cards',
                icon: Icon(
                  Icons.view_list_outlined,
                  color: getIconColor(RouterPaths.cardList),
                ),
                onPressed: () {
                  navigateToRoute(RouterPaths.cardList);
                },
              ),
              IconButton(
                tooltip: 'Timers',
                icon: Icon(
                  Icons.timer_outlined,
                  color: getIconColor(RouterPaths.timers),
                ),
                onPressed: () {
                  navigateToRoute(RouterPaths.timers);
                },
              ),
              const Spacer(),
              IconButton(
                tooltip: 'User',
                icon: Icon(
                  Icons.account_box_outlined,
                  color: getIconColor(RouterPaths.user),
                ),
                onPressed: () {
                  navigateToRoute(RouterPaths.user);
                },
              ),
              IconButton(
                tooltip: 'Settings',
                icon: Icon(
                  Icons.settings_outlined,
                  color: getIconColor(RouterPaths.settings),
                ),
                onPressed: () {
                  navigateToRoute(RouterPaths.settings);
                },
              ),
              IconButton(
                tooltip: 'Logout',
                icon: const Icon(
                  Icons.logout_outlined,
                  color: AppTheme.white,
                ),
                onPressed: () {
                  authConnetion.logout();

                  Navigator.pushReplacementNamed(context, RouterPaths.login);
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: StoreConnector<AppState, DeckState?>(
        converter: (store) => store.state.deck,
        builder: (context, deck) => FloatingActionButton(
          backgroundColor: AppTheme.blurple,
          onPressed: (deck != null && deck.gambles > 0)
              ? () {
                  if (!isCurrentPage(RouterPaths.gamble)) {
                    Navigator.pushReplacementNamed(context, RouterPaths.gamble);
                  } else {
                    navigateToRoute(RouterPaths.home);
                  }
                }
              : null,
          elevation: 5,
          child: Icon(gambleIcon()),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
