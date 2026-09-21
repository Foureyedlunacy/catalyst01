
import 'package:catalyst/homecomponents/h_panel.dart';
import 'package:catalyst/homecomponents/h_navbar.dart';
import 'package:flutter/material.dart';
//0xFFf7e4cc  champagne/skin
//0xFF325453  darkslate gray/dark blue
//0xFFf8ad5c  rajah/yellow
//0xFFb92a0f  carnelian/red

import 'package:google_fonts/google_fonts.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return    Scaffold(
      appBar: AppBar(
        title: Container(
         
          padding: EdgeInsets.fromLTRB(10, 0, 60, 0),
          child:Row(
          children: [
            TextButton(onPressed: () {}, style: TextButton.styleFrom( padding: EdgeInsets.symmetric(vertical: 2,horizontal: 2),
            minimumSize: Size(1,1) ,  maximumSize: Size(32, 32)       ), child: Icon(Icons.menu,size: 30, color: Color(0xFFf8ad5c ),)),
            const SizedBox(width:30),
             Text("Catalyst", style: GoogleFonts.anta(
      textStyle: Theme.of(context).textTheme.displayLarge,
      fontSize: 48,
      fontWeight: FontWeight.w700,
      color: Color(0xFFf8ad5c )
    
        ) ),
            const Expanded(child: SizedBox()),
            const Text('Projects', style: TextStyle(
              color: Color(0xFFf8ad5c)
            )  ),
            const SizedBox(width: 30,),
            TextButton( style: TextButton.styleFrom(
              backgroundColor: Color(0xFF325453),
              foregroundColor: Color(0xFFf8ad5c)
              ,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(5),
                side: const BorderSide( color: Color(0xFFf8ad5c), width: 3)
              )

            ) ,onPressed: (){}, child: const Text("SIGNIN/UP"))
          ],)
        ),
        
        
        backgroundColor: Color(0xFF325453),
        
      
      ),
    body : Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [Hnavbar(),Hpanel()],
    ), 
                  
   );
  }
}