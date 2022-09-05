import 'dart:async';

import 'package:flutter/material.dart';
import 'package:semafor/screens/home_screen.dart';

abstract class HomeState extends State<HomeScreen> {
  @protected
  Stopwatch mGameStopwatch = Stopwatch();

  late Timer mRefreshTimer;

  Duration mRefreshTickDuration = const Duration(milliseconds: 30);

  int mDefaultGameTimeMilliseconds = 0;

  //int mTimeSeconds = 300; // 5 minutes
  int mCurrentGameTimeMilliseconds = 0;

  int mAdditionalGameTimeMilliseconds = 0;

  int mHomeScore = 0;
  int mAwayScore = 0;

  bool mIsRunning = false;

  @override
  void dispose() {
    stop();
    super.dispose();
  }

  @protected
  void start() {
    mRefreshTimer = Timer.periodic(mRefreshTickDuration, _refreshTick);
    mGameStopwatch.start();

    updateState(() {
      mIsRunning = true;

      if (mCurrentGameTimeMilliseconds <= 0) {
        resetGameClock();
      }
    });
  }

  @protected
  void stop() {
    updateState(() {
      mIsRunning = false;
    });
    mGameStopwatch.stop();
  }

  @protected
  void resetGameClock() {
    updateState(() {
      mGameStopwatch = Stopwatch();

      if (mIsRunning) {
        mGameStopwatch.start();
      }

      mAdditionalGameTimeMilliseconds = 0;
    });
  }

  @protected
  void endFirstHalf() {
    updateState(() {
      mGameStopwatch = Stopwatch();

      mAdditionalGameTimeMilliseconds = 2700000;
    });
    stop();
  }

  @protected
  void endSecondHalf() {
    updateState(() {
      mGameStopwatch = Stopwatch();

      stop();

      mAdditionalGameTimeMilliseconds = 5400000;
    });
  }

  @protected
  void setGameClock(int value) {
    updateState(() {
      resetGameClock();

      mAdditionalGameTimeMilliseconds = mDefaultGameTimeMilliseconds - value;

      updateTime();
    });
  }

  @protected
  void setDefaultGameClock(int value) {
    updateState(() {
      mDefaultGameTimeMilliseconds = value;

      resetGameClock();

      updateTime();
    });
  }

  void updateTime() {
    mCurrentGameTimeMilliseconds = mDefaultGameTimeMilliseconds +
        (mGameStopwatch.elapsedMilliseconds + mAdditionalGameTimeMilliseconds);

    if (mCurrentGameTimeMilliseconds < 0) {
      mCurrentGameTimeMilliseconds = 0;
    }
  }

  void _refreshTick(Timer time) {
    updateState(() {
      updateTime();
    });
  }

  @protected
  void changeHomeScore(int Value) {
    updateState(() {
      mHomeScore += Value;
      if (mHomeScore < 0) {
        mHomeScore = 0;
      }
    });
  }

  @protected
  void changeAwayScore(int Value) {
    updateState(() {
      mAwayScore += Value;
      if (mAwayScore < 0) {
        mAwayScore = 0;
      }
    });
  }

  @protected
  void resetHomeScore() {
    updateState(() {
      mHomeScore = 0;
    });
  }

  @protected
  void resetAwayScore() {
    updateState(() {
      mAwayScore = 0;
    });
  }

  void updateState(VoidCallback function) {
    setState(function);
    int Minutes = mCurrentGameTimeMilliseconds ~/ (100 * 1000);
    int Seconds =
        (mCurrentGameTimeMilliseconds - (Minutes * 60 * 1000)) ~/ 1000;

  }
}
