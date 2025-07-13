import 'package:flutter/material.dart';
import 'package:hand_car/gen/assets.gen.dart';

class SpareBrandsWidget extends StatefulWidget {
  const SpareBrandsWidget({super.key});

  @override
  SpareBrandsWidgetState createState() => SpareBrandsWidgetState();
}

class SpareBrandsWidgetState extends State<SpareBrandsWidget>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late AnimationController _animationController;

  final List<Widget> brandLogos = [
    Padding(
      padding: EdgeInsets.all(8.0), 
      child: Image.asset(Assets.icons.boschLogo.path, height: 50, width: 80),
    ),
    Padding(
      padding: EdgeInsets.all(8.0),
      child: Image.asset(Assets.icons.pwrLogo.path, height: 50, width: 80),
    ),
    Padding(
      padding: EdgeInsets.all(8.0),
      child: Image.asset(Assets.icons.nissensLogo.path, height: 50, width: 80),
    ),
    Padding(
      padding: EdgeInsets.all(8.0),
      child: Image.asset(Assets.icons.densoLogo.path, height: 50, width: 80),
    ),
    Padding(
      padding: EdgeInsets.all(8.0),
      child: Image.asset(Assets.icons.mahleLogo.path, height: 50, width: 80),
    ),
    // Duplicate for seamless looping
    Padding(
      padding: EdgeInsets.all(8.0),
      child: Image.asset(Assets.icons.boschLogo.path, height: 50, width: 80),
    ),
    Padding(
      padding: EdgeInsets.all(8.0),
      child: Image.asset(Assets.icons.pwrLogo.path, height: 50, width: 80),
    ),
    Padding(
      padding: EdgeInsets.all(8.0),
      child: Image.asset(Assets.icons.nissensLogo.path, height: 50, width: 80),
    ),
    Padding(
      padding: EdgeInsets.all(8.0),
      child: Image.asset(Assets.icons.densoLogo.path, height: 50, width: 80),
    ),
    Padding(
      padding: EdgeInsets.all(8.0),
      child: Image.asset(Assets.icons.mahleLogo.path, height: 50, width: 80),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20), // Adjust speed of scrolling
    );

    // Start the animation
    _animationController.repeat();

    // Animate the scroll position
    _animationController.addListener(() {
      if (_scrollController.hasClients) {
        final maxScroll = _scrollController.position.maxScrollExtent;
        final currentScroll = _scrollController.offset;
        final itemWidth = 96.0; // 80 (image width) + 8 (padding left) + 8 (padding right)
        final originalListWidth = itemWidth * 5; // Original 5 items

        // Calculate new scroll position based on animation progress
        final newPosition = _animationController.value * originalListWidth;

        // Jump to start when reaching the halfway point (seamless loop)
        if (currentScroll >= originalListWidth) {
          _scrollController.jumpTo(currentScroll - originalListWidth);
        }

        _scrollController.jumpTo(newPosition);
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        controller: _scrollController,
        physics: const NeverScrollableScrollPhysics(), 
        children: brandLogos,
      ),
    );
  }
}