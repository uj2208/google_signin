import 'package:flutter/material.dart';
import 'package:google_signin/provider/bottom_Nav_Provider.dart';
import 'package:provider/src/provider.dart';

class EditMovie extends StatefulWidget {
  final int? id;
  final String movieName;
  final String directorName;
   EditMovie({ required this.movieName, required this.directorName,  this.id}) ;
  @override
  _EditMovieState createState() => _EditMovieState();
}

class _EditMovieState extends State<EditMovie> {
  TextEditingController movieController = new TextEditingController();
  TextEditingController directorController = new TextEditingController();
  @override
  void initState() {
    super.initState();
    movieController.text = widget.movieName;
    directorController.text = widget.directorName;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Text('Edit Movie'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: movieController,
                decoration: InputDecoration(hintText: "MovieName",
                ),
              ),
              SizedBox(height: 5,),
              TextField(
                controller: directorController,
                decoration: InputDecoration(hintText: "Director Name",
                ),
              ),
              SizedBox(height: 5,),

            ],
          ),
        ),
        actions: [

          ElevatedButton(onPressed: (){
           print("id"+widget.id.toString());
            Navigator.pop(context);
          },
              style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Colors.redAccent),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
              ),
              child: Icon(Icons.clear,color: Colors.white,)),
          ElevatedButton(onPressed: (){
           context.read<BottomProvider>().update(id: widget.id,directorName: directorController.text,movieName: movieController.text);
            Navigator.pop(context);
          },
              style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Theme.of(context).primaryColor),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
              ),
              child: Icon(Icons.done,color: Colors.white,)),
        ],
      ),
    );
  }
}
