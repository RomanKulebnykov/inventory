part of 'navigation_bloc.dart';

class NavigationState extends Equatable {
  final int groupIndex;
  final int screenIndex;

  const NavigationState({
    this.groupIndex = 0,
    this.screenIndex = 0,
  });

  NavigationState copyWith({
    int? groupIndex,
    int? screenIndex,
  }) {
    return NavigationState(
      groupIndex: groupIndex ?? this.groupIndex,
      screenIndex: screenIndex ?? this.screenIndex,
    );
  }

  @override
  List<Object> get props => [groupIndex, screenIndex];
}
