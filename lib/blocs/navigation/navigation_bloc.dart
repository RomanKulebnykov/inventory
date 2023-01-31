import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(const NavigationState()) {
    on<TapOnGroup>((event, emit) {
      emit(
        NavigationState(
          groupIndex: event.groupIndex,
          screenIndex: state.screenIndex,
        ),
      );
    });
    on<TapOnScreen>((event, emit) {
      emit(
        NavigationState(
          groupIndex: state.groupIndex,
          screenIndex: event.screenIndex,
        ),
      );
    });
  }
}
