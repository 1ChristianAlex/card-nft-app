import 'package:card_nft_app/theme/theme.dart';
import 'package:flutter/material.dart';

class CardTimeClaimProgress extends StatefulWidget {
  final Duration expiresInDuration;

  const CardTimeClaimProgress({super.key, required this.expiresInDuration});

  @override
  State<CardTimeClaimProgress> createState() => _CardTimeClaimProgressState();
}

class _CardTimeClaimProgressState extends State<CardTimeClaimProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: widget.expiresInDuration.inSeconds > 0
          ? widget.expiresInDuration
          : const Duration(seconds: 0),
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
