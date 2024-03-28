import 'package:flutter/material.dart';
import "package:toonflix/WebtoonApp/screens/home_screen.dart";

/* [ Key ]
 * - Widget은 Flutter가 식별할 때 사용할 수 있는 key를 가지고 있다.
 * - 생성자에서 super.key를 setting (warning을 통해 생성자에 super.key를 넣는 코드가 권장된다.)
 * 
 * [ AppBar ]
 * - `foregroundColor` : Text, icon 등 색상
 * - `backgroundColor` : AppBar 배경 색상
 * - `elevation` : AppBar 경계에 shadow 처리
 * - `surfaceTintColor` : `backgroundColor`와 `elevation`을 덮어쓰는 아주 옅은 색상? Layer?
 * - `shadowColor` : `elevation` 설정 시 생기는 shadow 색상. `black`로 지정해야 좀 진하게 나온다.
 * 
 * [ Package ]
 * - pub.dev에서 package 검색 및 사용 가능
 * - Package 설치
 *   1. dart pub add {package}
 *   2. flutter pub add {package}
 *   3. `pubspec.yaml`의 `dependencies`에 사용하려는 package 명시
 * 
 * [ Import package and files ]
 * - `import package:~`
 * - `import package:~ as namespace` : 해당 package의 API를 namespace를 통해 사용
 * 
 * [ API request ]
 * - `package:http` package의 API 사용
 * - Uri.parse(uriString) : uri 생성
 * - http.get(uri) : get 요청
 * - 응답으로 `Response` type을 받음 -> `statusCode` 등 http 응답 정보 확인
 * - `dart:convert` package의 `jsonDecode`를 사용해서 String -> JSON object 변환
 * 
 * [ Future ]
 * - 비동기 실행 후 미래에 받을 값을 wrapping
 * - `await` keyword : 비동기 작업이 완료되길 기다리게 함
 * - await은 async function 안에서만 사용 -> `async` keyword
 * - `async` function은 그냥 호출할 수도 있고, `await` keyword와 함께 호출해서 기다리게 만들 수도 있음
 * 
 * [ Future data를 Widget에 그리는 방법 ]
 * 1. `StatefulWidget` 사용
 *   - `models` state variable을 만들고
 *   - `initState()`에서 await으로 `models`를 비동기적으로 받아옴
 *   - Data를 받아오면 `setState()`로 widget 갱신
 *   - `build()`가 두 번 호출됨 -> 첫 번째는 빈 models, 두 번째는 받아온 models로 그림
 * 2. `FutureBuilder` Widget 사용
 *   - State를 따로 만들지 않아도 widget 단에서 처리 가능 (거의 State를 사용하지 않음)
 *   - `StatelessWidget`을 사용해서 비동기 작업을 처리할 수 있는 장점
 *   - `Future` 변수를 직접 가짐 -> const class가 될 수 없음 (컴파일 전에 값을 알 수 없으므로)
 *   - `future` : `Future` type data
 *   - `initialData` : 초기값
 *   - `builder` : `Future` stream에서 값이 들어왔을 때 실행되어 Widget UI를 반환
 *     - 두 번 호출된다 (1. 최초 1회, 2. Future response 받은 후)
 *     - `context` : `BuildContext`를 통해 부모 Widget 정보를 받을 수 있음
 *     - `snapshot` : `AsyncSnapshot`을 통해 `Future`의 상태를 알 수 있음 (data를 받았는지, error가 발생했는지)
 *       - `hasData` : 데이터를 받았는지 여부 반환
 * 
 * [ CircularProgressIndicator ]
 * - 원으로 돌아가는 loading UI
 * 
 * [ ListView Widget ]
 * - 많은 data를 list 형태로 보여줄 때 사용하는 widget
 * - `scrollDirection` 속성을 사용해서 가로/세로 list view 구현
 * - `BoxScrollView`를 상속받아 scroll 지원
 * - `ListView(children)` : `children`으로 전달한 widget들을 한 번에 load해서 표시
 * - `ListView.builder` : optimized list view. 
 *   - `ListView(children)`은 한 번에 모든 item들을 메모리에 load하므로 성능 문제
 *   - `ListView.builder`로 만든 list view는 화면에 보이지 않는 item은 메모리에서 삭제
 *   - `itemCount` : 몇 개의 item을 load할 것인지
 *   - `itemBuilder` : item index를 가지고 사용자가 화면에 보고 있는 widget build
 *     - `index` : 현재 화면에 보이는 item의 index
 * - `ListView.separated` : list item 사이에 들어갈 widget을 지정할 수 있음
 *   - `SizedBox`를 사용하면 item마다 간격을 조절할 수 있다.
 *   - `padding` : `ListView`와 item 목록 사이 padding
 * - `ListView`는 height 정보가 없으므로, 안에 `Column`을 넣으면 Error 발생
 *   - "Horizontal viewport was given unbounded height."
 *   - `ListView`에 제한된 크기를 지정해야 함
 *   - `Expanded`는 `Row`나 `Column`의 child를 확장해서 child가 남는 공간을 채우게 함
 *   - `ListView`가 `Expanded`의 `child`로 지정되면 "남는 영역"이라는 size가 고정된 영역에 `ListView`를 그리는 것이므로 크기가 고정되어 문제 해결
 * 
 * [ Image Widget ]
 * - Image를 보여주는 widget
 * - `Image.network` : URL로부터 image를 다운로드 받아서 render
 *   - `headers` : network 요청 시 적용할 header
 *     - Simulator에서 image를 볼 수 없는 문제가 있음
 *     - 아래와 같이 `headers`를 넣어주면 해결
 *       ```
 *       headers: const {
           'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36',
           HttpHeaders.refererHeader: "https://comic.naver.com",
         },
 *       ```
 *       - `HttpHeaders.refererHeader`는 `import 'dart:io';` 필요
 * 
 * [ Container 속성 ]
 * - `BoxDecoration` : `decoration`에 넣어서 `Container` style 설정
 *   - `borderRadius`
 *   - `boxShadow` : `List<BoxShadow>` type으로, 여러 개의 shadow를 적용할 수 있음
 * - `width` 속성으로 `Container`의 크기 조정
 * - `clipBehavior`에 `Clip.hardEdge`를 넣어서 `borderRadius` 등이 적용되게 함
 * 
 * [ GestureDetector Widget ]
 * - Gesture를 감지하는 `on~` method들을 제공함
 * - `onTap`, `onTapDown`, `onTapUp`
 * 
 * [ Navigator - Transition Screen ]
 * - `StatefulWidget`을 상속받는 idget의 일종
 * - `Navigator.push(context, route)` : `route`로 화면 이동
 * - `route` : Widget을 animation 효과로 감싸서 screen처럼 보이게 만듦
 * - Routing된 widget은 이전 screen의 `Scaffold`를 떠나는 것이므로, 새 screen은 `Scaffold`를 만들어야 함
 * - `MaterialPageRoute`
 *   - `builder` : Route destination widget 반환하는 function
 *   - `fullScreenDialog`를 `true`로 설정하면 아래에서 올라오는 modal로 동작
 *   - animation은 Platform 동작을 따라감
 * 
 * [ Hero Widget ]
 * - 화면 전환 시 animation 제공
 * - 두 화면에 Hero widget을 사용하고, 각 widget에 같은 tag를 설정
 * - Animation을 적용할 특정 widget을 `Hero(tag, child)`로 감싸고,
 * - 서로 다른 두 화면에서 같은 tag를 설정하면, 두 widget의 화면 전환 이전/이후 위치를 기반으로 animation을 만들어 준다.
 * 
 * [ Open a URL at a Browser ]
 * - `url_launcher` package 사용
 * - HTTP URL 뿐만 아니라 URL scheme도 실행
 * - iOS는 `UIApplication.open(url:)`을 실행하는 것
 * 
 * [ AppBar 좌/우 버튼 넣기]
 * - `actions`에 widget을 넣음 (button widget?)
 * 
 * [ Shared Preference ]
 * - Store chunks of data in local storage
 * - `shard_preferences` package를 설치해서 사용
 * - `SharedPreferences.getInstance()`로 Instance를 얻어서 사용
 * 
 * [ Questions ]
 * - Flutter는 update가 필요한 widget을 어떻게 식별하는가?
 * - Widget key는 어떻게 사용되는가?
*/

class WebtoonApp extends StatelessWidget {
  const WebtoonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomeScreen());
  }
}
