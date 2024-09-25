import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mobileapp/repositery/api/movieapi/movieapinew.dart';

import '../repositery/model/moviemodel.dart';


part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  late Moviemodel moviemodel;
  MovieApi movieApi=MovieApi();
  MovieBloc() : super(MovieInitial()) {
    on<fetchMovieEvent>((event, emit) async {
    emit(Movieblocloading());
    try{
      moviemodel= await movieApi.getMovie();
      emit(Movieblocloaded());
    }catch(e){
      emit(Movieblocerror());
    }
    });
  }
}
