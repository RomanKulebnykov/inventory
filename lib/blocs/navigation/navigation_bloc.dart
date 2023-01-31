import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'screen_manager.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  factory NavigationBloc.of(BuildContext context) {
    return context.read<NavigationBloc>();
  }

  static addEvent(BuildContext context, NavigationEvent event) {
    NavigationBloc.of(context).add(event);
  }

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
