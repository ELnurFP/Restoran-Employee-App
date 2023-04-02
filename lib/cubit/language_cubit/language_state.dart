abstract class LocalState {}

class LocalInitState extends LocalState {}

class ChangeLocalState extends LocalState {
  final String lang;

  ChangeLocalState({required this.lang});
}
