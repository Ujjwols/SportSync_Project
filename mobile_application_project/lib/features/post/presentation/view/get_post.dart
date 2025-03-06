import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_application_project/app/shared_prefs/token_shared_prefs.dart';
import 'package:mobile_application_project/features/matchpost/domain/entity/matchpost_entity.dart';
import 'package:mobile_application_project/features/matchpost/presentation/view_model/matchpost_bloc.dart';
import 'package:mobile_application_project/features/matchpost/presentation/view_model/matchpost_event.dart';
import 'package:mobile_application_project/features/matchpost/presentation/view_model/matchpost_state.dart';
import 'package:mobile_application_project/features/post/domain/entity/post_entity.dart';
import 'package:mobile_application_project/features/post/presentation/view_model/post_bloc.dart';
import 'package:mobile_application_project/features/post/presentation/view_model/post_event.dart';
import 'package:mobile_application_project/features/post/presentation/view_model/post_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  late TokenSharedPrefs _tokenSharedPrefs;
  String username = 'Loading...';

  @override
  void initState() {
    super.initState();
    _loadUserDetails();
  }

  Future<void> _loadUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    _tokenSharedPrefs = TokenSharedPrefs(prefs);

    final userDetailsResult = await _tokenSharedPrefs.getUserDetails();
    userDetailsResult.fold(
      (failure) =>
          debugPrint('Failed to load user details: ${failure.message}'),
      (userDetails) {
        setState(() {
          username = userDetails['username'] ?? 'Unknown';
        });
        // Fetch posts and match posts for the user
        context.read<PostBloc>().add(GetUserPostEvent(username: username));
        context
            .read<MatchpostBloc>()
            .add(GetUserMatchPostEvent(username: username));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feed'),
        centerTitle: true,
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<PostBloc, PostState>(
            listener: (context, state) {
              if (state is PostError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
          ),
          BlocListener<MatchpostBloc, MatchpostState>(
            listener: (context, state) {
              if (state is MatchPostError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
          ),
        ],
        child: BlocBuilder<PostBloc, PostState>(
          builder: (context, postState) {
            return BlocBuilder<MatchpostBloc, MatchpostState>(
              builder: (context, matchpostState) {
                if (postState is PostLoading ||
                    matchpostState is MatchPostLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (postState is UserPostsLoaded &&
                    matchpostState is MatchUserPostsLoaded) {
                  // Combine posts and match posts
                  final allPosts = [
                    ...postState.posts.map(
                        (post) => FeedItem(post: post, username: username)),
                    ...matchpostState.posts.map((matchpost) =>
                        FeedItem(matchpost: matchpost, username: username)),
                  ];
                  return ListView.builder(
                    itemCount: allPosts.length,
                    itemBuilder: (context, index) {
                      return allPosts[index];
                    },
                  );
                } else if (postState is PostError) {
                  return Center(child: Text(postState.message));
                } else if (matchpostState is MatchPostError) {
                  return Center(child: Text(matchpostState.message));
                }
                return const Center(child: Text("No posts available"));
              },
            );
          },
        ),
      ),
    );
  }
}

class FeedItem extends StatelessWidget {
  final PostEntity? post;
  final MatchPostEntity? matchpost;
  final String username;

  const FeedItem({
    super.key,
    this.post,
    this.matchpost,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    if (post != null) {
      return PostItem(post: post!, username: username);
    } else if (matchpost != null) {
      return MatchPostItem(matchpost: matchpost!);
    }
    return const SizedBox.shrink();
  }
}

class PostItem extends StatelessWidget {
  final PostEntity post;
  final String username;

  const PostItem({
    super.key,
    required this.post,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.text ?? "No Text",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8.0),
            if (post.img != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  post.img!,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.thumb_up, color: Colors.blue),
                  onPressed: () {
                    if (post.postId != null) {
                      context.read<PostBloc>().add(
                            LikeUnlikePostEvent(
                              postId: post.postId!,
                              username: username,
                            ),
                          );
                    } else {
                      debugPrint("Post ID is null, cannot like.");
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.comment, color: Colors.green),
                  onPressed: () {
                    if (post.postId != null) {
                      context.read<PostBloc>().add(
                            ReplyToPostEvent(postId: post.postId!, text: ''),
                          );
                    } else {
                      debugPrint("Post ID is null, cannot comment.");
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}

class MatchPostItem extends StatelessWidget {
  final MatchPostEntity matchpost;

  const MatchPostItem({super.key, required this.matchpost});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              matchpost.text ?? "No Text",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8.0),
            // Display the team name
            Text(
              "Team Name: ${matchpost.teamName ?? "No Team Name"}",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8.0),

            // Display the date
            Text(
              "Date: ${matchpost.date ?? "No Date"}",
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8.0),

            // Display the time
            Text(
              "Time: ${matchpost.time ?? "No Time"}",
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8.0),

            // Display the location
            Text(
              "Location: ${matchpost.location ?? "No Location"}",
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8.0),

            // Display the game type
            Text(
              "Game Type: ${matchpost.gameType ?? "No Game Type"}",
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8.0),

            // Display the payment details
            Text(
              "Payment: ${matchpost.payment ?? "No Payment Details"}",
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8.0),

            // Display the match post image, if available
            if (matchpost.img != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  matchpost.img!,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Access HomeCubit and trigger navigation
              },
              child: const Text("Message"),
            )
          ],
        ),
      ),
    );
  }
}
