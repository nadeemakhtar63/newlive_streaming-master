import 'dart:convert';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:share_plus/share_plus.dart';

import 'HomeScreen/AgoraTokenScreen/settings.dart';
class New_meting extends StatefulWidget {
  final String channelName;

  /// non-modifiable client role of the page
  final ClientRole role;

  /// Creates a call page with given channel name.
  const New_meting({Key key, this.channelName, this.role}) : super(key: key);

  @override
  _New_metingState createState() => _New_metingState();
}

class _New_metingState extends State<New_meting> {

  final _users = <int>[];
  final _infoStrings = <String>[];
  bool muted = false;
   RtcEngine _engine;
  bool micchange=false;
  bool valuemchange=false;
  int valueHolder=1;
  int playvideo=0;
  String token;
  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    _engine.muteLocalAudioStream(muted);
  }
  bool audio=false;
  void _onVoiceMute() {
    setState(() {
      audio = !audio;
    });
    _engine.muteAllRemoteAudioStreams(audio);
  }
  String Linkget="";
  @override
  void dispose() {
    // clear users
    _users.clear();
    // destroy sdk
    _engine.leaveChannel();
    _engine.destroy();
    super.dispose();
  }
  // }
  Future<void> GenrateLink() async {
    final response = await http.get(
      Uri.parse("http://192.168.100.246:8080/access_token?channelName=${widget.channelName}&role=subcriber"
        // baseUrl + '/rtc/' + 'myApp' + '/publisher/uid/' +
        // uid.toString()
        // To add expiry time uncomment the below given line with the time in seconds
        // + '?expiry=45'
      ),
    );
    if (response.statusCode == 200) {
      setState(() {
        Linkget = response.body;
        Linkget = jsonDecode(token)['token'];
        print("link that we share $Linkget");
      });
    } else {
      print('Failed to fetch the token');
    }
  }
  Future<void> getToken() async {
    final response = await http.get(
      Uri.parse("http://192.168.100.246:8080/access_token?channelName=${widget.channelName}&role=subcriber&userId=1234&"
        // baseUrl + '/rtc/' + 'myApp' + '/publisher/uid/' +
        // uid.toString()
        // To add expiry time uncomment the below given line with the time in seconds
        // + '?expiry=45'
      ),
    );
    if (response.statusCode == 200) {
      setState(() {
        token = response.body;
        token = jsonDecode(token)['token'];
        print("token isssssssssssssssssss $token");
      });
    } else {
      print('Failed to fetch the token');
    }
  }
  @override
  void initState() {
    super.initState();
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.portraitDown
    // ]);
    getToken();
    // initialize agora sdk
    initialize();
  }
  Future<void> initialize() async {
    if (APP_ID.isEmpty) {
      setState(() {
        _infoStrings.add(
          'APP_ID missing, please provide your APP_ID in settings.dart',
        );
        _infoStrings.add('Agora Engine is not starting');
      });
      return;
    }

    await _initAgoraRtcEngine();
    _addAgoraEventHandlers();
    await _engine.enableWebSdkInteroperability(true);
    VideoEncoderConfiguration configuration = VideoEncoderConfiguration();
    configuration.dimensions = VideoDimensions(width: 1920, height: 1080);
    await _engine.setVideoEncoderConfiguration(configuration);
    await getToken();
    await _engine.joinChannel(token, widget.channelName, null, 0);
  }
  void _addAgoraEventHandlers() {
    _engine.setEventHandler(RtcEngineEventHandler(error: (code) {
      setState(() {
        final info = 'onError: $code';
        _infoStrings.add(info);
      });
    }, joinChannelSuccess: (channel, uid, elapsed) {
      setState(() {
        final info = 'onJoinChannel: $channel, uid: $uid';
        _infoStrings.add(info);
      });
    }, leaveChannel: (stats) {
      setState(() {
        _infoStrings.add('onLeaveChannel');
        _users.clear();
      });
    }, userJoined: (uid, elapsed) {
      setState(() {
        final info = 'userJoined: $uid';
        _infoStrings.add(info);
        _users.add(uid);
      });
    }, userOffline: (uid, elapsed) {
      setState(() {
        final info = 'userOffline: $uid';
        _infoStrings.add(info);
        _users.remove(uid);
      });
    }, firstRemoteVideoFrame: (uid, width, height, elapsed) {
      setState(() {
        final info = 'firstRemoteVideo: $uid ${width}x $height';
        _infoStrings.add(info);
      });
    }));
  }
   Future<void> _initAgoraRtcEngine() async {
    _engine = await RtcEngine.create(APP_ID);
    await _engine.enableVideo();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(widget.role);
  }
  final List name=[
    "Waqar",
    "Nadeem",
    "Hanan",
    "Sibhat",
    "Mudasir"
  ];
  bool clickColorChoose=false;
  final memeber=[
    "Interpreater",
    "Myself",
    "Team Memeber",
    "asistent",
    "Team Memeber"

  ];
  // final List images=[
  //   "https://img.freepik.com/free-photo/mand-holding-cup_1258-340.jpg?size=626&ext=jpg",
  //   "https://images.pexels.com/photos/1239291/pexels-photo-1239291.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
  //   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ9RS0WqPYh0ggoInFd6FAoyYDTyeSQhWyIUbpcSgbjs2TrosZAS0NlHHQvqGA3erMv-BU&usqp=CAU",
  //   "https://media.gettyimages.com/photos/female-entrepreneur-with-headache-sitting-at-desk-picture-id1189618227?s=612x612",
  //   "https://media.gettyimages.com/photos/mature-woman-working-from-home-picture-id1214307416?s=612x612",
  //   "https://media.gettyimages.com/photos/mature-woman-working-from-home-picture-id1214307416?s=612x612",
  // ];
  List<Widget> images() {
    final List<StatefulWidget> list = [];
    if (widget.role == ClientRole.Broadcaster) {
      list.add(RtcLocalView.SurfaceView());
    }
    _users.forEach((int uid) => list.add(RtcRemoteView.SurfaceView(uid: uid)));
    return list;
  }
// void shareScreen() async{
//   await Share.share(images[playvideo]);
// }
//   final List Screens=[
//     interpreter(),
//     Chating(),
//
//   ];
  Widget _videoView(view) {
    return Expanded(child: Container(child: view));
  }

  void _onCallEnd(BuildContext context) {
    Navigator.pop(context);
  }


  // Widget _viewRows() {
  //   final views = images();
  //   switch (views.length) {
  //     case 1:
  //       return Container(
  //           child: Column(
  //             children: <Widget>[_videoView(views[0])],
  //           ));
  //     case 2:
  //       return Container(
  //           child: Column(
  //             children: <Widget>[
  //               _expandedVideoRow([views[0]]),
  //               _expandedVideoRow([views[1]])
  //             ],
  //           ));
  //     case 3:
  //       return Container(
  //           child: Column(
  //             children: <Widget>[
  //               _expandedVideoRow(views.sublist(0, 2)),
  //               _expandedVideoRow(views.sublist(2, 3))
  //             ],
  //           ));
  //     case 4:
  //       return Container(
  //           child: Column(
  //             children: <Widget>[
  //               _expandedVideoRow(views.sublist(0)),
  //               _expandedVideoRow(views.sublist(2, 4))
  //             ],
  //           ));
  //     default:
  //   }
  //   return Container();
  // }
  Widget _expandedVideoRow(List<Widget> views) {
    final wrappedViews = views.map<Widget>(_videoView).toList();
    return Expanded(
      child: Column(
        children: wrappedViews,
      ),
    );
  }
  Widget _toolbar() {
    if (widget.role == ClientRole.Audience) return Container();
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RawMaterialButton(
            onPressed: () => _onCallEnd(context),
            child: const Icon(
              Icons.call_end,
              color: Colors.white,
              size: 35.0,
            ),
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.redAccent,
            padding: const EdgeInsets.all(15.0),
          ),
          RawMaterialButton(
            onPressed: _onSwitchCamera,
            child: const Icon(
              Icons.switch_camera,
              color: Colors.blueAccent,
              size: 20.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.white,
            padding: const EdgeInsets.all(12.0),
          )
        ],
      ),
    );
  }
  void _onSwitchCamera() {
    _engine.switchCamera();
  }
  @override
  Widget build(BuildContext context) {

   // final views = _getRenderViews();
    return Scaffold(

      body: SafeArea (  
        child: Container(
          padding: const EdgeInsets.only(top: 20),
        //  width: MediaQuery.of(context).size.width,
         // height: MediaQuery.of(context).size.height,
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.
          // ),
          color: Colors.blueGrey,
          child: Column(
            children: [
              Container(

                    height: Get.height*0.6,
                    width: double.infinity,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        _videoView(images()[playvideo]),
                        Positioned(
                            top: 20,
                            right: 20,
                            child: InkWell(
                              onTap: (){
                                GenrateLink();
                                setState(() {
                                  Share.share(Linkget);
                                });

                              },
                              child: Container(
                                decoration: BoxDecoration(
                                 // color: Colors.blue,
                                  borderRadius: BorderRadius.circular(40)
                                ),
                                child: Center(child: Icon(Icons.share,color: Colors.white,)),
                              ),
                            )),
                        Positioned(
                          bottom: 0,
                          // top: MediaQuery.of(context).size.height*0.5,
                         // left: 40,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,

                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  RawMaterialButton(
                                    onPressed: () => _onCallEnd(context),
                                    child: const Icon(
                                      Icons.call_end,
                                      color: Colors.white,
                                      size: 24.0,
                                    ),
                                    shape: const CircleBorder(),
                                    elevation: 2.0,
                                    fillColor: Colors.redAccent,
                                    padding: const EdgeInsets.all(15.0),
                                  ),
                                  RawMaterialButton(
                                    onPressed: _onSwitchCamera,
                                    child: const Icon(
                                      Icons.switch_camera,
                                      color: Colors.blueAccent,
                                      size: 24.0,
                                    ),
                                    shape: CircleBorder(),
                                    elevation: 2.0,
                                    fillColor: Colors.white,
                                    padding: const EdgeInsets.all(12.0),
                                  )
                                ],
                              ),
                              SizedBox(height: 10,)
                            ],
                          ),
                        ),
                        Positioned(child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 48),
                          alignment: Alignment.bottomCenter,
                          child: FractionallySizedBox(
                            heightFactor: 0.5,
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 48),
                              child: ListView.builder(
                                reverse: true,
                                itemCount: _infoStrings.length,
                                itemBuilder: (BuildContext context, int index) {
                                  if (_infoStrings.isEmpty) {
                                    return Text("null");  // return type can't be null, a widget was required
                                  }
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 3,
                                      horizontal: 10,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Flexible(
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 2,
                                              horizontal: 5,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.yellowAccent,
                                              borderRadius: BorderRadius.circular(5),
                                            ),
                                            child: Text(
                                              _infoStrings[index],
                                              style: TextStyle(color: Colors.blueGrey),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ))
                      ],
                    )


              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 3,
                      color: Colors.red,

                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      color: Colors.black12,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20,right: 20),
                        child: Row(
                          children: [
                            // IconButton(onPressed: (){
                            //   Navigator.push(context, MaterialPageRoute(builder: (context)=>Full_Screen(id:playvideo)));
                            // }, icon:
                            // const Icon(Icons.zoom_out_map_sharp,size: 24,)),
                            // const SizedBox(width: 10,),
                            RawMaterialButton(
                              onPressed: _onToggleMute,
                              child: Icon(
                                muted ? Icons.mic_off : Icons.mic,
                                color: muted ? Colors.white : Colors.blueAccent,
                                size: 20.0,
                              ),
                              shape: const CircleBorder(),
                              elevation: 2.0,
                              fillColor: muted ? Colors.blueAccent : Colors.white,
                             // padding: const EdgeInsets.all(12.0),
                            ),
                            IconButton(
                                onPressed: (){
                                  setState(() {
                                    _onVoiceMute;
                                    valuemchange=!valuemchange;
                                  });
                                  if(valuemchange==false)
                                    {
                                      setState(() {
                                        valueHolder=1;
                                      });
                                    }
                                  else if(valuemchange==true)
                                    {
                                      valueHolder=99;
                                    }
                                },
                                icon:valuemchange==true? Icon(Icons.volume_up,size: 24):Icon(Icons.volume_off,size: 24)),
                            Container(
                                //margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
                                child: Slider(
                                    value: valueHolder.toDouble(),
                                    min: 1,
                                    max: 5,
                                    divisions: 5,
                                    activeColor: Colors.green,
                                    inactiveColor: Colors.grey,
                                    label: '${valueHolder.round()}',
                                    onChanged: (double newValue) {
                                      setState(() {
                                        valueHolder = newValue.round();
                                      });
                                    },
                                    semanticFormatterCallback: (double newValue) {
                                      return '${newValue.round()}';
                                    }
                                )),
                            Text('$valueHolder', style: TextStyle(fontSize: 14),)

                            // IconButton(
                            //  ,)
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                    height:200,
                   child: ListView.builder(
                        itemCount: images().length,
                        itemBuilder: (BuildContext context,int index){
                          return InkWell(
                            onTap: (){
                              setState(() {
                                playvideo=index;
                             //   clickColorChoose=!clickColorChoose;
                              });
                            },
                            child: Card(
                              color:Colors.blueGrey,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 60,
                                    width: 60,
                                    // decoration: BoxDecoration(
                                    //   image: DecorationImage(image: NetworkImage(images[index]),fit: BoxFit.cover),
                                    //   border: Border.all(color: Color(0xeec6b0d4))
                                    // ),
                                  //   child:_videoView(images()[index])
                                  //  Center(child: Icon(Icons.play_circle,color: Colors.white,),),
                                  ),
                                  // SizedBox(width: 20,),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(name[index]),
                                      Row(
                                        children: [
                                          const Text("Refrence :",style: TextStyle(fontSize: 11,fontWeight: FontWeight.w300),),
                                          Text(memeber[index])
                                        ],
                                      )
                                    ],
                                  ),
                                  const Icon(Icons.play_circle,color: Colors.red,size: 34,)
                                ],
                              ),
                            ),
                          );
                        })
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),

    );

  }

}
