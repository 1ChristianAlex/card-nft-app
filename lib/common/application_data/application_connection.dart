import 'package:card_nft_app/common/http/http_adapter.dart';

abstract class ApplicationConnection {
  final HttpAdapter adapter;

  ApplicationConnection({required this.adapter});
}
