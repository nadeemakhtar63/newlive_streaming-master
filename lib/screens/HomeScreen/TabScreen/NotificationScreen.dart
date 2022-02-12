import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:newlive_streaming/Module/MeetingModel.dart';
import 'package:newlive_streaming/screens/HomeScreen/AgoraTokenScreen/index.dart';
class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  User user;
  DatabaseReference meetingRef;
  @override
  void initState() {
    // TODO: implement initState
    user = FirebaseAuth.instance.currentUser;
    if(user!=null){
      meetingRef = FirebaseDatabase.instance.reference().child("meetingSchedule").child(user.uid);

    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification"),

      ),
      body: StreamBuilder(
        stream: meetingRef != null?meetingRef.onValue:null,
        builder: (context,snapshot){
          if(snapshot.hasData && !snapshot.hasError){
            var event = snapshot.data as Event;
            var snapshot2 = event.snapshot.value;
            if(snapshot2 == null){
              return Center(
                child: Text("No Task Added Yet"),
              );
            }
            Map<String,dynamic> map = Map<String,dynamic>.from(snapshot2);
            var meetingLists = <MeetingModel>[];
            for(var meetingMap in map.values){
              MeetingModel metingModel = MeetingModel.fromMap(Map<String,dynamic>.from(meetingMap));
              meetingLists.add(metingModel);
            }
            return ListView.builder(
                itemCount: meetingLists.length,
                itemBuilder: (context,index){
                  MeetingModel model = meetingLists[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>IndexPage(
                          model.userName,
                          model.meetingTitle

                        )));
                      },
                      child: Container(
                        color: Colors.black54,
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(


                            children: [
                              Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Meeting Title : "),
                                      Text("User Name : "),
                                      Text("Meeting Date : "),
                                      Text("Meeting Id : "),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(model.meetingTitle),
                                      Text(model.userName),
                                      Text(model.meetingDate),
                                      Text(model.meetingId),
                                    ],
                                  ),
                                ],
                              )




                            ],
                          ),
                        ),
                      ),
                    ),
                  );

            });


          }else{
            return Center(child: CircularProgressIndicator(),);
          }
        },
      ),
    );
  }
}
