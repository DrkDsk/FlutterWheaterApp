import 'package:clima_app/core/enum/transitions_type_enum.dart';
import 'package:flutter/cupertino.dart';


class CustomTransitionBuilder {

  static Widget build({
    required Animation<double> animation,
    required Widget child,
    required TransitionType type,
    Curve curve = Curves.ease,
    bool useCurvedAnimation = false,
  }) {
    switch (type) {
      case TransitionType.slideFromRight:
      case TransitionType.slideFromLeft:
      case TransitionType.slideFromTop:
      case TransitionType.slideFromBottom:
        return _buildSlideTransition(
          animation: animation,
          child: child,
          type: type,
          curve: curve,
          useCurvedAnimation: useCurvedAnimation,
        );
      case TransitionType.fade:
        return _buildFadeTransition(
          animation: animation,
          child: child,
          curve: curve,
          useCurvedAnimation: useCurvedAnimation,
        );
      case TransitionType.scale:
        return _buildScaleTransition(
          animation: animation,
          child: child,
          curve: curve,
          useCurvedAnimation: useCurvedAnimation,
        );
    }
  }

  static SlideTransition _buildSlideTransition({
    required Animation<double> animation,
    required Widget child,
    required TransitionType type,
    required Curve curve,
    required bool useCurvedAnimation,
  }) {
    final beginOffset = _getBeginOffset(type);
    const endOffset = Offset.zero;

    final position = useCurvedAnimation
        ? Tween<Offset>(begin: beginOffset, end: endOffset)
        .animate(CurvedAnimation(parent: animation, curve: curve))
        : animation.drive(
      Tween<Offset>(begin: beginOffset, end: endOffset)
          .chain(CurveTween(curve: curve)),
    );

    return SlideTransition(
      position: position,
      child: child,
    );
  }

  static FadeTransition _buildFadeTransition({
    required Animation<double> animation,
    required Widget child,
    required Curve curve,
    required bool useCurvedAnimation,
  }) {
    final opacity = useCurvedAnimation
        ? Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: animation, curve: curve))
        : animation.drive(
      Tween<double>(begin: 0.0, end: 1.0)
          .chain(CurveTween(curve: curve)),
    );

    return FadeTransition(
      opacity: opacity,
      child: child,
    );
  }

  static ScaleTransition _buildScaleTransition({
    required Animation<double> animation,
    required Widget child,
    required Curve curve,
    required bool useCurvedAnimation,
  }) {
    final scale = useCurvedAnimation
        ? Tween<double>(begin: 0.8, end: 1.0)
        .animate(CurvedAnimation(parent: animation, curve: curve))
        : animation.drive(
      Tween<double>(begin: 0.8, end: 1.0)
          .chain(CurveTween(curve: curve)),
    );

    return ScaleTransition(
      scale: scale,
      child: child,
    );
  }

  static Offset _getBeginOffset(TransitionType type) {
    switch (type) {
      case TransitionType.slideFromRight:
        return const Offset(1.0, 0.0);
      case TransitionType.slideFromLeft:
        return const Offset(-1.0, 0.0);
      case TransitionType.slideFromTop:
        return const Offset(0.0, -1.0);
      case TransitionType.slideFromBottom:
        return const Offset(0.0, 1.0);
      default:
        return Offset.zero;
    }
  }
}