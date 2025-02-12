import 'package:flutter/material.dart';

class AnimatedFABWrapper extends StatefulWidget {
  final FloatingActionButton floatingActionButton;
  final Duration duration;

  const AnimatedFABWrapper({
    Key? key,
    required this.floatingActionButton, // Pass your custom FAB
    this.duration = const Duration(milliseconds: 1000),
  }) : super(key: key);

  @override
  _AnimatedFABWrapperState createState() => _AnimatedFABWrapperState();
}

class _AnimatedFABWrapperState extends State<AnimatedFABWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    // Define the slide animation
    _animation = Tween<Offset>(
      begin: const Offset(0, 2), // Start off-screen (bottom)
      end: Offset.zero, // Slide to its normal position
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // Start the animation
    _controller.forward();
  }

  @override
  void dispose() {
    // Dispose of controller to avoid memory leaks
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation, // Attach animation to the FAB
      child: widget.floatingActionButton, // Use the passed FAB
    );
  }
}

class NoScalingFABAnimator extends FloatingActionButtonAnimator {
  @override
  Offset getOffset({Offset? begin, Offset? end, double? progress}) {
    return begin ?? Offset.zero; // Keep FAB at its starting position
  }

  @override
  Animation<double> getScaleAnimation({Animation<double>? parent}) {
    return AlwaysStoppedAnimation(1.0); // No scaling animation
  }

  @override
  Animation<double> getRotationAnimation({Animation<double>? parent}) {
    return AlwaysStoppedAnimation(0.0); // No rotation animation
  }
}
