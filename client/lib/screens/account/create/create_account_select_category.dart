import 'package:flutter/material.dart';
import 'package:ssyrial/screens/account/create/ipchulgeumlist.dart';
import 'package:ssyrial/screens/account/create/Yegeumlist.dart';
import 'package:ssyrial/screens/account/create/Jukgeumlist.dart';

class CreateAccoutSelectCategory extends StatelessWidget {
  const CreateAccoutSelectCategory({super.key});



  @override
  Widget build(BuildContext context) {


    void nav_to_ipchulgeum_list() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Ipchulgeumlist()),
      );
    }
    void nav_to_yegeum_list() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Yegeumlist()),
      );
    }
    void nav_to_jukgeum_list() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Jukgeumlist()),
      );
    }


    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // 이전 화면으로 돌아가기
              },
              child: const Text('돌아가기'),
            ),
            const Text('생성할 계좌의\n종류를 선택해주세요.\n버튼을 길게 눌러\n설명을 확인하세요.'),
            ElevatedButton(
              onLongPress: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => Dialog(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text('입출금 계좌입니다. 설명 팝업 창'),
                        const SizedBox(height: 15),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Close'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              onPressed: nav_to_ipchulgeum_list ,
              child: const Text('입출금'),
            ),
            ElevatedButton(
              onLongPress: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => Dialog(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text('예금 계좌입니다. 설명 팝업 창'),
                        const SizedBox(height: 15),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Close'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              onPressed: nav_to_yegeum_list ,
              child: const Text('예금'),
            ),
            ElevatedButton(
              onLongPress: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => Dialog(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text('적금 계좌입니다. 설명 팝업 창'),
                        const SizedBox(height: 15),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Close'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              onPressed: nav_to_jukgeum_list ,
              child: const Text('적금'),
            ),
          ],
        )


      ),
    );
  }
}
