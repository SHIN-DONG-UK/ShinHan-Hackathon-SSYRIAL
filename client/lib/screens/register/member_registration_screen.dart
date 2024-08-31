import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:ssyrial/config/constants.dart';
import 'package:ssyrial/screens/register/finish_member_registration.dart';
import 'package:ssyrial/screens/register/personal_info_consent_screen.dart';
import 'package:ssyrial/screens/register/phone_auth_screen.dart';
import 'package:ssyrial/screens/register/start_screen.dart';
import 'personal_information_input_screen.dart';

enum ScreenState {
  start,
  personalInfoConsent,
  phoneAuth,
  personalInfoInput,
  finishMemberRegistration
}

class MemberRegistrationStartScreen extends StatefulWidget {
  const MemberRegistrationStartScreen({Key? key}) : super(key: key);

  @override
  _MemberRegistrationStartScreenState createState() =>
      _MemberRegistrationStartScreenState();
}

class _MemberRegistrationStartScreenState
    extends State<MemberRegistrationStartScreen> {
  ScreenState _currentScreen = ScreenState.start;
  final PageController _pageController = PageController();
  final AudioPlayer _audioPlayer = AudioPlayer(); // 오디오 플레이어 인스턴스 생성
  bool _isAuthenticated = false;
  bool _allConsentsChecked = false;
  String _currentVoiceScript = ""; // 현재 음성 스크립트
  List<String> _audioQueue = []; // 오디오 파일 순서 리스트
  List<String> _scriptQueue = []; // 대사 스크립트 순서 리스트
  int _currentAudioIndex = 0; // 현재 재생 중인 오디오 인덱스

  @override
  void initState() {
    super.initState();
    _audioPlayer.onPlayerComplete.listen((event) {
      _playNextAudio(); // 현재 오디오가 끝나면 다음 오디오 재생
    });
    _playVoiceForCurrentScreen(); // 초기 화면 상태에 맞는 음성 재생
  }

  @override
  void dispose() {
    _audioPlayer.dispose(); // 위젯이 해제될 때 오디오 플레이어도 해제
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldBackgroundColor,
      resizeToAvoidBottomInset: false, // 키보드가 올라와도 화면 크기를 조정하지 않도록 설정
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(kPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildActionButton(
                  context, '취소하기', kCancelButtonColor, _onCancelPressed),
              const SizedBox(height: 20),
              Expanded(
                child: Stack(
                  children: [
                    _buildPageView(),
                    Positioned(
                      left: 0,
                      bottom: 0,
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/moli.gif', // 예시 이미지
                            width: 100,
                            height: 100,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            _currentVoiceScript, // 현재 음성 스크립트 표시
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _buildNextButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPageView() {
    return PageView(
      controller: _pageController,
      onPageChanged: (index) {
        setState(() {
          _currentScreen = ScreenState.values[index];
          _playVoiceForCurrentScreen(); // 페이지 변경 시 음성 재생
        });
      },
      physics: const NeverScrollableScrollPhysics(),
      children: [
        StartScreen(),
        PersonalInfoConsentScreen(
          onAllConsentsChecked: _onAllConsentsChecked, // 콜백 전달
        ),
        PhoneAuthScreen(),
        PersonalInformationInputScreen(
          onAuthenticationSuccess: _onAuthenticationStart,
        ),
        FinishMemberRegistrationScreen()
      ],
    );
  }

  void _playVoiceForCurrentScreen() {
    switch (_currentScreen) {
      case ScreenState.start:
        _audioQueue = ['sounds/1.mp3'];
        _scriptQueue = ["안녕하세요! 회원가입을 성공적으로 마칠 수 있도록 도와드릴게요!"];
        break;
      case ScreenState.personalInfoConsent:
        _audioQueue = [
          'sounds/2.mp3',
          'sounds/3.mp3',
          'sounds/4.mp3',
          'sounds/10.mp3',
          'sounds/5.mp3',
          'sounds/6.mp3'
        ];
        _scriptQueue = [
          "우선 은행이 사용자를 알 수 있어야 해요.",
          "다른 사용자가 내 계좌에서 돈을 빼 가면 안되잖아요?",
          "그런 일을 방지하기 위해 은행에서 몇 가지 정보를 받고 있어요.",
          "바로 할 수는 없고, 사용자 동의가 있어야만 할 수 있어요.",
          "은행이 받을 정보는 이름, 생년월일, 성별이 있어요.",
          "정보 제공에 동의하시나요?"
        ];
        break;
      case ScreenState.phoneAuth:
        _audioQueue = [
          'sounds/7.mp3',
          'sounds/8.mp3',
          'sounds/9.mp3',
          'sounds/10.mp3',
          'sounds/6.mp3'
        ];
        _scriptQueue = [
          "다음으로, 이 전화기가 본인의 것인지 확인해야 해요.",
          "다른 사람이 나인 척 하면서 내 계좌에 접근하는 것을 막으려고 해요.",
          "그 목적을 달성하기 위해 은행에서 몇 가지 정보를 받고 있어요.",
          "바로 할 수는 없고, 사용자 동의가 있어야만 할 수 있어요.",
          "정보 제공에 동의하시나요?"
        ];
        break;
      case ScreenState.personalInfoInput:
        _audioQueue = ['sounds/11.mp3'];
        _scriptQueue = ["이름과 생년월일을 입력해주세요."];
        break;
      case ScreenState.finishMemberRegistration:
        _audioQueue = ['sounds/12.mp3'];
        _scriptQueue = ["짠! 회원가입이 완료되었어요!"];
        break;
      default:
        _audioQueue = [];
        _scriptQueue = [];
        _currentVoiceScript = ""; // 기본적으로 빈 문자열로 설정
        return;
    }
    _currentAudioIndex = 0;
    _playNextAudio(); // 첫 오디오 파일 재생
  }

  void _playNextAudio() {
    if (_currentAudioIndex < _audioQueue.length) {
      setState(() {
        _currentVoiceScript = _scriptQueue[_currentAudioIndex]; // 대사 스크립트 업데이트
      });
      _audioPlayer.play(AssetSource(_audioQueue[_currentAudioIndex]));
      _currentAudioIndex++;
    }
  }

  void _onAllConsentsChecked(bool allChecked) {
    setState(() {
      _allConsentsChecked = allChecked; // 모든 항목 체크 상태 업데이트
    });
  }

  void _onAuthenticationStart() {
    setState(() {
      _isAuthenticated = true;
    });
  }

  Widget _buildNextButton() {
    return Visibility(
      visible: _canProceed(),
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      child:
          _buildActionButton(context, '다음', kNextButtonColor, _onNextPressed),
    );
  }

  Future<void> _onNextPressed() async {
    int nextIndex = (_currentScreen.index + 1) % ScreenState.values.length;
    setState(() {
      _currentScreen = ScreenState.values[nextIndex];
      _playVoiceForCurrentScreen(); // 다음 페이지로 이동 시 음성 재생
    });
    _pageController.animateToPage(
      nextIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onCancelPressed() {
    Navigator.pop(context);
  }

  bool _canProceed() {
    switch (_currentScreen) {
      case ScreenState.personalInfoConsent:
        return _allConsentsChecked; // 모든 항목이 체크된 경우에만 "다음" 버튼이 활성화
      case ScreenState.personalInfoInput:
        return _isAuthenticated; // 인증이 완료된 경우에만 "다음" 버튼이 보임
      case ScreenState.finishMemberRegistration:
        return false; // 마지막 페이지에는 "다음" 버튼 비활성화
      default:
        return true;
    }
  }

  Widget _buildActionButton(
      BuildContext context, String label, Color color, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: kButtonBorderRadius,
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: kButtonFontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
