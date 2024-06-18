import 'package:flutter/material.dart';

class Scroller extends StatelessWidget {
  const Scroller(this.child, {super.key});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      clipBehavior: Clip.none,
      slivers: [
        SliverFillRemaining(
          hasScrollBody: true,
          child: OverflowBox(maxHeight: double.infinity, child: child),
        )
      ],
    );
  }
}
