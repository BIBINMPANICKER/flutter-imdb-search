import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';
import 'package:tradexa/src/state_provider/movie_provider.dart';
import 'package:tradexa/src/utils/utils.dart';

import 'models/movie_list_response.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return buildMaterialApp(context);
  }

  MaterialApp buildMaterialApp(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ChangeNotifierProvider<MovieProvider>(
            create: (context) => MovieProvider(),
            child: MaterialApp(home: Home())));
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _movieNameController = TextEditingController();

  @override
  void dispose() {
    _movieNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Home',
            style: Theme.of(context).textTheme.title,
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Consumer<MovieProvider>(builder: (context, model, child) {
                return TextFormField(
                    controller: _movieNameController,
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(16),
                      hintText: "Search movie",
                      suffixIcon: model.isLoading
                          ? JumpingText('...',
                              style: TextStyle(
                                  fontSize: 24, color: Colors.black45))
                          : IconButton(
                              icon: Icon(
                                Icons.search,
                                color: Colors.black54,
                              ),
                              onPressed: () {
                                fetchMovie();
                              }),
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                    ),
                    textInputAction: TextInputAction.search,
                    onFieldSubmitted: (value) {
                      fetchMovie();
                    });
              }),
              SizedBox(
                height: screenHeight(context, dividedBy: 60),
              ),
              Consumer<MovieProvider>(
                builder: (context, model, child) {
                  return model.movieListResponse.title != null
                      ? Expanded(
                          child: ListView.builder(
                              itemCount: 1,
                              itemBuilder: (context, index) =>
                                  listItem(index, model.movieListResponse)))
                      : Expanded(child: Center(child: Text(model.quote)));
                },
              )
            ],
          ),
        ),
      ),
    );
  }

//  card item in the list view
  Widget listItem(index, MovieListResponse movieResponse) {
    return Card(
        elevation: 8,
        margin: EdgeInsets.only(top: 12),
        child: Container(
          padding: EdgeInsets.only(left: 8),
          height: screenHeight(context, dividedBy: 4.3),
          width: screenWidth(context, dividedBy: 3),
          child: Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(6)),
                child: Image.network(
                  movieResponse.poster,
                  fit: BoxFit.fill,
                  height: screenHeight(context, dividedBy: 4.7),
                  width: screenWidth(context, dividedBy: 3),
                ),
              ),
              SizedBox(
                width: screenWidth(context, dividedBy: 12),
              ),
              Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(movieResponse.title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      SizedBox(
                        height: screenHeight(context, dividedBy: 150),
                      ),
                      Text(
                        movieResponse.genre.replaceAll(',', ' |'),
                        style: TextStyle(color: Colors.black45, fontSize: 12),
                      ),
                      SizedBox(
                        height: screenHeight(context, dividedBy: 150),
                      ),
                      Container(
                        decoration: new BoxDecoration(
                          color: ratingColor(movieResponse.imdbRating),
                          borderRadius: new BorderRadius.circular(15.0),
                        ),
                        height: screenHeight(context, dividedBy: 30),
                        width: screenWidth(context, dividedBy: 4.8),
                        child: Center(
                            child: Text(
                          '${movieResponse.imdbRating} IMDB',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        )),
                      )
                    ]),
              ),
            ],
          ),
        ));
  }

// function for changing color of rating widget by value
  Color ratingColor(rating) {
    try {
      double val = double.parse(rating);
      if (val <= 2) {
        return Colors.redAccent;
      } else if (val <= 5) {
        return Color(0xFF4E85EE);
      } else {
        return Color(0xff66c173);
      }
    } on FormatException {
      return Color(0xff66c173);
    }
  }

  fetchMovie() {
    if (_movieNameController.text.isNotEmpty) {
      Provider.of<MovieProvider>(context, listen: false)
          .getMovies(_movieNameController.text);
      FocusScope.of(context).requestFocus(FocusNode());
    }else{
      toast(msg: 'Please Enter the Movie title');
    }
  }
}
