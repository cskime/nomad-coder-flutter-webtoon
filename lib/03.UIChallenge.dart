import 'package:flutter/material.dart';

/* [ Axis Widget ]
 * - `Row` : horizontal stack
 * - `Column` : vertical stack
 * - `children` widget들을 horizontal/vertical 배치
 * - alignment
 *   - Main axis(`mainAxisAlignment`) : horizontal for Row, vertical for Column
 *   - Cross axis(`crossAxisAlignment`) : opposite axis for main axis
 *   - `start` : leading
 *   - `end` : trailing
 *   - `spaceBetween` : 가운데 space를 주면서 영역을 꽉 채움
 * 
 * [ SizedBox Widget ]
 * - `SizedBox` : create space with `width` or `height`
 * 
 * [ Padding ]
 * - Border 안쪽에 padding을 추가해서 `child` widget을 그림
 * - `EdgeInsets.all()` : 상하좌우 모두에 padding 추가
 * - `EdgeInsets.only()` : padding을 추가할 방향 지정
 * - `EdgeInsets.symmetric()` : horizontal, vertical 등 semantic key로 padding 설정
 * 
 * [ Color Widget ]
 * - `Colors`에서 pre-defined color 사용
 * - `withOpacity()`로 opacity 적용
 * - `Color()`에 ARGB hex value 전달해서 color 생성
 * - `Color.fromARGB()`, `Color.fromRGBO()`에 argb value 전달해서 color 생성 (0~255)
 * 
 * [ Container Widget ]
 * - Simple box with child
 * - `decoration` : give a style to container(box)
 *   - `color` : set background color to box
 *   - `borderRadius` : set border radius -> `BorderRadius` 사용
 *     - `BorderRadius.circular()` : set radius for all edges
 * 
 * [ Icon Widget ]
 * - Show icon
 * - Icons.~ : use built-in icon data
 * - `color`, `size` : change icon's color and size
 * 
 * [ Transform Widget ]
 * - Icon 등의 크기를 키울 때, widget 자체 크기를 키우면 주변 widget들도 크기에 영향을 받음
 * - Transform widget을 통해 transformation이 적용된 widget을 사용할 수 있음 -> 
 *   - Transform.scale : 특정 widget(`child`)의 scale 변경
 *   - Transform.translate : `Offset`만큼 x,y 좌표로 특정 widget만 이동
 * 
 * [ Clip ]
 * - Box의 `clipBehavior` 속성을 설정해서 border 바깥 영역의 clip 방식 결정
 * - Clip.hardEdge
 * 
 * [ SingleChildScrollView Widget ]
 * - Child 1개를 갖는 scroll view
 * - Content overflowing 상황에서 스크롤 기능을 추가함
 * 
 * [ Const ]
 * - Compile 하기 전에 미리 알 수 있는 바뀌지 않는 변수
 * - 변수를 받는 등 compile time 또는 runtime 동작에 따라 바뀔 수 있다면 `const`를 사용할 수 없음
 * - Dart compiler는 const 변수를 위한 메모리를 할당하지 않고 값으로 바로 치환하므로 최적화에 유리
 * - 앱 실행 중 바뀌지 않을 값에 대해 `const`를 사용해서 성능을 올려볼 수 있겠다.
 * 
 * [ Dev Experience ]
 * - Code Actions on Save : silent all warnings automatically (including const warning)
 * - Code Actions : wrapping or removing for outer widget (refactoring) -> command + .
 * - Preview Flutter UI Guidelines : Show widget hierarchy
 * - Error Lens extension : show error detail on editor
 * 
 * [ Trouble Shooting ]
 * - When I should use `const`?
 * - Why I can't invoke method in `const` expression?
 * - When should I use `Container`?
 */

class UIChallengeApp extends StatelessWidget {
  const UIChallengeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFF181818),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 80),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          "Hey, Selena",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          "Wehclome back",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 18,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 80),
                Text(
                  "Total balance",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  "\$5 194 482",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 42,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 30),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    UIChallengeButton(
                      text: "Transfer",
                      bgColor: Color(0xfff1b33b),
                      textColor: Colors.black,
                    ),
                    UIChallengeButton(
                      text: "Request",
                      bgColor: Color(0xff1f2123),
                      textColor: Colors.white,
                    ),
                  ],
                ),
                const SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      "Wallets",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "View All",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const UIChallengeCurrencyCard(
                  name: "Euro",
                  code: "EUR",
                  amount: "6 428",
                  icon: Icons.euro_rounded,
                  isInverted: false,
                ),
                const UIChallengeCurrencyCard(
                  name: "Bitcoin",
                  code: "BTC",
                  amount: "9 785",
                  icon: Icons.currency_bitcoin,
                  isInverted: true,
                  order: 1,
                ),
                const UIChallengeCurrencyCard(
                  name: "Dollar",
                  code: "USD",
                  amount: "428",
                  icon: Icons.attach_money_rounded,
                  isInverted: false,
                  order: 2,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UIChallengeButton extends StatelessWidget {
  final String text;
  final Color bgColor;
  final Color textColor;

  const UIChallengeButton({
    super.key,
    required this.text,
    required this.bgColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: bgColor, borderRadius: BorderRadius.circular(45)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}

class UIChallengeCurrencyCard extends StatelessWidget {
  final String name, code, amount;
  final IconData icon;
  final bool isInverted;
  final int order;

  final _blackColor = const Color(0xff1f2123);

  Color foregroundColor(bool isInverted) {
    return isInverted ? _blackColor : Colors.white;
  }

  Color backgroundColor(bool isInverted) {
    return foregroundColor(!isInverted);
  }

  const UIChallengeCurrencyCard({
    super.key,
    required this.name,
    required this.code,
    required this.amount,
    required this.icon,
    required this.isInverted,
    this.order = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, -20 * order as double),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: backgroundColor(isInverted),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      color: foregroundColor(isInverted),
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        amount,
                        style: TextStyle(
                          color: foregroundColor(isInverted),
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        code,
                        style: TextStyle(
                          color: foregroundColor(isInverted).withOpacity(0.8),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Transform.scale(
                scale: 2.2,
                child: Transform.translate(
                  offset: const Offset(-5, 10),
                  child: Icon(
                    icon,
                    color: foregroundColor(isInverted),
                    size: 88,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
