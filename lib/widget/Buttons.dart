import 'package:flutter/material.dart';
import 'package:newlive_streaming/screens/AuthenticationScreen/SignIn.dart';
import 'package:newlive_streaming/screens/AuthenticationScreen/SignUp.dart';

button(String image,String name)
{
 return Padding(
   padding: const EdgeInsets.only(left: 20,right: 20),
   child: RaisedButton(
      elevation: 5.0,
      onPressed: ()
      {
        // if(_key1.currentState.validate() && _key2.currentState.validate()){
        //   databaseLogin();
        // }
      },
      padding: EdgeInsets.all(15.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      color: Colors.white,
      child:
      Row(
          mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center,
          children:[
            Image.asset(image,width: 24,height: 24,),
            SizedBox(width: 20,),
            Text(name,style: TextStyle(color: Colors.black,fontSize: 14, fontWeight: FontWeight.w600),),
          ]),
    ),
 );
}
buttonsimple(Color color,String name,BuildContext context)
{
  return Padding(
    padding: const EdgeInsets.only(left: 20,right: 20),
    child: RaisedButton(
      elevation: 5.0,
      onPressed: ()
      {
        if(name=="Sign In")
          {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>SignIn()));
          }
        else if(name=="Sign Up Free"){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));

        }
        // if(_key1.currentState.validate() && _key2.currentState.validate()){
        //   databaseLogin();
        // }
      },
      padding: EdgeInsets.all(15.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: color,
      child:
      Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
          //  Image.asset(image,width: 24,height: 24,),
          //  SizedBox(width: 20,),
            Text(name,style: TextStyle(color: Colors.black,fontSize: 18,
                fontWeight: FontWeight.w900),),
          ]
      ),
    ),
  );

}

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
