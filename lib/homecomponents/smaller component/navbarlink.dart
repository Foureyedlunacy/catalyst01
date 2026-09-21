import 'package:flutter/material.dart';

class Navbarlink extends StatelessWidget {
  final String text;
  
  const Navbarlink({ required this.text,super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton( 
              style:TextButton.styleFrom(
                              backgroundColor: Color(0xFF325453),
                              foregroundColor:Color(0xFFf8ad5c) ,
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 20,),
                              minimumSize: Size(350, 70),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(0)),
                                                  ),
              onPressed: () {
    Navigator.pushNamed(context, '/$text');
  },
              
            
              
              child: Text(text,style: TextStyle(fontSize: 20 ,fontWeight: FontWeight(10)),)
               );
  }
}