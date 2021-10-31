import 'dart:collection';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_signin/dbHandler/db_handler.dart';
import 'package:google_signin/enum/bottom_nav_enum.dart';
import 'package:google_signin/models/movie.dart';
import 'package:google_signin/provider/bottom_Nav_Provider.dart';
import 'package:provider/provider.dart';
import '../provider/google_sign_in.dart';
import 'components/enter_movie_dailog.dart';
import 'components/movie_stack.dart';
import 'components/profile_body.dart';
class LoggedInWidget extends StatefulWidget {

  @override
  State<LoggedInWidget> createState() => _LoggedInWidgetState();
}

class _LoggedInWidgetState extends State<LoggedInWidget> {
  List<Icon>iconData=[Icon(FontAwesomeIcons.home),
    Icon(FontAwesomeIcons.search), Icon(FontAwesomeIcons.twitch),
    Icon(FontAwesomeIcons.shoppingCart),Icon(FontAwesomeIcons.idBadge)];

  List<String>data =['Home','Seach','Twitch','Cart','ID'];
  List<Map<String,String>>newsData = [];
  Map<String,String> newsMap = new HashMap();
  List<String>images =[];
  List<String>headline =[];
  List<Movie>movies =[];
  late DbHandler handler;
  final user = FirebaseAuth.instance.currentUser!;
  ScrollController _scrollController = new ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.handler = DbHandler();
    _scrollController.addListener(() {
      if(_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent){
        print('jvc');
      context.read<BottomProvider>().loadMore('Loadmore');
      }
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: Visibility(
        visible: (context.watch<BottomProvider>().bottomNavState==BottomNavState.SHOW_HOME_STATE)?true:false,
        child: FloatingActionButton(onPressed: () {
          showDialog(context: context, builder:(context)=> EnterMovieDailog(
            cred_val:  (user.photoURL!=null)?user.email.toString():user.phoneNumber.toString(),
          ));
        },
          backgroundColor: Theme.of(context).primaryColor,
          focusColor: Theme.of(context).primaryColor,
          child: Icon(Icons.movie_filter,color: Colors.white,),
        ),
      ),

     bottomNavigationBar: BottomNavyBar(
       itemCornerRadius: 15,
       selectedIndex: context.watch<BottomProvider>().currentIndex,
       onItemSelected: (index)=>context.read<BottomProvider>().onTap(index),
       items: <BottomNavyBarItem>[
         BottomNavyBarItem(
           icon: Icon(FontAwesomeIcons.home),
           title: Text('Home'),
           activeColor: Theme.of(context).primaryColor,
           inactiveColor: Colors.grey,
           textAlign: TextAlign.center,
         ),
         BottomNavyBarItem(
           icon:  Icon(FontAwesomeIcons.search),
           title: Text('Seach'),
           activeColor: Theme.of(context).primaryColor,
           inactiveColor: Colors.grey,
           textAlign: TextAlign.center,
         ),
         BottomNavyBarItem(
           icon: Icon(FontAwesomeIcons.twitch),
           title: Text('Twitch'),
           activeColor: Theme.of(context).primaryColor,
           inactiveColor: Colors.grey,
           textAlign: TextAlign.center,
         ),
         BottomNavyBarItem(
           icon: Icon(FontAwesomeIcons.shoppingCart),
           title: Text('Cart'),
           activeColor: Theme.of(context).primaryColor,
           inactiveColor: Colors.grey,
           textAlign: TextAlign.center,
         ),
         BottomNavyBarItem(
           icon: Icon(FontAwesomeIcons.idBadge),
           title: Text('ID'),
           activeColor: Theme.of(context).primaryColor,
           inactiveColor: Colors.grey,
           textAlign: TextAlign.center,
         ),
       ],

     ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Container(
            alignment: Alignment.center,
            child: (context.watch<BottomProvider>().bottomNavState==BottomNavState.SHOW_ACCOUNT_STATE)?buildProfile(user):
            (context.watch<BottomProvider>().bottomNavState==BottomNavState.SHOW_HOME_STATE)?Container(
                child:
                FutureBuilder(
                  future:
                  context.read<BottomProvider>().getMovieList(user.photoURL!=null?user.email.toString():user.phoneNumber.toString()) ,
                  builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot){
                    if (snapshot.hasData) {
                      return (snapshot.data!.length>0)?
                      ListView.builder(
                        controller: _scrollController,
                        padding: EdgeInsets.only(top: 30.0, bottom: 60.0,left: 5,right: 5),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return MovieStack(directorName: snapshot.data![index].director,
                          movieName: snapshot.data![index].name,
                          imgUrl: snapshot.data![index].poster,
                          id: snapshot.data![index].id,
                          );
                        },
                      ):Text('Add Movies to watch List',style: TextStyle(fontWeight: FontWeight.bold),);
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  } ,
                )

                ):Container(),
          ),
        ),
      ),
    );
  }


  /*FutureBuilder(
  future: context.read<BottomProvider>().getMovieList(user.email.toString()),
  builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
  if(snapshot.hasData){
  movies = snapshot.requireData;
  return (movies.isEmpty)?Text('Add Movies'):Text('Present');
  }
  else if(snapshot.hasError){
  // print(snapshot.requireData.toString());
  return Text('Error');
  }
  else{
  return CircularProgressIndicator(
  color: Theme.of(context).primaryColor,
  );
  }
  },
  )*/

  Column buildProfile(User user) {
    return Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
             SizedBox(height: 30,),
              (user.photoURL!=null)?
              Column(
                children: [
                  SizedBox(height: 30,),
                  SizedBox(
                    height: 115,
                    width: 115,
                    child: Stack(
                      fit: StackFit.expand,
                      overflow: Overflow.visible,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(user.photoURL!),
                        ),
                        Positioned(
                          right: -16,
                          bottom: 0,
                          child: SizedBox(
                            height: 46,
                            width: 46,
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                                side: BorderSide(color: Colors.white),
                              ),
                              color: Color(0xFFF5F6F9),
                              onPressed: () {},
                              child: Icon(FontAwesomeIcons.camera),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 8,),
                  Text('${user.displayName}',style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  SizedBox(height: 5,),
                  ProfileBody(iconColor: Theme.of(context).primaryColor,
                              icons:  FontAwesomeIcons.user,
                              val: 'Profile',
                              iconSize: 20,
                              function: (){},
                  ),
                  ProfileBody(iconColor: Theme.of(context).primaryColor,
                    icons:    Icons.notification_important,
                    val: 'Notifications',
                    iconSize: 20,
                    function: (){},
                  ),
                  ProfileBody(iconColor: Theme.of(context).primaryColor,
                    icons:     Icons.settings,
                    val: 'Settings',
                    iconSize: 20,
                    function: (){},
                  ),
                  ProfileBody(iconColor: Theme.of(context).primaryColor,
                    icons:     FontAwesomeIcons.handsHelping,
                    val: 'Help Center',
                    iconSize: 20,
                    function: (){},
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                    child: FlatButton(
                      padding: EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      //color: Color(0xFFD8ECF1),
                      onPressed: (){
                        final provider = Provider.of<GoogleSignInProvider>(context,listen: false);
                        (user.photoURL!=null)?
                        provider.googleLogout():
                        provider.deviceLogout();
                      },
                      child: Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.signOutAlt,
                            color: Theme.of(context).primaryColor,
                            size: 22,
                          ),
                          SizedBox(width: 20),
                          Expanded(child: Text('Logout')),
                          Icon(Icons.arrow_forward_ios,color: Theme.of(context).primaryColor,size: 20,),
                        ],
                      ),
                    ),
                  ),
                ],
              ):
            Column(
              children: [
                SizedBox(height: 30,),
                Text('PhoneNumber : '+'${user.phoneNumber}',style: TextStyle(fontWeight: FontWeight.bold),),
                SizedBox(height: 15,),
                ProfileBody(iconColor: Theme.of(context).primaryColor,
                  icons:    Icons.notification_important,
                  val: 'Notifications',
                  iconSize: 20,
                  function: (){},
                ),
                ProfileBody(iconColor: Theme.of(context).primaryColor,
                  icons:     Icons.settings,
                  val: 'Settings',
                  iconSize: 20,
                  function: (){},
                ),
                ProfileBody(iconColor: Theme.of(context).primaryColor,
                  icons:     FontAwesomeIcons.handsHelping,
                  val: 'Help Center',
                  iconSize: 20,
                  function: (){},
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                  child: FlatButton(
                    padding: EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    //color: Color(0xFFD8ECF1),
                    onPressed: (){
                      final provider = Provider.of<GoogleSignInProvider>(context,listen: false);
                      (user.photoURL!=null)?
                      provider.googleLogout():
                      provider.deviceLogout();
                    },
                    child: Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.signOutAlt,
                          color: Theme.of(context).primaryColor,
                          size: 22,
                        ),
                        SizedBox(width: 20),
                        Expanded(child: Text('Logout')),
                        Icon(Icons.arrow_forward_ios,color: Theme.of(context).primaryColor,size: 20,),
                      ],
                    ),
                  ),
                ),
              ],
            )

            ],
          );
  }
}




/*
StreamBuilder(
stream: context.read<BottomProvider>().newsStaream(),
builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
if(snapshot.connectionState==ConnectionState.waiting  && snapshot.connectionState==ConnectionState.none){
print(snapshot.connectionState.toString());
return CircularProgressIndicator();
}


if(snapshot.hasData){
images.clear();
headline.clear();
newsData.clear();
var data = snapshot.data;
for(int i=0;i<data['data'].length;i++){
newsMap.putIfAbsent(data['data'][i]['title'], () => data['data'][i]['mobile_image']);
newsData.add(newsMap);
images.add(data['data'][i]['mobile_image']);
headline.add(data['data'][i]['title']);
}
//print(newsData.toString());

return RefreshIndicator(
color:  Theme.of(context).primaryColor,
onRefresh: (){
return Future.delayed(Duration(seconds: 1),
(){
context.read<BottomProvider>().newsStaream();
}
);
},
child: ListView.builder(
padding: EdgeInsets.only(top: 30.0, bottom: 60.0,left: 5,right: 5),
itemCount: newsData.length,
itemBuilder: (BuildContext context, int index){
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
//mainAxisAlignment: MainAxisAlignment.center,
crossAxisAlignment: CrossAxisAlignment.start,
children: <Widget>[
Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
crossAxisAlignment: CrossAxisAlignment.start,
children: <Widget>[
Container(
width: 220.0,
child: Text(
headline[index],
style: TextStyle(
fontSize: 12.5,
fontWeight: FontWeight.w600,
),
overflow: TextOverflow.ellipsis,
maxLines: 2,
),
),
],
),
SizedBox(height: 10.0),
Row(
children: <Widget>[
Container(
padding: EdgeInsets.all(5.0),
width: 70.0,
decoration: BoxDecoration(
color: Theme.of(context).accentColor,
borderRadius: BorderRadius.circular(10.0),
),
alignment: Alignment.center,
child: Text(
'Hindi',
),
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
images[index]
),
fit: BoxFit.cover,
),
),
),
],
);
}
),
);
}
else{
return CircularProgressIndicator(
color: Theme.of(context).primaryColor
);
}


},

),*/
