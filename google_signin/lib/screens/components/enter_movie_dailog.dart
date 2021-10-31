import 'package:flutter/material.dart';
import 'package:google_signin/provider/bottom_Nav_Provider.dart';
import 'package:provider/src/provider.dart';
class EnterMovieDailog extends StatefulWidget {
  final String cred_val;

  const EnterMovieDailog({ required this.cred_val}) ;

  @override
  State<EnterMovieDailog> createState() => _EnterMovieDailogState();
}

class _EnterMovieDailogState extends State<EnterMovieDailog> {
  TextEditingController movieController = new TextEditingController();
  TextEditingController directorController = new TextEditingController();
  TextEditingController urlController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Text('Add Movie'),
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
              TextField(
                controller: urlController,
                decoration: InputDecoration(hintText: "Poster Url"),
              )
            ],
          ),
        ),
        actions: [

          ElevatedButton(onPressed: (){
            print(widget.cred_val);
            Navigator.pop(context);
          },
              style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Colors.redAccent),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
              ),
              child: Icon(Icons.clear,color: Colors.white,)),
          ElevatedButton(onPressed: (){
            context.read<BottomProvider>().insert(cred_val: widget.cred_val,directorName: directorController.text,
            photoUrl: 'https://www.nawpic.com/media/2020/avengers-nawpic-13.jpg',
            movieName: movieController.text
            );
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
