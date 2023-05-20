import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class ClickAnimation extends StatefulWidget {
  const ClickAnimation({Key? key}) : super(key: key);

  @override
  _ClickAnimationState createState() => _ClickAnimationState();
}

class _ClickAnimationState extends State<ClickAnimation> {
  late RiveAnimationController _controller;
  bool _isPlaying = false;
  bool _isStanding = true;
  int _standingTime = 0;

  @override
  void initState() {
    print('加载了');
    super.initState();
    _controller = SimpleAnimation('站立');
    Future.delayed(Duration(seconds: 4), () {
      if (!_isPlaying) {
        setState(() {
          _isStanding = false;
          _controller = SimpleAnimation('休息');
          _controller.isActive = true;
        });
      }
    });
  }

  void _onTap() {
    if (_isPlaying) {
      _controller.isActive = false;
      setState(() {
        _isPlaying = false;
        _isStanding = true;
        _standingTime = 0;
      });
    } else {
      _controller = OneShotAnimation(
        _isStanding ? '惊吓转站立' : '惊吓',
        onStop: () {
          setState(() {
            _isPlaying = false;
            _isStanding = true;
            _standingTime = 0;
            _controller = SimpleAnimation('休息');
          });
        },
        onStart: () => setState(() => _isPlaying = true),
      );
      _controller.isActiveChanged.addListener(() {
        if (_controller.isActive) {
          setState(() => _isStanding = false);
        }
      });
      _controller..isActive = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: RiveAnimation.asset(
        'assets/tomadoro_v3.riv',
        animations: const ['惊吓', '休息', '站立转休息', '惊吓转站立', '站立', '开始站立', '什么都不做'],
        controllers: [_controller],
      ),
    );
  }
}
