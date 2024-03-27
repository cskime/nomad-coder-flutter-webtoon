import 'package:flutter/material.dart';
import 'dart:async';

/* [ Flexible Widget ]
 * - 비율 기반 가변 크기 widget 생성
 * - `Flexible`이 여러 개 일 때, `flex` 값으로 늘어나는 비율 결정
 * 
 * [ Expanded ]
 * - 빈 공간을 꽉 채우도록 확장시켜 주는 widget
 * - Column 사용 시 가운데 정렬되어 좌/우를 꽉 채우지 못하는 경우 활용
 * - "Row > Expanded" 계층으로 만들면 된다.
 *   1. Row는 horizontal 방향으로 늘어남
 *   2. Content가 Expanded 이므로 가로 방향으로 content가 꽉 차게 늘어날 수 있음 
 * 
 * [ Timer ]
 * - Dart standard library에 포함 (import 'dart:async')
 * - `Timer.periodic(duration, handler)`
 *   - `duration` 마다 `handler` function을 실행시키도록 schedule하고 `Timer` 객체 반환
 *   - `duration` : `Duration(seconds: 1)`을 사용하면 1초마다 `handler` 실행
 * - `timer.cancel()` : timer 동작 취소
 * 
 * [ Duration ]
 * - `Duration` class를 사용하면 seconds를 "hh:mm:ss.sss" 형식으로 얻을 수 있음
 * - Seconds -> mm:ss 형식으로 변환할 때 `Duration` string을 parsing 할 수 있음
 * - 변환
 *   - `toString()` : 위 형식의 문자열로 반환
 *   - `split(token)` : `token`을 기준으로 문자열을 나눠서 `List<String>`으로 반환
 *   - `substring(start, end?)` : `start`부터 `end`까지 잘라서 `String` 반환 (exclude `end` index character)
 * 
 * [ Question ]
 * - `setState()`를 여러 곳에서 호출할 때, `build()`가 호출되는 매커니즘은?
 */

class PomodoroApp extends StatelessWidget {
  const PomodoroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          backgroundColor: const Color(0xffe7626c),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Color(0xff232b55),
          ),
        ),
        cardColor: const Color(0xfff4eddb),
      ),
      home: const PomodoroHomeScreen(),
    );
  }
}

class PomodoroHomeScreen extends StatefulWidget {
  const PomodoroHomeScreen({super.key});

  @override
  State<PomodoroHomeScreen> createState() => _PomodoroHomeScreenState();
}

class _PomodoroHomeScreenState extends State<PomodoroHomeScreen> {
  static const standardSeconds = 1500;

  int totalSeconds = standardSeconds;
  bool isRunning = false;
  int totalPomodoros = 0;
  late Timer timer; // 초기화 없이 정의하지만, 사용하기 전에 반드시 초기화되어야 함

  void onTick(Timer timer) {
    if (totalSeconds == 0) {
      setState(() {
        totalPomodoros += 1;
        isRunning = false;
        totalSeconds = standardSeconds;
      });
      timer.cancel();
      return;
    }

    setState(() {
      totalSeconds -= 1;
    });
  }

  void onStartPressed() {
    timer = Timer.periodic(const Duration(seconds: 1), onTick);
    setState(() {
      isRunning = true;
    });
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void onResetPressed() {
    setState(() {
      isRunning = false;
      totalPomodoros = 0;
      totalSeconds = standardSeconds;
    });
    timer.cancel();
  }

  String format(int seconds) {
    final duration = Duration(seconds: seconds);
    return duration.toString().split(".").first.substring(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                format(totalSeconds),
                style: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontSize: 89,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Column(
              children: [
                IconButton(
                  iconSize: 120,
                  color: Theme.of(context).cardColor,
                  onPressed: isRunning ? onPausePressed : onStartPressed,
                  icon: Icon(
                    isRunning
                        ? Icons.pause_circle_outline
                        : Icons.play_circle_outline,
                  ),
                ),
                IconButton(
                  iconSize: 40,
                  color: Theme.of(context).cardColor,
                  onPressed: onResetPressed,
                  icon: const Icon(Icons.restore_rounded),
                )
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Pomodoros",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color:
                                Theme.of(context).textTheme.displayLarge?.color,
                          ),
                        ),
                        Text(
                          "$totalPomodoros",
                          style: TextStyle(
                            fontSize: 58,
                            fontWeight: FontWeight.w600,
                            color:
                                Theme.of(context).textTheme.displayLarge?.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
