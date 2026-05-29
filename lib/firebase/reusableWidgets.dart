
 import 'package:flutter/material.dart';
 

class uiheler{
  void my(bool tohide){
   tohide = !tohide;

 }
  static customfield(String text,IconData icon,TextEditingController con,bool tohode){
    return TextField(
      style: TextStyle(
        color: Colors.white
      ),
       controller: con,
       obscureText: tohode,
       decoration: InputDecoration(
        fillColor: Colors.blueGrey[800],
        hintText: text,
        suffixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20)
        )
       ),
    );
  }
  static button(VoidCallback VoidCallback ,String text){
    return ElevatedButton(onPressed: (){
      VoidCallback();
    }, child: Text(text),
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.lightBlueAccent,
    ),
    
    );
  }
  static alertbox(String text,BuildContext context){
    return showDialog(
      
      context : context,builder:(context){
       return AlertDialog(
        content: Container(
          height: 100,
          color: Colors.blueGrey[800],
         child:  Column(
           children: [
             Text(text,style: TextStyle(color: Colors.white),),
             SizedBox(height: 10,),
           ElevatedButton(onPressed: (){Navigator.pop(context);}, child: Text('OK'))
           ],
         )
        ),
        
        
       );
      }
    );
  }
  
}  
 
 