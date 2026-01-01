part of 'bottom_nav_bloc.dart';

/// Event triggered when the tab is selected.
///
/// Carries the [selectedIndex] to indicate which tab was chosen.
sealed class BottomNavEvent extends Equatable {
  const BottomNavEvent();

  @override
  List<Object?> get props => [];
}

/// Fired when any bottom tab is selected
class BottomNavTabChanged extends BottomNavEvent {
  final int index;

  const BottomNavTabChanged(this.index);

  @override
  List<Object?> get props => [index];
}

/// Reset to initial state if needed
class ResetBottomNavEvent extends BottomNavEvent {}