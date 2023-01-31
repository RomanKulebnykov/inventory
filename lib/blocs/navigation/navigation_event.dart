part of 'navigation_bloc.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();
}

class TapOnGroup extends NavigationEvent {
  final int groupIndex;

  const TapOnGroup(this.groupIndex);

  @override
  List<Object?> get props => [groupIndex];
}

class TapOnScreen extends NavigationEvent {
  final int screenIndex;

  const TapOnScreen(this.screenIndex);

  @override
  List<Object?> get props => [screenIndex];
}
