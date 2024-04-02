import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/api/api.dart';
import 'package:movies_app/model/movie.dart';
import 'package:movies_app/src/slider/movies_slider.dart';
import 'package:movies_app/src/slider/trending_slider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Movie>> trendingMovies;
  late Future<List<Movie>> topRatedMovies;
  late Future<List<Movie>> upcomingMovies;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    trendingMovies = Api().getTrendingMovies();
    topRatedMovies = Api().getTopRatedMovies();
    upcomingMovies = Api().getUpcomingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Image.asset(
          'assets/image.png',
          fit: BoxFit.cover,
          height: 50,
          width: 240,
          filterQuality: FilterQuality.high,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: MovieSearchDelegate(),
              );
            },
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              // Handle favorite action
            },
            icon: Icon(Icons.favorite),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Background image
              Image.asset(
                'assets/background.jpg',
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Trending Now',
                      style: GoogleFonts.aBeeZee(fontSize: 25),
                    ),
                    const SizedBox(height: 16),
                    FutureBuilder(
                      future: trendingMovies,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text(snapshot.error.toString()),
                          );
                        } else if (snapshot.hasData) {
                          return TrendingSlider(snapshot: snapshot);
                        } else {
                          return const Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    Text("Top Rated Movies", style: GoogleFonts.aBeeZee(fontSize: 25)),
                    const SizedBox(height: 10),
                    FutureBuilder(
                      future: topRatedMovies,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text(snapshot.error.toString()),
                          );
                        } else if (snapshot.hasData) {
                          return MoviesSlider(snapshot: snapshot);
                        } else {
                          return const Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    Text("Upcoming Movies", style: GoogleFonts.aBeeZee(fontSize: 25)),
                    const SizedBox(height: 10),
                    FutureBuilder(
                      future: upcomingMovies,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text(snapshot.error.toString()),
                          );
                        } else if (snapshot.hasData) {
                          return MoviesSlider(snapshot: snapshot);
                        } else {
                          return const Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: Color.fromARGB(255, 11, 11, 11).withOpacity(0.5), // Set the background color with opacity
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 52, 51, 51).withOpacity(0.7), // Adjust header background opacity
                ),
                accountName: Text(
                  'Michael Grey', // Replace with the user's name
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                accountEmail: null, // You can add user's email here if needed
                currentAccountPicture: CircleAvatar(
                  // Replace with the user's profile picture
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.account_circle, // Placeholder icon
                    size: 48,
                    color: const Color.fromARGB(255, 187, 67, 67),
                  ),
                ),
              ),
              ListTile(
                title: Text('GENRE'),
                onTap: () {
                  // Implement item 1 functionality
                },
              ),
              ListTile(
                title: Text('NEW RELEASES'),
                onTap: () {
                  // Implement item 2 functionality
                },
              ),
              ListTile(
                title: Text('SUBSCRIBE!!'),
                onTap: () {
                  // Implement item 2 functionality
                },
              ),
              ListTile(
                title: Text('ABOUT US'),
                onTap: () {
                  // Implement item 2 functionality
                },
              ),
              // Add more list items as needed
            ],
          ),
        ),
      ),
    );
  }
}

class MovieSearchDelegate extends SearchDelegate<String> {
  late Future<List<Movie>> searchResults;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: searchResults,
      builder: (context, AsyncSnapshot<List<Movie>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Movie movie = snapshot.data![index];
              return ListTile(
                title: Text(movie.title),
                // Implement onTap to navigate to movie details page
              );
            },
          );
        } else {
          return Center(child: Text('No results found'));
        }
      },
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  void showResults(BuildContext context) {
    searchResults = Api().searchMovies(query);
    super.showResults(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}




