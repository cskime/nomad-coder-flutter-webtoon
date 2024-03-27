import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/* App : 시작점, entry point
 *   - Application root 이므로 material, cupertino style 중 하나는 반드시 선택해야 함
 *   - Material style 퀄리티가 더 좋아서 MaterialApp을 사용
 *   - `home`에 화면에 보여줄 widget을 추가
 * StatelessWidget : Show something on the screen
 * build() : draw Widget
 * Scaffold : 화면의 구성, 구조 관한 것들을 가진 Widget (e.g. top bar, body 등, container widget)
 *   - appBar : 상단 bar 영역 -> `AppBar` Widget 사용
 *   - body : 가운데 content가 보이는 영
 * Center : `child` Widget을 가운데 배치
 */

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Hello Flutter"),
          backgroundColor: Colors.blue,
        ),
        body: const Center(
          child: Text("Hello World!"),
        ),
      ),
    );
  }
}
