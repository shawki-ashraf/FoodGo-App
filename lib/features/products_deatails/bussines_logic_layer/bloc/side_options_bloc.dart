import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'side_options_event.dart';
part 'side_options_state.dart';

class SideOptionsBloc extends Bloc<SideOptionsEvent, SideOptionsState> {
  SideOptionsBloc() : super(SideOptionsInitial()) {
    on<SideOptionsEvent>((SideOptionsEvent event, Emitter<SideOptionsState> emit) {
      // TODO: implement event handler
    });
  }
}
