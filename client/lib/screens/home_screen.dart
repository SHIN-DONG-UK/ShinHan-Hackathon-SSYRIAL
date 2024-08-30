import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ssyrial/config/hive_config.dart';
import 'package:ssyrial/screens/register/member_registration_screen.dart';
import 'login/2.sign_in_password.dart';

// 상수 정의
const Color kAppBarBackgroundColor = Colors.white;
const Color kAppBarIconColor = Colors.black;
const Color kLoginButtonColor = Colors.blue;
const Color kAccountCreationColor = Colors.orange;
const Color kEasyScreenColor = Colors.green;

const TextStyle kAppBarTextStyle = TextStyle(color: kAppBarIconColor, fontWeight: FontWeight.bold);
const TextStyle kButtonTextStyle = TextStyle(color: Colors.white, fontSize: 18);
const TextStyle kFeatureTextStyleActive = TextStyle(color: Colors.blue);
const TextStyle kFeatureTextStyleInactive = TextStyle(color: Colors.grey);
const TextStyle kAccountCreationTextStyle = TextStyle(color: Colors.white);

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Box<dynamic> box;
  bool isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeHive();
  }

  // Hive 초기화 및 Box 열기
  Future<void> _initializeHive() async {
    await HiveConfig.init(); // Hive 초기화
    box = await HiveConfig.openBox('registrationBox');
    setState(() {
      isInitialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isInitialized) {
      return _buildLoadingScreen();
    }

    return Scaffold(
      appBar: _buildAppBar(), // AppBar 빌드
      body: Column(
        children: [
          _buildContent(), // 메인 콘텐츠 빌드
          _buildBottomNavigationBar(), // 하단 네비게이션 바 추가
        ],
      ),
    );
  }

  // 로딩 화면 빌드
  Widget _buildLoadingScreen() {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }

  // AppBar 빌드
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: kAppBarBackgroundColor, // AppBar 배경색 설정
      elevation: 0, // 그림자 제거
      leading: IconButton(
        icon: Text('홈', style: kAppBarTextStyle), // 홈 버튼 텍스트 스타일 적용
        onPressed: () {}, // 홈 버튼 눌렀을 때의 동작
      ),
      actions: [
        IconButton(icon: Icon(Icons.message, color: kAppBarIconColor), onPressed: () {}), // 메시지 아이콘
        IconButton(icon: Icon(Icons.mic, color: kAppBarIconColor), onPressed: () {}), // 마이크 아이콘
        IconButton(icon: Icon(Icons.person, color: kAppBarIconColor), onPressed: () {}), // 사용자 아이콘
      ],
    );
  }

  // 메인 콘텐츠 빌드
  Widget _buildContent() {
    return Column(
      children: [
        Image.asset('assets/images/sol_bank_logo.png', height: 90), // 은행 로고 이미지
        _buildFeatureRow(), // 기능 선택 Row 추가
        Row(
          children: [
            _buildAccountCreationButton(), // 계좌 생성 버튼 추가
            _buildEasyScreenButton(() => _handleEasyScreenButtonPress()), // 쉬운 화면 버튼 추가
          ],
        ),
      ],
    );
  }

  // 기능 선택을 위한 Row
  Widget _buildFeatureRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Row 안의 텍스트들을 균등하게 배치
      children: [
        Text('Super SOL', style: kFeatureTextStyleActive),
        Text('카드', style: kFeatureTextStyleInactive),
        Text('은행', style: kFeatureTextStyleInactive),
        Text('보험', style: kFeatureTextStyleInactive),
      ],
    );
  }

  // 계좌 생성 버튼 위젯
  Widget _buildAccountCreationButton() {
    return Container(
      height: 100, // 버튼 높이 설정
      color: kAccountCreationColor, // 버튼 배경색 설정
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // 콘텐츠를 가운데 정렬
        children: [
          Text('계좌 생성하기', style: kAccountCreationTextStyle), // 텍스트 스타일 적용
          Icon(Icons.star, color: Colors.white), // 아이콘 색상 설정
        ],
      ),
    );
  }

  // 쉬운 화면 버튼 위젯
  Widget _buildEasyScreenButton(VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed, // 쉬운 화면 버튼 눌렀을 때의 동작
      child: Container(
        height: 100, // 버튼 높이 설정
        color: kEasyScreenColor, // 버튼 배경색 설정
        child: Center(
          child: Text(
            '쉬운 화면\n실행하기',
            style: kButtonTextStyle, // 텍스트 스타일 적용
            textAlign: TextAlign.center, // 텍스트 가운데 정렬
          ),
        ),
      ),
    );
  }

  // 하단 네비게이션 바 위젯
  Widget _buildBottomNavigationBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Row 안의 아이콘과 텍스트들을 균등하게 배치
      children: [
        Column(children: [Icon(Icons.home), Text('홈')]), // 홈 아이콘과 텍스트
        Column(children: [Icon(Icons.search), Text('자산관리')]), // 자산관리 아이콘과 텍스트
        Column(children: [Icon(Icons.send), Text('상품')]), // 상품 아이콘과 텍스트
        Column(children: [Icon(Icons.account_balance), Text('혜택')]), // 혜택 아이콘과 텍스트
        Column(children: [Icon(Icons.menu), Text('전체메뉴')]), // 전체메뉴 아이콘과 텍스트
      ],
    );
  }

  // 쉬운 화면 버튼 클릭 처리
  void _handleEasyScreenButtonPress() {
    final isRegistered = box.get('isRegistrationComplete', defaultValue: false);

    if (isRegistered) {
      onLoginButtonPressed(context);
    } else {
      onEasyScreenButtonPressed(context);
    }
  }

  // 로그인 버튼을 눌렀을 때의 동작
  void onLoginButtonPressed(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignInScreen()), // SignInScreen 화면으로 이동
    );
  }

  // 쉬운 화면 버튼을 눌렀을 때의 동작
  void onEasyScreenButtonPressed(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MemberRegistrationStartScreen()), // MemberRegistrationStartScreen 화면으로 이동
    );
  }
}
