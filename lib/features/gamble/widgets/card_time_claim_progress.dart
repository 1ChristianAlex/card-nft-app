import 'package:card_nft_app/theme/theme.dart';
import 'package:flutter/material.dart';

class CardTimeClaimProgress extends StatefulWidget {
  final int currentLastSeconds;
  final int maxSeconds;

  const CardTimeClaimProgress({
    super.key,
    required this.currentLastSeconds,
    required this.maxSeconds,
  });

  @override
  State<CardTimeClaimProgress> createState() => _CardTimeClaimProgressState();
}

class _CardTimeClaimProgressState extends State<CardTimeClaimProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    var lastSecondsZero =
        widget.currentLastSeconds < 0 ? 0 : widget.currentLastSeconds;

    var valueFloat = double.parse(
        ((widget.maxSeconds - lastSecondsZero) / widget.maxSeconds)
            .toStringAsFixed(2));
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: lastSecondsZero,
      ),
      value: valueFloat,
    )..addListener(() {
        setState(() {});
      });

    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      value: _controller.value,
      color: AppTheme.yellow,
      valueColor: _controller.drive(
        ColorTween(begin: AppTheme.yellow, end: AppTheme.red),
      ),
    );
  }
}
