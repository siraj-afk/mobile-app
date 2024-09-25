import 'dart:convert';


import 'package:http/http.dart';
import 'package:mobileapp/repositery/model/moviemodel.dart';


import '../apiclient.dart';


class MovieApi {
  ApiClient apiClient = ApiClient();


  Future<Moviemodel> getMovie() async {
    String trendingpath = 'https://movies-api14.p.rapidapi.com/movies';
    var body = {

    };
    Response response = await apiClient.invokeAPI(trendingpath, 'GET', body);

    return Moviemodel.fromJson(jsonDecode(response.body));
  }
}