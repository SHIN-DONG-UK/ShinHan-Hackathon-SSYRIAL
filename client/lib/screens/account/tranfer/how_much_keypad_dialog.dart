// 1. 텍스트 위젯
// 2. 박스1
//   a. 텍스트 위젯
// 3. 박스2
//   a. row1
//     - 버튼1
//     - 버튼2
//     - 버튼3
//   b. row2
//     - 버튼4
//     - 버튼5
//     - 버튼6
//   c. row3
//     - 버튼7
//     - 버튼8
//     - 버튼9
//   d. row4
//     - 버튼 : 모두 지우기
//     - 버튼 0
//     - 버튼 : 하나 지우기
// 4. 박스3
//   a. 버튼 : 취소
//   b. 버튼 : 완료
// -----------------------------------
// 1. 기능
//   a. 버튼1~9 -> 박스1.텍스트 위젯에 해당 숫자 입력
//   b. 버튼 : 모두 지우기 -> 박스1.텍스트위젯 클리어
//   c. 버튼 : 하나 지우기 -> 박스1.텍스트위젯 뒤에거 하나 삭제
//   d. 버튼 : 취소 -> 현재 팝업이 사라져
//   e. 버튼 : 완료 -> 현재 팝업이 사라져 근데, 데이터를 send_money_screen.dart의 미니박스2.텍스트위젯에 입력해