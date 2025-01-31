import 'package:flutter/material.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  String activeFilter = 'All Posts'; // Tracks the active filter

  final List<dynamic> posts = [
    Post(
      teamName: 'Kathmandu Kings',
      time: '2 hours ago',
      content:
          'Great practice session today! Working on our defensive strategies for the upcoming tournament. Who else is preparing? 🏀 #BasketballLife',
      imageUrl: 'assets/images/logoe.png',
      likes: 245,
      comments: 18,
    ),
    Post(
      teamName: 'Pokhara Panthers',
      time: 'Yesterday',
      content:
          'Victory tastes sweet! 🏆 Thanks to Phoenix Spikers for an amazing game!',
      imageUrl: 'assets/images/logoe.png',
      likes: 312,
      comments: 24,
      isScoreCard: true,
    ),
    MatchmakingPost(
      teamName: 'Chitwan Tigers',
      time: 'Today, 5:00 PM',
      game: 'Futsal',
      location: 'Chitwan Arena',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: FilterButton(
                    label: 'All Posts',
                    isSelected: activeFilter == 'All Posts',
                    onPressed: () {
                      setState(() {
                        activeFilter = 'All Posts';
                      });
                    },
                  ),
                ),
                const SizedBox(width: 8), // Adds spacing between buttons
                Expanded(
                  child: FilterButton(
                    label: 'Connect',
                    isSelected: activeFilter == 'Connect',
                    onPressed: () {
                      setState(() {
                        activeFilter = 'Connect';
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: posts
                  .where((post) =>
                      activeFilter == 'All Posts' || post is MatchmakingPost)
                  .map((post) => post is MatchmakingPost
                      ? MatchmakingPostCard(matchmakingPost: post)
                      : PostCard(post: post))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  const FilterButton({
    super.key,
    required this.label,
    this.isSelected = false,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.black : Colors.white,
        side: const BorderSide(color: Colors.black, width: 1),
      ),
      child: Text(
        label,
        style: TextStyle(color: isSelected ? Colors.white : Colors.black),
      ),
    );
  }
}

class Post {
  final String teamName;
  final String time;
  final String content;
  final String imageUrl;
  final int likes;
  final int comments;
  final bool isScoreCard;

  Post({
    required this.teamName,
    required this.time,
    required this.content,
    required this.imageUrl,
    required this.likes,
    required this.comments,
    this.isScoreCard = false,
  });
}

class MatchmakingPost {
  final String teamName;
  final String time;
  final String game;
  final String location;

  MatchmakingPost({
    required this.teamName,
    required this.time,
    required this.game,
    required this.location,
  });
}

class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  post.teamName,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  post.time,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(post.content),
            const SizedBox(height: 8),
            if (post.isScoreCard)
              Container(
                padding: const EdgeInsets.all(16.0),
                color: Colors.grey[200],
                child: const Column(
                  children: [
                    Text(
                      'Pokhara Panthers 25 - 21 Chitwan Tigers',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    Text('Aces: 8-5, Blocks: 12-9, Spikes: 45-38'),
                  ],
                ),
              )
            else
              Image.asset(post.imageUrl, fit: BoxFit.cover),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.thumb_up_alt_outlined,
                        size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text('${post.likes} likes',
                        style: const TextStyle(color: Colors.grey)),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.comment_outlined,
                        size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text('${post.comments} comments',
                        style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MatchmakingPostCard extends StatelessWidget {
  final MatchmakingPost matchmakingPost;

  const MatchmakingPostCard({super.key, required this.matchmakingPost});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  matchmakingPost.teamName,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  matchmakingPost.time,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('Game: ${matchmakingPost.game}'),
            const SizedBox(height: 4),
            Text('Location: ${matchmakingPost.location}'),
          ],
        ),
      ),
    );
  }
}
