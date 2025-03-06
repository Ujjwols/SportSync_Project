import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_application_project/features/home/presentation/view_model/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState(selectedIndex: 0, userId: 'someUserId'));

  void onTabTapped(int index) {
    emit(state.copyWith(selectedIndex: index));
  }

  void updateUserId(String userId) {
    emit(state.copyWith(userId: userId));
  }
}
