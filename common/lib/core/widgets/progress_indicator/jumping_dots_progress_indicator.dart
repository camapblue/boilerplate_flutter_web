import 'package:flutter/material.dart';

/// Adds a horizontal list of variable number of jumping dots
///
/// The animation is a smooth up/down continuous animation of each dot.
/// This animation can be used where a text is being expected from an async call
/// The below class is a private [AnimatedWidget] class which is called in the
/// [StatefulWidget].
class _JumpingDot extends AnimatedWidget {
  final Color color;
  final double fontSize;

  _JumpingDot({
    Key? key,
    required Animation<double> animation,
    required this.color,
    required this.fontSize,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;
    return Container(
      height: animation.value + fontSize,
      child: Text(
        '.',
        style:
            TextStyle(color: color, fontSize: fontSize).copyWith(height: 1.1),
      ),
    );
  }
}

/// Creates a list with [numberOfDots] text dots, with 3 dots as default
/// default [fontSize] of 10.0, default [color] as black, [dotSpacing] (gap
/// between each dot) as 0.0 and default time for one cycle of animation
/// [milliseconds] as 250.
/// One cycle of animation is one complete round of a dot animating up and back
/// to its original position.
class JumpingDotsProgressIndicator extends StatefulWidget {
  /// Number of dots that are added in a horizontal list, default = 3.
  final int numberOfDots;

  /// Font size of each dot, default = 10.0.
  final double fontSize;

  /// Spacing between each dot, default 0.0.
  final double dotSpacing;

  /// Color of the dots, default black.
  final Color color;

  /// Time of one complete cycle of animation, default 250 milliseconds.
  final int milliseconds;

  /// Starting and ending values for animations.
  final double beginTweenValue = 0.0;
  final double endTweenValue = 8.0;

  /// Creates a jumping do progress indicator.
  JumpingDotsProgressIndicator({
    this.numberOfDots = 3,
    this.fontSize = 10.0,
    this.color = Colors.black,
    this.dotSpacing = 0.0,
    this.milliseconds = 250,
  });

  @override
  _JumpingDotsProgressIndicatorState createState() =>
      _JumpingDotsProgressIndicatorState();
}

class _JumpingDotsProgressIndicatorState
    extends State<JumpingDotsProgressIndicator> with TickerProviderStateMixin {
  List<AnimationController> controllers = <AnimationController>[];
  List<Animation<double>> animations = <Animation<double>>[];
  final _widgets = <Widget>[];

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < widget.numberOfDots; i++) {
      _addAnimationControllers();
      _buildAnimations(i);
      _addListOfDots(i);
    }

    controllers[0].forward();
  }

  void _addAnimationControllers() {
    controllers.add(AnimationController(
        duration: Duration(milliseconds: widget.milliseconds), vsync: this));
  }

  void _addListOfDots(int index) {
    _widgets.add(
      Padding(
        padding: EdgeInsets.only(right: widget.dotSpacing),
        child: _JumpingDot(
          animation: animations[index],
          fontSize: widget.fontSize,
          color: widget.color,
        ),
      ),
    );
  }

  void _buildAnimations(int index) {
    animations.add(
      Tween(begin: widget.beginTweenValue, end: widget.endTweenValue)
          .animate(controllers[index])
        ..addStatusListener(
          (AnimationStatus status) {
            if (status == AnimationStatus.completed) {
              controllers[index].reverse();
            }
            if (index == widget.numberOfDots - 1 &&
                status == AnimationStatus.dismissed) {
              controllers[0].forward();
            }
            if (animations[index].value > widget.endTweenValue / 2 &&
                index < widget.numberOfDots - 1) {
              controllers[index + 1].forward();
            }
          },
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.fontSize + (widget.fontSize * 0.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _widgets,
      ),
    );
  }

  @override
  void dispose() {
    for (var i = 0; i < widget.numberOfDots; i++) {
      controllers[i].dispose();
    }
    super.dispose();
  }
}
