import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/constant.dart';
import 'package:movies_app/model/movie.dart';
import 'package:movies_app/widgets/back_button.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key, required this.movie}) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: BackBtn(),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Image.network(
              '${Constants.imagePath}${movie.posterPath}',
              filterQuality: FilterQuality.high,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 16),
          Text(
            movie.title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Overview:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8),
          Text(
            movie.overview,
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Release Date:',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  Text(
                    movie.releaseDate,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rating:',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber),
                      SizedBox(width: 4),
                      Text(
                        "${movie.voteAverage.toStringAsFixed(1)}/10",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
