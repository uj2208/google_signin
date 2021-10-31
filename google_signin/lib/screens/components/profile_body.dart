import 'package:flutter/material.dart';
class ProfileBody extends StatelessWidget {
 final IconData icons;
 final double iconSize;
 final Color iconColor;
 final Function function;
 final String val;
 ProfileBody({required this.icons,required this.iconSize,required this.function, required this.iconColor,required this.val});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
      child: FlatButton(
        padding: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        //color: Color(0xFFD8ECF1),
        onPressed: (){
          this.function;
        },
        child: Row(
          children: [
            Icon(
              this.icons,
              color: this.iconColor,
              size: this.iconSize,
            ),
            SizedBox(width: 20),
            Expanded(child: Text(this.val)),
            Icon(Icons.arrow_forward_ios,color: Theme.of(context).primaryColor,size: 20,),
          ],
        ),
      ),
    );
  }
}
