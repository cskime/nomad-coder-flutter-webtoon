/* [ Stateful Widget ]
 * - Stateless widget은 `build()`로 UI를 그리기만 하는 역할
 * - Stateful widget은 상태에 따라 변화하는 data를 UI에 실시간으로 반영하는 widget
 * - Widget에 data를 저장하고, data의 변화에 따라 UI가 실시간으로 갱신됨
 *
 * [ StatefulWidget ]
 * - State에서 생성한 UI를 그리는 부분
 * 
 * [ State ]
 * - State of the widget : Widget에 들어갈 data와 UI
 * - 실제로 UI를 정의하는 부분
 * - State의 data를 바꾸면 UI가 새로고침 된다.
 * - `State`가 가진 data가 변경된 뒤 state를 update함
 * - `setState()`
 *   - State class에게 data가 변경되었다는 것을 알리고, `build()`가 다시 호출됨
 *   - Data를 변경한다고 항상 `build()`가 다시 호출되는건 아님
 * 
 * [ IconButton ]
 * - `onPressed` : 버튼을 눌렀을 때 실행되는 function
 * - `icon` : Button icon
 * 
 * [ Theme ]
 * - App style을 context 한 곳에서 사용 가능
 * - MaterialApp/CupertinoApp 생성 시 `theme`에 미리 style을 정의하고 있는 `ThemeData`를 설정해 둠
 *   - `textTheme` : `TextTheme` 객체를 미리 설정해 두고 사용
 * 
 * [ Widget Tree와 BuildContext ]
 * - Flutter는 App class를 시작으로 하위 Widget들이 tree 구조로 연결되어 있음
 * - `build()` method로 전달되는 `BuildContext`를 사용해서 부모 widget의 theme 등 설정을 자식 widget에서 사용할 수 있음
 * - Context는 어떤 widget의 상위 widget tree에 대한 모든 정보를 담고 있음
 * - 하위 widget에서 상위 widget의 data에 접근할 수 있게 만드는 개념
 * 
 * [ Lifecycle ]
 * 1. `initState()` : state 초기화
 *   - 대부분은 상태 변수를 직접 초기화함
 *   - 부모 요소에 의존하는 데이터를 초기화 할 때 필요
 *   - `initState()`가 `build()`보다 항상 먼저 호출되어야 함
 *   - `initState()`는 최초 1회만 호출됨
 * 2. `build()` : UI rendering
 * 3. `dispose()` : Widget이 screen에서 제거될 때 호출
 *   - Listener 구독 취소
 *   - Form의 listener로부터 벗어날 때
 *   - 기타 작업을 widget tree에서 제거되기 전에 취소할 때
 * 
 * [ Question ]
 * - Should I put the changing code in the function which is passed to the `setState` argument?
 */

import 'package:flutter/material.dart';

class StatefulWidgetApp extends StatefulWidget {
  const StatefulWidgetApp({super.key});

  @override
  State<StatefulWidgetApp> createState() => _StatefulWidgetAppState();
}

class _StatefulWidgetAppState extends State<StatefulWidgetApp> {
  int counter = 0;
  List<int> numbers = [];

  void onClicked() {
    setState(() {
      counter += 1;
      numbers.add(numbers.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: const TextTheme(
          titleLarge: TextStyle(color: Colors.red),
        ),
      ),
      home: Scaffold(
        backgroundColor: const Color(0xfff4eddb),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Click Count",
                style: TextStyle(fontSize: 30),
              ),
              StatefulWidgetCounterText(counter: counter),
              for (var number in numbers) Text("$number"),
              IconButton(
                onPressed: onClicked,
                icon: const Icon(
                  Icons.add_box_rounded,
                  size: 40,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class StatefulWidgetCounterText extends StatefulWidget {
  const StatefulWidgetCounterText({
    super.key,
    required this.counter,
  });

  final int counter;

  @override
  State<StatefulWidgetCounterText> createState() =>
      _StatefulWidgetCounterTextState();
}

class _StatefulWidgetCounterTextState extends State<StatefulWidgetCounterText> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      "${widget.counter}",
      style: TextStyle(
        color: Theme.of(context).textTheme.titleLarge?.color,
        fontSize: 30,
      ),
    );
  }
}
