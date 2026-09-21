import 'package:catalyst/homecomponents/components/projecttitlecard.dart';
import 'package:flutter/material.dart';

class Panelcol extends StatelessWidget {
  const Panelcol({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.all(20),
    
      child:Column(
              children: [ 
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                child:Row(children: 
                    [ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:Color(0xFFf8ad5c),
                        foregroundColor: Color(0xFF325453),
                        padding: EdgeInsets.symmetric(vertical: 25, horizontal: 17),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(100)),
                        minimumSize: Size(30,30)
                      ),
                 
                      onPressed: (){}, 
                      child: Icon(Icons.add, size: 20,)),
                      SizedBox(width: 10,),
                      ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:Color(0xFFf8ad5c),
                        foregroundColor: Color(0xFF325453),
                        padding: EdgeInsets.symmetric(vertical: 25, horizontal: 17),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(100)),
                        minimumSize: Size(30,30)
                      ),
                 
                      onPressed: (){}, 
                      child: Icon(Icons.delete, size: 20,))
                  ],


              )),Projecttitlecard()
              
              ],


            ));
  }
}