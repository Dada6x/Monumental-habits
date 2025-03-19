import 'package:flutter/material.dart';
import 'package:monumental_habits/widgets/Buttons.dart';

class animatedGoogleButton extends StatefulWidget {
  const animatedGoogleButton({super.key});

  @override
  State<animatedGoogleButton> createState() => _animatedGoogleButtonState();
}

class _animatedGoogleButtonState extends State<animatedGoogleButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 5),
  )..repeat(reverse: true);
  late final Animation<Offset> _animation =
      Tween(begin: Offset.zero, end: const Offset(0, 0.30))
          .animate(_controller);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: googleButton(),
    );
  }
}
