import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_application_project/app/di/di.dart';
import 'package:mobile_application_project/app/shared_prefs/token_shared_prefs.dart';
import 'package:mobile_application_project/features/auth/presentation/view_model/update/update_bloc.dart';
import 'package:mobile_application_project/features/home/presentation/view/update_profile.dart';
import 'package:mobile_application_project/features/matchpost/domain/entity/matchpost_entity.dart';
import 'package:mobile_application_project/features/matchpost/presentation/view_model/matchpost_bloc.dart';
import 'package:mobile_application_project/features/matchpost/presentation/view_model/matchpost_event.dart';
import 'package:mobile_application_project/features/matchpost/presentation/view_model/matchpost_state.dart';
import 'package:mobile_application_project/features/post/domain/entity/post_entity.dart';
import 'package:mobile_application_project/features/post/presentation/view_model/post_bloc.dart';
import 'package:mobile_application_project/features/post/presentation/view_model/post_event.dart';
import 'package:mobile_application_project/features/post/presentation/view_model/post_state.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final TokenSharedPrefs _tokenSharedPrefs;
  String name = 'Loading...';
  String username = 'Loading...';
  String bio = 'Loading...';
  String profileImageUrl = '';

  _AccountPageState() : _tokenSharedPrefs = getIt<TokenSharedPrefs>();

  @override
  void initState() {
    super.initState();
    _loadUserDetails();
  }

  Future<void> _loadUserDetails() async {
    final userDetailsResult = await _tokenSharedPrefs.getUserDetails();
    userDetailsResult.fold(
      (failure) =>
          debugPrint('Failed to load user details: ${failure.message}'),
      (userDetails) {
        setState(() {
          name = userDetails['name'] ?? 'Unknown';
          username = userDetails['username'] ?? 'Unknown';
          bio = userDetails['bio'] ?? 'Unknown';
          profileImageUrl = userDetails['profilePic'] ?? '';
        });
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
        title: const Text('Account'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: profileImageUrl.isNotEmpty
                              ? NetworkImage(profileImageUrl)
                              : const AssetImage('assets/default_avatar.png')
                                  as ImageProvider,
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '@$username',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  bio,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) => getIt<UpdateUserBloc>(),
                          child: const UpdatePage(),
                        ),
                      ),
                    ).then((_) => _loadUserDetails());
                  },
                  child: const Text('Update Profile'),
                ),
                const SizedBox(height: 24),
                Divider(
                  color: Colors.grey[400],
                  thickness: 1,
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  BlocBuilder<PostBloc, PostState>(
                    builder: (context, state) {
                      if (state is PostLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is UserPostsLoaded) {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.posts.length,
                          itemBuilder: (context, index) {
                            return PostItem(
                              post: state.posts[index],
                              username: username,
                            );
                          },
                        );
                      } else if (state is PostError) {
                        return Center(child: Text(state.message));
                      }
                      return const Center(child: Text("No posts available"));
                    },
                  ),
                  BlocBuilder<MatchpostBloc, MatchpostState>(
                    builder: (context, state) {
                      if (state is MatchPostLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is MatchUserPostsLoaded) {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.posts.length,
                          itemBuilder: (context, index) {
                            return MatchPostItem(matchpost: state.posts[index]);
                          },
                        );
                      } else if (state is MatchPostError) {
                        return Center(child: Text(state.message));
                      }
                      return const Center(
                          child: Text("No match posts available"));
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PostItem extends StatelessWidget {
  final PostEntity post;
  final String username;

  const PostItem({super.key, required this.post, required this.username});

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
            // Display the text content of the post
            Text(
              post.text ?? "No Text",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8.0),

            // Display the post image, if available
            if (post.img != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  post.img!,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 16.0),

            // Row for Like, Comment, and Delete buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Like button
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

                // Comment button
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

                // Delete button
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    if (post.postId != null) {
                      context.read<PostBloc>().add(
                            DeletePostEvent(postId: post.postId!),
                          );
                      // After deletion, refresh the posts
                      context.read<PostBloc>().add(
                            const GetUserPostEvent(
                                username: "username"), // Pass the username
                          );
                    } else {
                      debugPrint("Post ID is null, cannot delete.");
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
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              ElevatedButton(
                onPressed: () {
                  // Access HomeCubit and trigger navigation
                },
                child: const Text("Message"),
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  if (matchpost.matchpostId != null) {
                    context.read<MatchpostBloc>().add(
                          DeleteMatchPostEvent(
                              matchpostId: matchpost.matchpostId!),
                        );
                    // After deletion, refresh the posts
                    context.read<MatchpostBloc>().add(
                          const GetUserMatchPostEvent(
                              username: "username"), // Pass the username
                        );
                  } else {
                    debugPrint("Post ID is null, cannot delete.");
                  }
                },
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
