import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveConfig {
  // Hive 초기화 여부를 추적하기 위한 플래그
  static bool _isInitialized = false;

  // Hive 초기화 및 필수 Box 열기
  static Future<void> init() async {
    // Hive가 이미 초기화되었는지 확인
    if (!_isInitialized) {
      // 기기의 문서 디렉토리 경로를 가져옴
      final directory = await getApplicationDocumentsDirectory();
      // Hive 초기화
      Hive.init(directory.path);
      // 초기화 플래그를 true로 설정
      _isInitialized = true;
    }
  }

  // Hive Box 열기
  static Future<Box<T>> openBox<T>(String boxName) async {
    // Hive가 초기화되지 않았다면 초기화
    if (!_isInitialized) {
      await init();
    }
    // 지정된 이름의 Box 열기
    return await Hive.openBox<T>(boxName);
  }

  // 이미 열린 Hive Box 가져오기
  static Box<T> getBox<T>(String boxName) {
    // Hive가 초기화되지 않았다면 예외 발생
    if (!_isInitialized) {
      throw Exception("HiveConfig가 초기화되지 않았습니다. Hive를 사용하기 전에 init()을 호출하세요.");
    }
    // 지정된 이름의 Box 반환
    return Hive.box<T>(boxName);
  }

  // 지정된 Hive Box 닫기
  static Future<void> closeBox(String boxName) async {
    // 지정된 Box 닫기
    await Hive.box(boxName).close();
  }

  // 모든 Hive Box 닫기
  static Future<void> closeAllBoxes() async {
    // 모든 Box 닫기
    await Hive.close();
  }
}
