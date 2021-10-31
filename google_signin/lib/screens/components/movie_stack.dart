import 'package:flutter/material.dart';
import 'package:google_signin/provider/bottom_Nav_Provider.dart';
import 'package:provider/src/provider.dart';
import 'edit_movie_dailog.dart';
class MovieStack extends StatelessWidget {
  final String movieName;
  final String directorName;
  final String imgUrl;
  final int? id;
   MovieStack({ this.id,required this.movieName, required this.directorName, required this.imgUrl}) ;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(40.0, 5.0, 20.0, 5.0),
          height: 170.0,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(100.0, 20.0, 20.0, 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      //width: 20.0,
                      child: Text(
                        this.movieName,
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.all(5.0),
                        alignment: Alignment.center,
                        child: GestureDetector(
                            onTap: (){
                              showDialog(context: context, builder:(context)=> EditMovie(
                                directorName: this.directorName,
                                movieName: this.movieName,
                                id: this.id,
                              ));
                            },
                            child: Icon(Icons.edit,color: Colors.grey,))
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        this.directorName
                      ),
                    ),
                    SizedBox(width: 20,),
                    Container(
                      padding: EdgeInsets.all(5.0),
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: (){
                          context.read<BottomProvider>().delete(id: this.id) ;
                        },
                          child: Icon(Icons.delete,color: Colors.grey,))
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Positioned(
          left: 20.0,
          top: 15.0,
          bottom: 15.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image(
              width: 110.0,
              image: NetworkImage(
                this.imgUrl
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
