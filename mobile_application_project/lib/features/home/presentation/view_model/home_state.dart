import 'package:flutter/widgets.dart';
import 'package:mobile_application_project/features/home/presentation/view/AccountPage.dart';
import 'package:mobile_application_project/features/home/presentation/view/MessagePage.dart';
import 'package:mobile_application_project/features/matchpost/presentation/view/add_matchpost_view.dart';
import 'package:mobile_application_project/features/post/presentation/view/add_post.dart';
import 'package:mobile_application_project/features/post/presentation/view/get_post.dart';

class HomeState {
  final int selectedIndex;
  final String userId;
  final List<Widget> views;
  HomeState({required this.selectedIndex, required this.userId})
      : views = [
          const FeedPage(),
          CreatePostView(userId: userId),
          CreateMatchPostView(userId: userId), // No BlocProvider here
          const MessagePage(),
          const AccountPage(),
        ];

  HomeState copyWith({int? selectedIndex, String? userId}) {
    return HomeState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      userId: userId ?? this.userId,
    );
  }
}
