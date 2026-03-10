import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';

class OtpTimer extends StatefulWidget {
  final int durationInSeconds;
  final VoidCallback onTimerFinished;

  // Using a unique key allows us to reset the timer from the parent
  const OtpTimer({
    super.key,
    this.durationInSeconds = 60,
    required this.onTimerFinished,
  });

  @override
  State<OtpTimer> createState() => _OtpTimerState();
}

class _OtpTimerState extends State<OtpTimer> {
  late Timer _timer;
  int _remainingSeconds = 0;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.durationInSeconds;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        if (mounted) setState(() => _remainingSeconds--);
      } else {
        _timer.cancel();
        widget.onTimerFinished(); //
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Critical for performance to prevent leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final minutes = (_remainingSeconds / 60).floor();
    final seconds = _remainingSeconds % 60;
    final timeString =
        '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';

    return Text(
      timeString,
      style: AppStyles.mobileBodyMediumRg.copyWith(
        color: AppColors.primaryDark,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
