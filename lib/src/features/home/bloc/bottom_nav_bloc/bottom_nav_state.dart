part of 'bottom_nav_bloc.dart';

/// Base state for Bottom Navigation BLoC.
///
/// Holds the currently selected tab index ([selectedIndex]).
sealed class BottomNavState extends Equatable {
  final int? selectedIndex;

  const BottomNavState({required this.selectedIndex});

  @override
  List<Object?> get props => [selectedIndex];
}

/// Initial state (no tab selected yet)
class BottomNavInitialState extends BottomNavState {
  const BottomNavInitialState() : super(selectedIndex: null);
}

/// State when a tab is selected
class BottomNavSelectedState extends BottomNavState {
  const BottomNavSelectedState({required int selectedIndex})
      : super(selectedIndex: selectedIndex);
}