# toonflix

- I took the lecture that makes a Webtoon app using Flutter/Dart at the Nomadcoders.
- [Go to the lecture](https://nomadcoders.co/flutter-for-beginners/lobby)

## Skills

- Dart
- Flutter

## What I learned

### Fundamentals

- App
  - Entry point, application root
  - `MaterialApp` 또는 `CupertinoApp` 둘 중 하나는 반드시 사용해야 함
  - Platform style을 지우는건 어렵지 않음
  - 전반적으로 material style이 더 완성도가 높으므로 `MaterialApp`을 사용하는 편
- `theme` : `ThemeData`로 특정 app의 color, font, shape 등의 visual properties 설정
- Scaffold
  - Screen의 뼈대가 되는 widget
  - Screen으로 사용하는 widget은 반드시 `Scaffold`를 가져야 한다.
  - `appBar` : `AppBar`를 통해 상단 bar 설정 (navigation bar 같은 것)
    - `foregroundColor` : Text, icon 등의 색상
    - `backgroundColor` : 배경 색상
    - `elevation` : App bar의 z-coordinate 설정
    - `surfaceTintColor` : App bar elevation을 위한 background color
    - `shadowColor` : Shadow color
  - `body` : 가운데 실제 content가 표시되는 영역에 그릴 widget
- Stateless / Stateful Widget
  - Stateless widget : 상태(state)를 갖지 않고 단순히 UI만 그리는 widget
    - `StatelessWidget`을 상속받는 class 1개만 사용
    - `build(context)` method를 override해서 화면에 보여줄 widget을 구성해 반환한다.
  - Stateful widget : 상태에 따라 UI를 갱신하는 매커니즘이 추가된 widget
    - `StatefulWidget`을 상속받는 widget class와 `State<Widget>`을 상속받는 state class를 쌍으로 사용
    - Widget class가 `createState()` method에서 state class instance를 반환
    - State class에서 `build(context)` method를 구현하여 UI widget을 반환함
    - State로 사용되는 변수들을 `setState(fn)` 호출과 함께 값을 변경하면 `build(context)`가 다시 호출되며 UI 갱신
    - State class 안에서 `widget` property로 stateful widget class의 instance에 접근할 수 있다.
    - `initStates()` method는 최초 1회 호출되고, 여기서 state 초기화를 진행할 수 있다.
    - Lifecycle
      1. `initState()` : 상태 초기화 시 1회 호출
      2. `build()` : UI 생성, 상태 변경 시 여러 번 호출되며 UI 갱신
      3. `dispose()` : Widget이 screen에서 제거될 때 호출
- Build Context
  - Flutter widget들은 root부터 시작해서 widget tree를 구성
  - Widget tree를 따라 `BuildContext`를 하위 widget들에 주입하여 부모-자식 widget 간에 설정을 공유할 수 있음
  - 하위 widget들이 `BuildContext`를 통해 상위 widget이 설정한 style을 가져다 사용할 수 있음
    - `Theme.of(context)` : `ThemeData` 접근
    - `Scaffold.of(context)`
    - `Navigation.of(context)`
- 화면 전환
  - `Navigator` stateful widget 사용
  - `Navigator.push(context,route)`
    - `context` : 이동하는 widget으로 context 전달
    - `route` : Animation을 사용해서 특정 widget으로 화면 전환(route)
      - `MaterialPageRoute(builder,fullscreenDialog)` : Route 종류 중 하나. iOS의 navigation push animation으로 이동
        - `builder` : 이동할 widget 반환
        - `fullscreenDialog` : `true`면 iOS의 modal transition으로 이동
  - Hero
    - 화면 전환에 사용되는 두 widget에서, 특정 widget을 지정하여 화면이 전환되는 동안 해당 widget이 부드럽게 전환되도록 만들 수 있음
    - 양 쪽에서 동일한 widget에 동일한 `tag`를 가지고 적용해야 한다.
    - `Hero(tag:child)`
      - `tag` : Flutter가 widget을 식별할 때 사용하는 identifier
      - `child` : Animation을 적용할 widget

### Widgets

- Container Widgets
  - `Container()` : Creates a widget that combines common painting, positioning, and sizing widgets.
    - `decoration` : `BoxDecoration`으로 배경 색상, border, shadow, gradient, image 등 style 설정
      - `borderRadius` : 모서리 radius 설정
        - `BorderRadius.circular()` : 모든 방향에 circular radius 설정
    - `clipBehavior` : Container border 바깥 영역을 잘라내는 방식 지정
      - `Clip.hardEdge` : Border 바깥 영역을 잘라냄. `borderRadius` 설정 시 clip을 해야 적용될 것
    - `width`, `height` : Size 지정
    - `child` : Container 안에 그릴 widget
  - `Center(child)` : `child`를 차지하는 영역의 가운데에 위치시키는 widget
  - `Padding(padding, child)` : Border 안쪽으로 padding을 준 나머지 영역에 `child` 배치
    - `EdgeInsets.all(inset)` : 모든 방향에 padding 추가
    - `EdgeInsets.only()` : `top`, `left`, `right`, `bottom` 중 지정해서 padding 적용
    - `EdgeInsets.symmetric(vertical, horizontal)` : Vertical 및 horizontal 방향으로 padding 적용
- Stack Widgets
  - `Row(children)` : `children`으로 전달된 widget list를 horizontal axis로 배치
  - `Column(children)` : `children`으로 전달된 widget list를 vertical axis로 배치
  - Axis
    - Main axis : horizontal in `Row`, vertical in `Column`
    - Cross axis : perpendicular direction of main axis
    - Start/End : 각 axis의 시작과 끝 방향 정렬 (start at left/top side)
    - Space between : Item들 사이에 균일한 space를 갖도록 배치
  - 공통 속성
    - `mainAxisAlignment` : Main axis 방향 alignment 설정
    - `crossAxisAlignment` : Cross axis 방향 alignment 설정
- Scrollable Widgets
  - `SingleChildScrollView(child)` : `child` widget이 화면 밖을 벗어날 때 scroll 할 수 있게 만들어 줌
  - ListView
    - `Column`과 달리 `children` widget들이 화면 밖을 넘어갈 때 자동으로 scroll되게 만들어 줌
    - `ListView(children)` : `children`을 한 번에 메모리에 load하므로 많은 양의 data에 사용하면 성능에 영향을 줌
    - `ListView.builder(children)` : 화면에 실제로 나타나는 widget들만 메모리에 load하여 성능 최적화
    - `ListView.separated(children)` : Item 사이에 widget을 끼워넣을 수 있음
      - `separatorBuidler` : Item 사이에 끼워 넣을 widget 반환
      - `SizedBox`를 사용하면 item 간 spacing을 주기 편하다.
    - 공통 속성
      - `padding` : `ListView`와 item container 사이 padding 설정
      - `itemCount` : Item 개수를 미리 알려줌
      - `itemBuilder` : Item widget 반환
        - `index` : 현재 화면에 나타난 widget의 index 반환 -> `List` data item을 index로 가져와서 사용하기 좋음
    - 주의할 점
      - `ListView` 안에 `Column`을 직접 넣으면 "Horizontal viewport was given unbounded height." error 발생
      - `Expanded`로 감싸서 먼저 남은 영역으로 크기를 고정시킨 뒤 `Column`을 사용해야 size가 특정될 수 있다.
- Flexible Widgets
  - `Flexible(flex,child)` : 주변 `Flexible` widget들과의 `flex` 비율을 통해 크기가 동적으로 결정됨
  - `Expanded(child)` : 화면의 남은 공간을 꽉 채우도록 크기가 확장되는 widget
    - `Column` 같이 size가 정해지지 않은 상황에서는 content에 딱 맞는 크기로 결정됨
    - `Expanded`로 감싸서 화면에서 남는 영역만큼 크기가 고정되게 만든 뒤 사용해야 함
- FutureBuilder Widget
  - `FutureBuilder(future,initialData,builder)` : 비동기적으로 반환되는 data로 UI를 그릴 때 사용하는 widget
  - `future`에 `Future` type 값을 넣으면,
  - 실제로 값이 반환되었을 때 `builder` function에 `context`와 `snapshot`이 전달됨
    - `context` : `BuildContext`가 전달되어 `build()` 안에서 처럼 widget tree의 context 사용 가능
    - `snapshot` : `AsyncSnapshot`이 전달되어 값이 실제로 반환되었을 때 data를 사용할 수 있음
      - `snapshot.data` : 실제로 반환된 data
      - `snapshot.hasData` : 반환된 data가 있는지 확인
  - Stateful widget 없이 비동기 데이터를 UI에 그릴 수 있는 장점
  - `builder` function은 두 번 호출된다.
    - 최초 호출 시에는 async data가 반환되기 전
    - 이후 실제로 data가 반환될 때 한 번 더 호출해서 widget을 그릴 수 있는 기회를 줌
- Gesture Widget
  - `GestureDetector(on~,child)` : `child`에서 발생하는 사용자 gesture를 감지하는 widget
  - `onTapUp`, `onTapDown`, `onTap` 등
- Other Widgets
  - Text
    - `Text(text,style)` : Text 표시
      - `style` : `TextStyle(color,fontSize,fontWeight)`을 사용해서 text style 설정
  - Spacer
    - `SizedBox(width, height, child)` : Fixed size를 갖는 widget
  - Color
    - `Color(value)` : Hex value로 color 생성 (`0xAARRGGBB`)
    - `Colors.red` 등으로 pre-defined color 사용
    - `withOpacity(opacity)` method로 opacity가 적용된 color 생성 가능
  - Icon
    - `Icon()` : Icon을 표시하는 widget
      - `color` : Icon 색상 설정
      - `size` : Icon size 설정 (width, height 동일)
    - `Icons.~` : Built-in icon data 사용 가능
  - Transform
    - Transform widget은 주변의 다른 widget들의 layout에 영향을 주지 않고 `child` widget의 위치, 크기를 변경한다.
    - `Transform.translate(offset,child)` : `child` widget의 위치를 `offset`만큼 이동시키는 widget
    - `Transform.scale(scale,child)` : `child` widget의 크기를 `scale`만큼 늘리는 widget
  - Button
    - `IconButton` : Icon을 갖는 button
      - `onPressed` : Button 클릭 시 호출되는 function
      - `icon` : 사용할 icon widget
  - Image
    - `Image.network` : URL로부터 image를 다운로드 받아서 보여주는 widget
      - HTTP 요청을 하므로 `headers` 속성에 HTTP header 설정 가능
      - Simulator에서는 아래와 같이 설정해야 정상적으로 동작한다.
        ```dart
        headers: const {
            'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36',
            HttpHeaders.refererHeader: "https://comic.naver.com", // import dart:io 필요
        },
        ```
  - `CircularProgressIndicator` : loading 표시에 사용하는 UI

### Features

- Package 설치
  - "pub.dev"에서 package 검색 가능
  - `pubspec.yaml`의 `dependencies`에 package를 명시한 뒤 install
  - 설치 후 `import "package:~;`처럼 사용
  - 중복되는 이름이 있다면 `import package:~ as namespace`로 package namespace를 지정해서 API 호출 가능
- Timer
  - `Timer` : `dart:async` library에 포함된 class
  - `Timer.periodic(duration,handler)` : `duration`마다 `handler`를 실행해 주는 `Timer` instance 반환
    - `Duration(hour,minute,seconds,...)` : Duration instance 생성
    - `Duration.toString()`은 `hh:mm:ss.sss` 형식 문자열을 반환하므로, 이 문자열을 parsing해서 타이머처럼 만들 수 있음
  - `Timer.cancel()`로 timer 정지
- HTTP Request
  - `package:http` package 사용
  - `Uri.parse(uriString)` : URL instance 생성
  - `http.get(url)` : url에 대한 GET 요청
  - 응답으로 받는 `Response`로부터 응답 data 사용
    - `statusCode` : Status code for response
    - `body` : Body data (`String` type)
  - `dart:convert`의 `jsonDecode`를 사용해서 `String`을 json object로 변환하여 사용 (내부적으로 `Map`인 `dynamic`?)
- Future
  - 비동기적으로 실행되는 결과를 wrapping한 type
  - 비동기 작업이 포함된 function을 `async` keyword로 표시하고, 내부에서 `await` keyword를 붙여서 실행을 대기시킴
  - `await`을 사용해야 `Future`에 들어있는 실제 type으로 가져올 수 있음
  - `await`이 없으면 `Future` type을 그대로 반환받게 되고, 비동기 작업을 기다리지 않는다.
- Open URL at browser
  - iOS의 `UIApplication.open(url:)`을 실행시키는 것과 같은 것
  - iOS에서는 safari로 web page를 연다.
  - `url_launcher` package를 설치해서 사용
  - `launchUrl` 또는 `launchUrlString`을 `await` keyword와 함께 호출
- Local storage
  - `shard_preferences` package 설치 후 사용
  - iOS의 `UserDefaults`, Android의 `SharedPreferences`를 wrapping한 것
  - Local storage에 작은 data들을 저장하고 불러올 수 있다.
  - `SharedPreferencs.getInstance()`로 instance를 가져와서 사용
  - `set~`, `get~` : data 저장 및 가져오기

### Dart

- `toString()` : 문자열로 변환
- `split(token)` : 문자열을 `token`을 기준으로 split
- `substring(start, end)` : 문자열을 `start`에서 `end` 이전 index까지 잘라서 반환
