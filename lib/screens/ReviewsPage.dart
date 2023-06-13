import 'package:becapy/helper/backend/apis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewsPage extends StatefulWidget {
  final double? rating;

  ReviewsPage({this.rating});

  @override
  _ReviewsPageState createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  List<dynamic> reviews = [];
  bool isLoading = false;
  int page = 0;

  @override
  void initState() {
    super.initState();
    fetchReviews(page);
  }

  Future<void> fetchReviews(int page) async {
    setState(() {
      isLoading = true;
    });

    final result = await UserAPIS.getReviews(page);

    setState(() {
      reviews = result['local_result']['reviews'] as List;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
          body: Center(
        child: CircularProgressIndicator(),
      ));
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: Text(
          'Rating: ${widget.rating ?? ""}',
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: reviews.isEmpty
          ? const Center(
              child: Text("No Posts found!"),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                final review = reviews[index];

                return ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(review['profileURL']),
                  ),
                  title: RatingBar.builder(
                    initialRating:
                        double.tryParse(review['userRating'].toString()) ?? 0.0,
                    minRating: 0,
                    maxRating: 5,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 40.0,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    ignoreGestures: true,
                    onRatingUpdate: (rating) {},
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        review['username'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      if (review['userReview'] != null)
                        Text(review['userReview']),
                      if (review['reviewedAt'] != null)
                        Text('Reviewed At: ${review['reviewedAt']}'),
                    ],
                  ),
                );
              },
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: isLoading
          ? null
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  onPressed: _decrementPage,
                  backgroundColor: page != 0 ? Colors.blue : Colors.grey,
                  heroTag: 'decrement',
                  child: const Icon(Icons.arrow_back),
                ),
                const SizedBox(width: 16),
                FloatingActionButton(
                  onPressed: _incrementPage,
                  backgroundColor:
                      reviews.isNotEmpty ? Colors.blue : Colors.grey,
                  heroTag: 'increment',
                  child: const Icon(Icons.arrow_forward),
                ),
              ],
            ),
    );
  }

  void _incrementPage() {
    if (reviews.isNotEmpty) {
      setState(() {
        page++;
      });
      fetchReviews(page);
    }
  }

  void _decrementPage() {
    if (page != 0) {
      setState(() {
        page--;
      });
      fetchReviews(page);
    }
  }
}
