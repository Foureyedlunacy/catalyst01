import 'package:catalyst/Homecomponents/smaller%20component/navbarlink.dart';
import 'package:flutter/material.dart';
//0xFFf7e4cc  champagne/skin
//0xFF325453  darkslate gray/dark blue
//0xFFf8ad5c  rajah/yellow
//0xFFb92a0f  carnelian/red

class Hnavbar extends StatelessWidget {
  const Hnavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF325453 ),
      child:Column(
    
         
          children: [
            Container(
            color: Color(0xFFb92a0f),
              
              padding: EdgeInsets.fromLTRB(20, 20, 30, 15),
              
              width:345,
              height: 140,
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
             
              children: [const CircleAvatar(
  radius:60.0, // Equivalent to a width/height of 100.0
  backgroundImage: AssetImage('../assets/imgs/profile.png'),
),
              
               Column(
              crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Expanded(
                 child: Container(
                    
                    padding: EdgeInsets.fromLTRB(10,10,0,0),
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                  Text("User Name",style: TextStyle(
                    color: Color(0xFFf8ad5c),
                    fontSize: 15,
                  ),),
                  Text("Username@gmail.com" ,style: TextStyle(
                    color: Color(0xFFf8ad5c),
                    fontSize: 15,
                  ),),
                  ]

                  )
                  )),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                      minimumSize: Size(30, 30),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(3))
                    ),
                    onPressed: (){}, 
                    child: Icon(Icons.edit, color: Color(0xFFf8ad5c),
                   ))
                ],
               )
              ],
            )
          ),Container(height: 60, width:345, padding: EdgeInsets.fromLTRB(20, 10, 150, 10), color: Color(0xFFb92a0f),       child:OutlinedButton(style: OutlinedButton.styleFrom(minimumSize: Size(100,40),
          side: BorderSide(
            color:Color(0xFFf8ad5c),
            width: 2

          ),
           backgroundColor: Colors.white,
                              foregroundColor:Color(0xFFf8ad5c) ,
            
          ),
            onPressed: (){}, child: Row(children: [ Text("Download CV"),Expanded(child: SizedBox()),Icon(Icons.download)])
         ))

          ,
            TextButton( 
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
    Navigator.pushNamed(context, '/');
  },
              
            
              
              child: Text("Projects",style: TextStyle(fontSize: 20 ,fontWeight: FontWeight(10)),)
               ),
            Navbarlink(text:"Dashboard"),
            Navbarlink(text: "GitHub"),
            Navbarlink(text: "History"),
            Navbarlink(text: "Profile"),Navbarlink(text: "Notification"),
           Expanded(
  child: Container(
    color: const Color(0xFF325453),
  ), 
),Navbarlink(text: "About"),
            Navbarlink(text: "Terms & Conditons")
              
               
          ],
        ));
  }
}