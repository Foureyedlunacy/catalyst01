import 'package:catalyst/homecomponents/components/projecttitlecard.dart';
import 'package:catalyst/homecomponents/smaller%20component/panelcol.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Hpanel extends StatelessWidget {
  const Hpanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded (child:Column( 

          children: [Container(
            padding: EdgeInsets.all(30),
            height: 200,
            decoration: BoxDecoration(gradient: LinearGradient(
              begin: Alignment.centerLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFb92a0f),

            Color(0xFFf8ad5c),
          ],
          stops: [0.0, 1.5],
          )),
            child:Column(crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
              Text( '''WELCOME''', 
    style: GoogleFonts.anta(
      textStyle: Theme.of(context).textTheme.displayLarge,
      fontSize: 64,color:  Color(0xFFf8ad5c),
      fontWeight: FontWeight.w700,
    
        ),
              ), Text( '''To CATALYST''', 
    style: GoogleFonts.anta(
      textStyle: Theme.of(context).textTheme.displayLarge,
      fontSize: 48,color:  Color(0xFFf8ad5c),
      fontWeight: FontWeight.w700,
    
        ),
              )
            ],)
          ),
          Expanded(child: Container(
            color: Color(0xFFf7e4cc),
            child: Panelcol(),
           
             

          ) )
          
         
          ],
        )
        );
  }
}