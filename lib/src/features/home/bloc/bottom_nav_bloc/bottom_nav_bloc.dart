import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/logger.dart';

part 'bottom_nav_event.dart';
part 'bottom_nav_state.dart';

/// Handles state management for **Bottom Navigation** and its related entities.
class BottomNavBloc extends Bloc<BottomNavEvent, BottomNavState> {
  BottomNavBloc() : super(const BottomNavInitialState()) {
    on<BottomNavTabChanged>(_onTabChanged);
    on<ResetBottomNavEvent>(_onReset);
  }

  void _onTabChanged(BottomNavTabChanged event, Emitter<BottomNavState> emit,) {
    emit(
      BottomNavSelectedState(
        selectedIndex: event.index,
      ),
    );
  }

  void _onReset(ResetBottomNavEvent event, Emitter<BottomNavState> emit,) {
    emit(const BottomNavInitialState());
  }

  @override
  Future<void> close() {
    logger.i("===== CLOSE BottomNavBloc =====");
    return super.close();
  }
}