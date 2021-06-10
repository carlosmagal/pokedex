import 'package:flutter/material.dart';

class AnimatedHero extends StatefulWidget {

  AnimatedHero({required this.child});
  final Widget child;

  @override
  _AnimatedHeroState createState() => _AnimatedHeroState();
}

class _AnimatedHeroState extends State<AnimatedHero> with SingleTickerProviderStateMixin {

  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 2400),
  )..repeat(reverse: true);

  late Animation<Offset> _animation = Tween(
    begin: Offset.zero,
    end: Offset(0, 0.04),
  ).animate(this._animationController);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    this._animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      child: widget.child,
      position: this._animation,
    );
    // return widget.child;
  }
}