import 'dart:ffi';
import 'dart:math';

import 'package:agora_flutter_quickstart/agorafunc/call_taker.dart';
import 'package:agora_flutter_quickstart/app/modules/home/controllers/welcome_controller.dart';
import 'package:agora_flutter_quickstart/app/modules/home/views/list_view.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import 'package:transition/transition.dart';
//import 'package:flutter_circular_slider/flutter_circular_slider.dart';

class WelcomeView extends GetView<WelcomeController> {
  late String _channelController; // ㅇㅕㄱ에 사용자 uid insert
  //String? _channelController;
  bool _validateError = false;
  ClientRole? _role = ClientRole.Broadcaster;

  // void initState(){
  //   _channelController = controller.user.uid;
  // }

  // realtime database
  get app => null;
  final referenceDatabase = FirebaseDatabase.instance;
  final uid = 'uid';
  late DatabaseReference _uidRef;
  bool dialog_screen = false;

  @override
  void initState() {
    final FirebaseDatabase database = FirebaseDatabase(app: this.app);
    _uidRef = database.reference().child('Uids');

    initState();
  }

  @override
  Widget build(BuildContext context) {
    final ref = referenceDatabase.reference();
    int? value1;
    return Scaffold(
      //밑에 흘러내리는거 무시하는 것. 
      resizeToAvoidBottomInset: false,

      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 33.0,
        title: Text(
          "MooMooL",
          style: TextStyle(
            fontSize: 28.0,
          ),
        ),
        actions: <Widget>[
          IconButton(
            padding: EdgeInsets.fromLTRB(0, 0, 12.0, 0),
            onPressed: () {},
            //추가적인 안내가 없다면 Icons.notifications
            icon: Icon(Icons.notifications_active),
            iconSize: 22.0,
          )
        ],
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  color: Colors.white,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(
                      0,
                      MediaQuery.of(context).size.height * 0.25,
                      0,
                      MediaQuery.of(context).size.height * 0.25,
                    ),
                    width: MediaQuery.of(context).size.width,
                    //height:
                    color: Color(0xffFCF3CA),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '233,564',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 28,
                              ),
                            ),
                            Text(
                              '명의',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'helper',
                              style: TextStyle(
                                color: Colors.orange,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              '가 참여하고 있습니다.',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //WheelExample(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.37,
                      ),
                      Container(
                        padding: EdgeInsets.all(13),
                        width: MediaQuery.of(context).size.width * 0.4,
                        //157,
                        height: MediaQuery.of(context).size.height * 0.4,
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          shape: BoxShape.circle,
                        ),
                        child: ElevatedButton(
                            onPressed: () {
                              Get.bottomSheet(Popup());
                            },
                            child: Text(
                              'Ask',
                              style: TextStyle(
                                color: Colors.brown,
                                fontSize: 32,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(20),
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
          //이부분에 기존 코드가 들어감
        ),
      ),
    );
  }

  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print(status);
  }
}

class Popup extends StatelessWidget {
  final _scrollController = FixedExtentScrollController();

  static const double _itemHeight = 60;
  static const int _itemCount = 6;
  late int tap_question;
  int which_question = 0;
  late bool textbox;

  final TextEditingController _textController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClickableListWheelScrollView(
        scrollController: _scrollController,
        itemHeight: _itemHeight,
        itemCount: _itemCount,
        onItemTapCallback: (index) {
          tap_question = index;
          if (tap_question == 5) {
            textbox = true;
          } else {
            textbox = false;
          }
          if (tap_question == which_question) {
            Get.defaultDialog(
              title: "${title_name[tap_question]} 질문을 하시겠습니까?",
              // middleText: "",
              //backgroundColor:
              // titleStyle:
              textConfirm: "네!",
              textCancel: "아니요!",
              // confirmTextColor:
              // cancelTextColor:
              buttonColor: Colors.amber,
              radius: 10,
              content: textbox
                  ? TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: '도움받고 싶은 내용을 입력하세요',
                      ),
                    )
                  : Text("Helper와 연결하려면 '네!'를 클릭해주세요"),
              onConfirm: () {
                if (textbox) {
                  if (_textController.text.isNotEmpty) {
                    print(_textController.text);
                    Get.off(CallPage_taker());
                  } else {
                    Get.defaultDialog(
                        title: "도움 입력하세요", middleText: "도움 입력하세요");
                  }
                } else {
                  print(_textController.text);
                  Get.off(CallPage_taker());
                }
              },
            );
          }
        },
        child: ListWheelScrollView.useDelegate(
          controller: _scrollController,
          itemExtent: _itemHeight,
          physics: FixedExtentScrollPhysics(),
          overAndUnderCenterOpacity: 0.5,
          perspective: 0.002,
          onSelectedItemChanged: (index) {
            //다 움직이고 이거에 대한 번호를 같이 보내어서 필요한 도움이 필요하게 해야함
            print("이동 index: $index");
            which_question = index;
          },
          childDelegate: ListWheelChildBuilderDelegate(
            builder: (context, index) => _child(index),
            childCount: _itemCount,
          ),
        ),
      ),
    );
  }

  List<String> icon_name = [
    '58169',
    '57821',
    '58608', //'58214',
    '58280',
    '61894',
    '58123',
  ];
  List<String> title_name = [
    '전자기기',
    '교통',
    '해외',
    '한동학교생활',
    '가벼운 질문',
    '기타',
  ];
  List<String> subtitle_name = [
    '에 관련해서 도움이 필요해요',
    '에 관련해서 도움이 필요해요',
    '에 관련해서 도움이 필요해요',
    '에 관련해서 도움이 필요해요',
    '에 관련해서 도움이 필요해요',
    '에 관련해서 도움이 필요해요',
  ];

  Widget _child(int index) {
    return SizedBox(
      height: _itemHeight,
      child: ListTile(
        leading: Icon(
          IconData(
            int.parse("${icon_name[index]}"),
            fontFamily: 'MaterialIcons',
          ),
          size: 50,
        ),
        title: Text("${title_name[index]}"),
        subtitle: Text("${subtitle_name[index]}"),
        onTap: () {},
      ),
    );
  }
}
