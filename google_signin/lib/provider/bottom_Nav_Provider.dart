import 'package:flutter/material.dart';
import 'package:google_signin/dbHandler/db_handler.dart';
import 'package:google_signin/enum/bottom_nav_enum.dart';
import 'package:google_signin/models/movie.dart';
import 'package:google_signin/services/api_consume.dart';

class BottomProvider extends ChangeNotifier{
NetworkHelper networkHelper = NetworkHelper();
int _currentIndex =0;
DbHandler handler =DbHandler();
List<Movie>_list =[];
List <Movie>_partialList=[];

set partialList(List<Movie> value) {
    _partialList = value;
    notifyListeners();
  }

  List<Movie> get partialList => _partialList;

  String loadMoreData = 'Stable';


set list(List<Movie> value) {
    _list = value;
    notifyListeners();
  }

  List<Movie> get list => _list;

  set currentIndex(int value) {
    _currentIndex = value;
    notifyListeners();
  }
  int get currentIndex => _currentIndex;

  BottomNavState bottomNavState = BottomNavState.SHOW_HOME_STATE;
  void onTap(int index){
    currentIndex = index;
    bottomNavState = BottomNavState.values[index];
    notifyListeners();
  }

Future<List<Movie>>getMovieList(String cred_val) async{
     list = await handler.retrieveMovie_det(cred_val);
     //partialList =[list.first,list.last,list.last,list.last];
     //partialList.add(list.first);
     notifyListeners();
     return list;
}



void loadMore(String val){
    if(val=='Loadmore'){
      partialList.clear();
      for(int i=0;i<list.length;i++){
       // print(i.toString());
        partialList.add(list[i]);
      }
    }
    //print(partialList.length.toString());
}

void delete({required int? id})async{
    await this.handler.deleteMovie(id!);
    notifyListeners();
}

void insert({required String cred_val , required String movieName ,required String directorName,required String photoUrl}){
  this.handler.initializeDB().whenComplete(() async{
  Movie movie = Movie(cred_val: cred_val, name: movieName, director: directorName, poster: photoUrl);
  list.add(movie);
  List<Movie>mv = [movie];
  await this.handler.inserMovie(mv);
  notifyListeners();
  });
}
void update({required String movieName ,required String directorName, required int? id}) async{
await this.handler.Updaate_movie_det(movieName, directorName, id);
notifyListeners();
}
}