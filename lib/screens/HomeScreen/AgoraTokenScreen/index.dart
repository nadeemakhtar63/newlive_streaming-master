import 'dart:async';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:intl/intl.dart';
import 'package:newlive_streaming/screens/MetingScreenDesign/newmeting.dart';
import 'package:newlive_streaming/screens/new_meting.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import './call.dart';

class IndexPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => IndexState();
}
class IndexState extends State<IndexPage> {
  final _channelController = TextEditingController();
  final _NameController = TextEditingController();
  final _joinController = TextEditingController();
  String yearChoose = '';
  String monthChoose = '';
  String dayChoose = '';
  static final DateFormat dayformate = DateFormat('dd');
  static final DateFormat yearformate = DateFormat('yyyy');
  static final DateFormat monthformat = DateFormat('MMMM');
   String selectMonthDay = "";
  DateTime _selectedValue = DateTime.now();
  DatePickerController _controller = DatePickerController();
  bool _validateError = false;
  bool joincheck = true;
  bool createcheck = false;
  bool scedualescolor = false;
  bool scedualecheck = false;
  bool metingTitle = false;
  bool metingUName = false;
  bool meeting = false;
  bool genratLink = false;
  String _linkMessage;
  bool _isCreatingLink = false;

  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
  final String _testString =
  'join video';

  final String DynamicLink = 'https://wwww.google.com';
  final String Link = 'https://lsukapp.page.link/n3UL';

// @override
// void initState() {
// super.initState();
// initDynamicLinks();
// }

  Future<void> initDynamicLinks() async {
  dynamicLinks.onLink.listen((dynamicLinkData) {
  Navigator.pushNamed(context, dynamicLinkData.link.path);
  }).onError((error) {
  print('onLink error');
  print(error.message);
  });
  }

  Future<void> _createDynamicLink(bool short) async {
  setState(() {
  _isCreatingLink = true;
  });

  final DynamicLinkParameters parameters = DynamicLinkParameters(
  uriPrefix: 'https://lsukapp.page.link/n3UL',
  link: Uri.parse(DynamicLink),
  androidParameters: const AndroidParameters(
  packageName: 'com.example.video_app_lsuk',
  minimumVersion: 0,
  ),
  iosParameters: const IOSParameters(
  bundleId: 'io.invertase.testing',
  minimumVersion: '0',
  ),
  );
  // getValue ()async{
  //   setState(()async {
  //     // url=await AppUtile.buildDynmicLink();\
  //     final PendingDynamicLinkData? data =
  //     await dynamicLinks.getInitialLink();
  //     final Uri? deepLink = data?.link;
  //
  //     if (deepLink != null) {
  //       // ignore: unawaited_futures
  //       Navigator.pushNamed(context, deepLink.path);
  //     }
  //   });
  // }
  Uri url;
  if (short) {
    final ShortDynamicLink shortLink =
    await dynamicLinks.buildShortLink(parameters);
    url = shortLink.shortUrl;
  } else {
    url = await dynamicLinks.buildLink(parameters);
  }
  setState(() {
    _linkMessage = url.toString();
    _isCreatingLink = false;
  });
  }
  ClientRole _role = ClientRole.Broadcaster;
  @override
  void dispose() {
    // dispose input controller
    _channelController.dispose();
    super.dispose();
  }
 // late String url = "link";
  bool createmeting = false;
  bool joinmeting = true;
 Future<void> getlink()async{
   final PendingDynamicLinkData data =
   await dynamicLinks.getInitialLink();
   final Uri deepLink = data?.link;
   if (deepLink != null) {
     // ignore: unawaited_futures
     Navigator.pushNamed(context, deepLink.path);
   }
   if (_linkMessage != null) {
     await launch(_linkMessage);
   }
 }
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('SHARE LINK AND JOIN '),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(_linkMessage == null ? '' : _testString),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Live'),
              onPressed: () {
                Navigator.of(context).pop();
                onJoin();
              },
            ),
            TextButton(
              child: Text('Invite Friends'),
              onPressed: () {
                sharesocial();
                Navigator.of(context).pop();
               // onJoin();
              },
            ),
          ],
        );
      },
    );
  }
sharesocial()async{
   await FlutterShare.share(title: _linkMessage,text: _linkMessage);
}
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return Scaffold(
        backgroundColor: Color(0x95c7b0b0),
        // appBar: AppBar(
        //   title: Center(child: const Text('LSUK Video App')),
        // ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                SizedBox(height: 30,),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                          onTap: () {
                            setState(() {
                              createmeting = true;
                              joinmeting = false;
                              scedualescolor = false;
                              createcheck = true;
                              joincheck = false;
                              scedualecheck = false;
                             // genratLink=true;
                           });

                          },
                          child: metingblocks(createmeting, context, 'Create Meting')
                      ),
                      InkWell(
                          onTap: () {
                            setState(() {
                              joinmeting = true;
                              createmeting = false;
                              scedualescolor = false;

                              createcheck = false;
                              joincheck = true;
                              scedualecheck = false;
                            });
                          },
                          child: metingblocks(
                              joinmeting, context, 'Join Meting')
                      ),
                      InkWell(
                          onTap: () {
                            setState(() {
                              joinmeting = false;
                              createmeting = false;
                              scedualescolor = true;

                              createcheck = false;
                              joincheck = false;
                              scedualecheck = true;
                            });
                          },
                          child: metingblocks(
                              scedualescolor, context, 'Schedule\nMeting')
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  child: createcheck ? Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Center(
                         child: Text("Create New Meting", style: TextStyle(
                           fontSize: 22, fontWeight: FontWeight.bold,
                            color: Colors.deepPurple),)),
                        SizedBox(height: 30,),
                        textField(
                            'Meting Title', _channelController, metingTitle,
                            TextInputType.text, 1, 1),
                        SizedBox(height: 30,),

                        textField('UserName', _NameController, metingUName,
                            TextInputType.text, 1, 1),
                       // SizedBox(height: 30,),
                        // InkWell(
                        //   onTap: () async {
                        //     if (_linkMessage != null) {
                        //       await launch(_linkMessage!);
                        //     }
                        //   },
                        //   onLongPress: () {
                        //     Clipboard.setData(ClipboardData(text: _linkMessage));
                        //     ScaffoldMessenger.of(context).showSnackBar(
                        //       const SnackBar(content: Text('Copied Link!')),
                        //     );
                        //   },
                        //   child: Text(
                        //     _linkMessage ?? '',
                        //     style: const TextStyle(color: Colors.blue),
                        //   ),
                        // ),
                        // Text(_linkMessage == null ? '' : _testString),
                        SizedBox(height: 30,),
                        // Padding(
                        //   padding: EdgeInsets.only(right: 20),
                        //   child: Align(
                        //       alignment: Alignment.centerLeft,
                        //     child:InkWell(
                        //       onTap: ()  {
                        //         // final PendingDynamicLinkData? data =
                        //         // await dynamicLinks
                        //         //     .getDynamicLink(Uri.parse(Link));
                        //         // final Uri? deepLink = data?.link;
                        //         // if (deepLink != null) {
                        //         //   // ignore: unawaited_futures
                        //         //   Navigator.pushNamed(context, deepLink.path);
                        //         // }
                        //       }
                        //     ),
                        //
                        //       // child: InkWell(
                        //       //     onTap:()async{
                        //       //
                        //       //   // url=await AppUtile.buildDynmicLink();\
                        //       //   final PendingDynamicLinkData? data =
                        //       //   await dynamicLinks.getInitialLink();
                        //       //   final Uri? deepLink = data?.link;
                        //       //
                        //       //   if (deepLink != null) {
                        //       //     // ignore: unawaited_futures
                        //       //     Navigator.pushNamed(context, deepLink.path);
                        //       //
                        //       // };
                        //       //   // Share.share(deepLink);
                        //       //   // Clipboard.setData(ClipboardData(text:url));
                        //       //   // ScaffoldMessenger.of(context).showSnackBar(
                        //       //   //     const SnackBar(content: Text('Copied Link!')));
                        //       //     },
                        //       //     child: Text("Invite Friend",style: TextStyle(fontSize: 24,color: Colors.deepPurple),))
                        //   ),
                        // ),
                        InkWell(
                          onTap: () async {
                            if (_linkMessage != null) {
                              await launch(_linkMessage);
                            }
                          },
                          onLongPress: () {
                            Clipboard.setData(ClipboardData(text: _linkMessage));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Copied Link!')),
                            );
                          },
                          child: Text(
                            _linkMessage ?? '',
                            style: const TextStyle(color: Colors.blue),
                          ),
                        ),
                        //Text(_linkMessage == null ? '' : _testString),
                        SizedBox(height: 30,),
                        InkWell(
                            onTap:() {
                             _createDynamicLink(false);
                              _showMyDialog();
                            },

                            // {
                            //   try {
                            //   //  getlink();
                            //
                            //   //  onJoin();
                            //   }
                            //   catch (e) {
                            //     print(e.toString());
                            //   }
                            //   setState(() {});
                            // },
                            child: ButtonDesign(
                              "Create", context, Colors.deepPurple,)
                        ),
                      ],
                    ),
                  ) : joincheck ? Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Center(child: Text("Meting Join", style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold,
                            color: Colors.deepPurple),)),
                        SizedBox(height: 30,),
                        textField('UserName', _NameController, _validateError,
                            TextInputType.text, 1, 1),
                        SizedBox(height: 30,),
                         textField(
                            'link', _NameController, _validateError,
                            TextInputType.multiline, 1, 5) ,
                        SizedBox(height: 30,),
                        InkWell(
                            onTap: ()  {
                              try {
                                 onJoin();
                              CallPage();
                              }
                              catch (e) {
                                print(e.toString());
                              }
                              setState(() async{});
                            },
                            child: ButtonDesign("Join", context, Colors
                                .deepPurple,)
                        ),
                      ],
                    ),
                  ) : scedualecheck ? Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Center(child: Text(
                          "Schedule Meting", style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold,
                            color: Colors.deepPurple),)),
                        SizedBox(height: 30,),
                        Container(
                          child: DatePicker(
                            DateTime.now(),
                            width: 60,
                            height: 80,
                            controller: _controller,
                            initialSelectedDate: DateTime.now(),
                            selectionColor: selectMonthDay == null
                                ? Colors.red
                                : Colors.deepPurple,
                            selectedTextColor: Colors.white,
                            // inactiveDates: [
                            //   DateTime.now().add(Duration(days: 1)),
                            //   DateTime.now().add(Duration(days: 3)),
                            //   DateTime.now().add(Duration(days: 4)),
                            //   DateTime.now().add(Duration(days: 7))
                            // ],
                            onDateChange: (date) {
                              // New date selected
                              setState(() {
                                _selectedValue = date;
                                selectMonthDay = dayformate.format(date);
                                yearChoose = yearformate.format(date);
                                monthChoose = monthformat.format(date);
                                dayChoose = dayformate.format(date);
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 30,),
                        textField(
                            'Meting Title', _channelController, _validateError,
                            TextInputType.text, 1, 1),
                        SizedBox(height: 30,),
                        textField('UserName', _NameController, _validateError,
                            TextInputType.text, 1, 1),
                        SizedBox(height: 30,),
                        InkWell(
                            onTap: () async {
                              try {
                              //  onJoin();
                                CallPage();
                                // url=await AppUtile.buildDynmicLink();
                              }
                              catch (e) {
                                print(e.toString());
                              }
                              setState(() {});
                            },
                            child: ButtonDesign("Schedule", context, Colors
                                .deepPurple,)
                        ),
                      ],
                    ),
                  ) : null,
                )
              ],
            ),
          ),
        )
      // Container(
      //   padding: const EdgeInsets.symmetric(horizontal: 20),
      //   height: 400,
      //   child: Column(
      //     children: <Widget>[
      //       Row(
      //         children: <Widget>[
      //           Expanded(
      //           child:TextField(
      //                 autocorrect: true,
      //                 controller: _channelController,
      //                 style: TextStyle(color: Color(0xff3D4864)),
      //                 decoration: InputDecoration(
      //                     fillColor: Color(0xFFFFFFFF),
      //                     filled: true,
      //                     border: OutlineInputBorder(
      //                         borderRadius: BorderRadius.circular(80),
      //                         borderSide: new BorderSide(color: Color(0xff3D4864))
      //                     ),
      //                     enabledBorder:  OutlineInputBorder(
      //                       borderRadius: BorderRadius.circular(80),
      //                       borderSide:  BorderSide(color: Color(0xff3D4864), width: 0.0),
      //                     ),
      //                     focusedBorder: OutlineInputBorder(
      //                       borderRadius: BorderRadius.circular(80),
      //                       borderSide:  BorderSide(color: Color(0xff3D4864), width: 0.0),
      //                     ),
      //                     hintText: "Enter Channel Name",
      //                     hintStyle: TextStyle(color: Color(0xff3D4864)),
      //                     errorText: _validateError?"channel name Required*":null
      //                 ),
      //               ),
      //               // child: TextField(
      //               //   controller: _channelController,
      //               //   decoration: InputDecoration(
      //               //     errorText:
      //               //     _validateError ? 'Channel name is mandatory' : null,
      //               //     border: UnderlineInputBorder(
      //               //       borderSide: BorderSide(width: 1),
      //               //     ),
      //               //     hintText: 'Channel name',
      //               //   ),
      //               // )
      //           )
      //         ],
      //       ),
      //       Column(
      //         children: [
      //           ListTile(
      //             onTap: ()async{
      //               try{
      //           url=await AppUtile.buildDynmicLink();
      //               }
      //               catch(e){
      //                 print(e.toString());
      //               }
      //           setState(() {});
      //             },
      //             title: Text("Create Meting and share link"),
      //             leading: Radio(
      //               value: ClientRole.Broadcaster,
      //               groupValue: _role,
      //               onChanged: (ClientRole? value) {
      //                 setState(() {
      //                   _role = value;
      //                 });
      //
      //               },
      //             ),
      //           ),
      //           // ListTile(
      //           //   title: Text(ClientRole.Audience.toString()),
      //           //   leading: Radio(
      //           //     value: ClientRole.Audience,
      //           //     groupValue: _role,
      //           //     onChanged: (ClientRole? value) {
      //           //       setState(() {
      //           //         _role = value;
      //           //       });
      //           //     },
      //           //   ),
      //           // )
      //         ],
      //       ),
      //       Padding(
      //         padding: const EdgeInsets.symmetric(vertical: 20),
      //         child: Row(
      //           children: <Widget>[
      //             Expanded(
      //               child: ElevatedButton(
      //                 onPressed: onJoin,
      //                 child: Text('Join'),
      //                 style: ButtonStyle(
      //                     backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
      //                     foregroundColor: MaterialStateProperty.all(Colors.white)
      //                 ),
      //               ),
      //             ),
      //             // Expanded(
      //             //   child: RaisedButton(
      //             //     onPressed: onJoin,
      //             //     child: Text('Join'),
      //             //     color: Colors.blueAccent,
      //             //     textColor: Colors.white,
      //             //   ),
      //             // )
      //           ],
      //         ),
      //       )
      //     ],
      //   ),
      // ),
      // ),
    );
  }

  Future<void> onJoin() async {
    // update input validation
    setState(() {
      _channelController.text.isEmpty
          ? _validateError = true
          : _validateError = false;
    });
    if (_channelController.text.isNotEmpty) {
      // await for camera and mic permissions before pushing video page
      await _handleCameraAndMic(Permission.camera);
      await _handleCameraAndMic(Permission.microphone);
      // push video page with given channel name
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              New_meting(
                channelName: _channelController.text,
                role: _role,
              ),
        ),
      );
    }
  }

  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print(status);
  }
}
