import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobileapp/bloc/movie_bloc.dart';
import 'package:mobileapp/repositery/model/moviemodel.dart';

import 'Screen2.dart';

class Screen1 extends StatefulWidget {
  const Screen1({super.key});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  late Moviemodel movie;

  @override
  void initState() {
    BlocProvider.of<MovieBloc>(context).add(fetchMovieEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(left: 20.w),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 10.0.h),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.menu_rounded,
                      size: 24,
                    ),
                    Text(
                      'FilmKu',
                      style: TextStyle(
                        color: Color(0xFF110E47),
                        fontSize: 16,
                        fontFamily: 'Merriweather',
                        fontWeight: FontWeight.w900,
                        height: 0,
                        letterSpacing: 0.32,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 20.0.w),
                      child: Icon(
                        Icons.notifications,
                        size: 24,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Now Showing',
                      style: TextStyle(
                        color: Color(0xFF110E46),
                        fontSize: 16.sp,
                        fontFamily: 'Merriweather',
                        fontWeight: FontWeight.w900,
                        height: 0,
                        letterSpacing: 0.32,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 20.0.w),
                      child: Container(
                        width: 61.w,
                        height: 21.h,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side:
                                BorderSide(width: 1, color: Color(0xFFE5E4EA)),
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'See more',
                            style: TextStyle(
                              color: Color(0xFFAAA8B0),
                              fontSize: 10,
                              fontFamily: 'Mulish',
                              fontWeight: FontWeight.w400,
                              height: 0,
                              letterSpacing: 0.20,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                GestureDetector(
                  child: SizedBox(
                    height: 283.h,
                    child: BlocBuilder<MovieBloc, MovieState>(
                      builder: (context, state) {
                        if (state is Movieblocloading) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (state is Movieblocerror) {
                          return RefreshIndicator(
                              child: Text('error'),
                              onRefresh: () async {
                                return BlocProvider.of<MovieBloc>(context)
                                    .add(fetchMovieEvent());
                              });
                        }
                        if (state is Movieblocloaded) {
                          movie =
                              BlocProvider.of<MovieBloc>(context).moviemodel;
                          return ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: movie.movies!.length,
                            itemBuilder: (context, position) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => Screen2(image: movie.movies![position].backdropPath.toString(),
                                        title: movie.movies![position].title.toString(),
                                        Description: movie.movies![position].overview.toString(),
                                        genre: movie.movies![position].genres!,)));
                                },
                                child: Container(
                                  width: 143.w,
                                  height: 283.h,
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 143.w,
                                        height: 212.h,
                                        child: Image.network(
                                          fit: BoxFit.cover,
                                          movie.movies![position].backdropPath
                                              .toString(),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      SizedBox(
                                        height: 30.h,
                                        child: Text(
                                          movie.movies![position].title
                                              .toString(),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontFamily: 'Mulish',
                                            fontWeight: FontWeight.w700,
                                            height: 0,
                                            letterSpacing: 0.28,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                          ),
                                          SizedBox(
                                            width: 3.w,
                                          ),
                                          Text(
                                            '9.1/10 IMDb',
                                            style: TextStyle(
                                              color: Color(0xFF9B9B9B),
                                              fontSize: 12,
                                              fontFamily: 'Mulish',
                                              fontWeight: FontWeight.w400,
                                              height: 0,
                                              letterSpacing: 0.24,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(
                                width: 10.w,
                              );
                            },
                          );
                        } else {
                          return SizedBox();
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Popular',
                      style: TextStyle(
                        color: Color(0xFF110E46),
                        fontSize: 16.sp,
                        fontFamily: 'Merriweather',
                        fontWeight: FontWeight.w900,
                        height: 0,
                        letterSpacing: 0.32,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 20.0.w),
                      child: Container(
                        width: 61.w,
                        height: 21.h,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side:
                                BorderSide(width: 1, color: Color(0xFFE5E4EA)),
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'See more',
                            style: TextStyle(
                              color: Color(0xFFAAA8B0),
                              fontSize: 10,
                              fontFamily: 'Mulish',
                              fontWeight: FontWeight.w400,
                              height: 0,
                              letterSpacing: 0.20,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  height: 300.h,
                  child: BlocBuilder<MovieBloc, MovieState>(
                      builder: (context, state) {
                    if (state is Movieblocloading) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (state is Movieblocerror) {
                      return RefreshIndicator(
                          child: Text('error'),
                          onRefresh: () async {
                            return BlocProvider.of<MovieBloc>(context)
                                .add(fetchMovieEvent());
                          });
                    }
                    if (state is Movieblocloaded) {
                      movie = BlocProvider.of<MovieBloc>(context).moviemodel;
                      return ListView.separated(
                          itemCount: movie.movies!.length,
                          itemBuilder: (context, index) {
                            return GestureDetector( onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => Screen2(image: movie.movies![index].backdropPath.toString(),
                                    title: movie.movies![index].title.toString(),
                                    Description: movie.movies![index].overview.toString(),
                                    genre: movie.movies![index].genres!,)));
                            },
                              child: Container(
                                width: 304.w,
                                height: 120.h,
                                child: Row(
                                  children: [
                                    Container(
                                        width: 85,
                                        height: 120,
                                        child: Image.network(
                                            fit: BoxFit.cover,
                                            movie.movies![index].backdropPath
                                                .toString())),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 250.w,
                                          child: Text(
                                            movie.movies![index].title.toString(),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontFamily: 'Mulish',
                                              fontWeight: FontWeight.w700,
                                              height: 0,
                                              letterSpacing: 0.28,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 3.h,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: Colors.yellow,
                                            ),
                                            SizedBox(
                                              width: 3.w,
                                            ),
                                            Text(
                                              '9.1/10 IMDb',
                                              style: TextStyle(
                                                color: Color(0xFF9B9B9B),
                                                fontSize: 12,
                                                fontFamily: 'Mulish',
                                                fontWeight: FontWeight.w400,
                                                height: 0,
                                                letterSpacing: 0.24,
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                          width: 250.w,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: movie
                                                .movies![index].genres!.length,
                                            itemBuilder: (context, position) {
                                              return Padding(
                                                padding:
                                                    EdgeInsets.only(left: 10.0),
                                                child: Container(
                                                  width: 61.w,
                                                  height: 25.h,
                                                  decoration: ShapeDecoration(
                                                    color: Color(0xFFDBE3FF),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                    ),
                                                  ),
                                                  child: Center(
                                                      child: Text(
                                                    movie.movies![index]
                                                        .genres![position]
                                                        .toString(),
                                                    style: TextStyle(
                                                      color: Color(0xFF87A3E8),
                                                      fontSize: 8,
                                                      fontFamily: 'Mulish',
                                                      fontWeight: FontWeight.w700,
                                                      height: 0,
                                                      letterSpacing: 0.16,
                                                    ),
                                                  )),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.lock_clock,
                                              color: Colors.black,
                                            ),
                                            SizedBox(
                                              width: 3.w,
                                            ),
                                            Text(
                                              '1h 47m',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontFamily: 'Mulish',
                                                fontWeight: FontWeight.w400,
                                                height: 0,
                                                letterSpacing: 0.24,
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              height: 20.h,
                            );
                          });
                    } else {
                      return SizedBox();
                    }
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
