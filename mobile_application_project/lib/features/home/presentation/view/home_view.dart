import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_application_project/app/di/di.dart';
import 'package:mobile_application_project/features/home/presentation/view_model/home_cubit.dart';
import 'package:mobile_application_project/features/home/presentation/view_model/home_state.dart';
import 'package:mobile_application_project/features/matchpost/domain/usecase/creatematchpost_usecase.dart';
import 'package:mobile_application_project/features/matchpost/domain/usecase/deletematchpost_usecase.dart';
import 'package:mobile_application_project/features/matchpost/domain/usecase/getmatchpost_usecase.dart';
import 'package:mobile_application_project/features/matchpost/domain/usecase/getmatchpostbyid_usecase.dart';
import 'package:mobile_application_project/features/matchpost/domain/usecase/getmatchpostbyusername_usecase.dart';
import 'package:mobile_application_project/features/matchpost/presentation/view_model/matchpost_bloc.dart';
import 'package:mobile_application_project/features/post/domain/use_case/createpost_usecase.dart';
import 'package:mobile_application_project/features/post/domain/use_case/deletepost_usecase.dart';
import 'package:mobile_application_project/features/post/domain/use_case/get_feed_usecase.dart';
import 'package:mobile_application_project/features/post/domain/use_case/getpostbyid_usecase.dart';
import 'package:mobile_application_project/features/post/domain/use_case/getuserpost_usecase.dart';
import 'package:mobile_application_project/features/post/domain/use_case/likeandunlike_usecase.dart';
import 'package:mobile_application_project/features/post/domain/use_case/replytopost_usecase.dart';
import 'package:mobile_application_project/features/post/presentation/view_model/post_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Provide PostBloc
        BlocProvider(
          create: (context) => PostBloc(
            createPostUseCase: getIt<CreatePostUseCase>(),
            deletePostUseCase: getIt<DeletePostUseCase>(),
            getFeedUseCase: getIt<GetFeedUseCase>(),
            getPostByIdUseCase: getIt<GetPostByIdUseCase>(),
            getUserPostUseCase: getIt<GetUserPostUseCase>(),
            likeUnlikePostUseCase: getIt<LikeUnlikePostUseCase>(),
            replyToPostUseCase: getIt<ReplyToPostUseCase>(),
          ),
        ),
        // Provide MatchpostBloc
        BlocProvider(
          create: (context) => MatchpostBloc(
            createMatchPostUseCase: getIt<CreateMatchPostUseCase>(),
            deleteMatchPostUseCase: getIt<DeleteMatchPostUseCase>(),
            getMatchFeedUseCase: getIt<GetMatchFeedUseCase>(),
            getMatchPostByIdUseCase: getIt<GetMatchPostByIdUseCase>(),
            getUserMatchPostUseCase: getIt<GetUserMatchPostUseCase>(),
          ),
        ),
      ],
      child: Scaffold(
        // appBar: AppBar(
        //   title: const Text('Home'),
        //   centerTitle: true,
        // ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return state.views.elementAt(state.selectedIndex);
          },
        ),
        bottomNavigationBar: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.post_add),
                  label: 'Posts',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.add),
                  label: 'MatchPost',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.message),
                  label: 'Message',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle),
                  label: 'Account',
                ),
              ],
              currentIndex: state.selectedIndex,
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.blue,
              onTap: (index) {
                context.read<HomeCubit>().onTabTapped(index);
              },
            );
          },
        ),
      ),
    );
  }
}
