// import 'package:bloc/bloc.dart';
//
// /// Observes behavior of WeatherBloc
// class WeatherBlocObserver extends BlocObserver {
/// called before a new event gets dispatched to the stream of Events
//   @override
//   void onEvent(Bloc bloc, Object? event) {
//     super.onEvent(bloc, event);
//   }
/// called before new state is dispatched to the stream of states
//   @override
//   void onChange(BlocBase bloc, Change change) {
//     super.onChange(bloc, change);
//     print('onChange $change');
//   }
/// called before a new state gets dispatched. Contains
/// the current state, the next state, and the event that triggered
/// the new state to be emitted.
//   @override
//   void onTransition(Bloc bloc, Transition transition) {
//     super.onTransition(bloc, transition);
//     print('onTransition $transition');
//   }
/// called when an exception is caught
//   @override
//   void onError(BlocBase bloc,
//       Object error,
//       StackTrace stackTrace,) {
//     print('onError $error');
//     super.onError(bloc, error, stackTrace);
//   }
// }
