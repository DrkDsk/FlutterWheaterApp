import 'package:bloc/bloc.dart';

class HomePageNavigationCubit extends Cubit<int> {
  HomePageNavigationCubit() : super(0);

  void updatePageIndex(int index) => emit(index);
}
