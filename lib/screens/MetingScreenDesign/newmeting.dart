import 'package:flutter/material.dart';

textField(String title,_channelController,bool _validateError,type,min,max){
return Container(
  padding: const EdgeInsets.symmetric(horizontal: 20),
  child: Column(
    children: <Widget>[
      Row(
        children: <Widget>[
          Expanded(
          child:TextField(
                autocorrect: true,
                controller: _channelController,
                style: TextStyle(color: Color(0xff3D4864)),
                decoration: InputDecoration(

                    fillColor: Color(0xFFFFFFFF),
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(80),
                        borderSide: new BorderSide(color: Color(0xff3D4864))
                    ),
                    enabledBorder:  OutlineInputBorder(
                      borderRadius: BorderRadius.circular(80),
                      borderSide:  BorderSide(color: Color(0xff3D4864), width: 0.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(80),
                      borderSide:  BorderSide(color: Color(0xff3D4864), width: 0.0),
                    ),

                    hintText: title,
                    hintStyle: TextStyle(color: Color(0xff3D4864)),

                    errorText: _validateError?"channel Title Required*":null
                ),
            keyboardType: type,
            minLines: min,
            maxLines: max,
              ),

          )
        ],
      )

  ]
  )
);
}
LinkCopyDesign(String link,BuildContext context){
  return Container(
    padding: EdgeInsets.only(left: 10,right: 10),
    height: 40,
    width: MediaQuery.of(context).size.width*0.8,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10)
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(link,style: TextStyle(fontSize: 22,fontWeight: FontWeight.w900,color: Colors.white),),
        Icon(Icons.copy)
      ],
    ),
  );
}
ButtonDesign(String title,BuildContext context,color){
  return Container(
    height: 40,
    width: MediaQuery.of(context).size.width*0.8,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(20)
    ),
    child: Center(
      child: Text(title,style: TextStyle(fontSize: 22,fontWeight: FontWeight.w900,color: Colors.white),),
    ),
  );
}
metingblocks(bool joinmeting,BuildContext context,String title ){
  return Container(
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          spreadRadius: 4,
          color: Color(0x95c7b0b0),
          offset: Offset(2, 2),
          blurRadius: 2,
        ),
      ],
      color:joinmeting? Colors.deepPurple:Colors.green,
      borderRadius: BorderRadius.circular(20),
    ),
    width: MediaQuery.of(context).size.width/4,
    height: 80,

    child: Center(
      child: Text(title,style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.white),),
    ),
  );
}