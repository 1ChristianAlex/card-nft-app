class ActionCreator<T> {
  final Enum type;
  final T? payload;

  ActionCreator({required this.type, required this.payload});
}
