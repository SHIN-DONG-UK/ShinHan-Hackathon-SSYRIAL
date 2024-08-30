import 'package:flutter/material.dart';
import 'ipchulgeumlist.dart';
import 'jukgeumlist.dart';
import 'yegeumlist.dart';

class CreateAccoutSelectCategory extends StatelessWidget {
  const CreateAccoutSelectCategory({super.key});

  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: Image.asset(
                'assets/images/CreateAccount_select_category.png',
                // Make sure this path is correct
                fit: BoxFit.fitHeight,
              ),
            ),

            //돌아가기 버튼
            Positioned(
              top: screenwidth * 0.02,
              child: SizedBox(
                width: screenwidth,
                height: screenheight * 0.15,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },

                  child: Text(''),
                ),
              ),
            ),

            // 입출금 버튼
            // [API] 입출금 버튼 클릭 시 출금 API 끌고오기 ( 깃랩 2.4.1 )
            Positioned(
              bottom: screenheight * 0.02 + screenheight * 0.33,
              child: SizedBox(
                width: screenwidth,
                height: screenheight * 0.14,
                child: TextButton(
                  onLongPress: () => showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: Colors.transparent,
                        content: Stack(
                          children: [
                            Center(child:Image.asset(
                              'assets/images/ipchulgeum_explain.png',
                              fit: BoxFit.fitHeight,
                            ),),
                            SizedBox(
                              width: screenwidth,
                              height: screenheight,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                style: TextButton.styleFrom(
                                  overlayColor: Color(0),
                                ),
                                child: Text(""),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Ipchulgeumlist()),
                    );
                  },
                  style: TextButton.styleFrom(
                    overlayColor: Color(0),
                  ),
                  child: Text(''),
                ),
              ),
            ),

            // 예금 버튼
            // [API] 입출금 버튼 클릭 시 상품 API 끌고오기 ( 깃랩 2.5.1 )
            Positioned(
              bottom: screenheight * 0.02 + screenheight * 0.17,
              child: SizedBox(
                width: screenwidth,
                height: screenheight * 0.14,
                child: TextButton(
                  onLongPress: () => showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: Colors.transparent,
                        content: Stack(
                          children: [
                            Center(child:Image.asset(
                              'assets/images/yegeum_explain.png',
                              fit: BoxFit.fitHeight,
                            ),),
                            SizedBox(
                              width: screenwidth,
                              height: screenheight,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                style: TextButton.styleFrom(
                                  overlayColor: Color(0),
                                ),
                                child: Text(""),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),

                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Yegeumlist()),
                    );
                  },
                  style: TextButton.styleFrom(
                    overlayColor: Color(0),
                  ),
                  child: Text(''),
                ),
              ),
            ),

            //적금 버튼
            // [API] 입출금 버튼 클릭 시 상품 API 끌고오기 ( 깃랩 2.6.1 )
            Positioned(
              bottom: screenheight * 0.028,
              child: SizedBox(
                width: screenwidth,
                height: screenheight * 0.14,
                child: TextButton(
                  onLongPress: () => showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: Colors.transparent,
                        content: Stack(
                          children: [
                            Center(child:Image.asset(
                              'assets/images/jukgeum_explain.png',
                              fit: BoxFit.fitHeight,
                            ),),
                            SizedBox(
                              width: screenwidth,
                              height: screenheight,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                style: TextButton.styleFrom(
                                  overlayColor: Color(0),
                                ),
                                child: Text(""),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),

                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Jukgeumlist()),
                    );
                  },
                  style: TextButton.styleFrom(
                    overlayColor: Color(0),
                  ),
                  child: Text(''),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
