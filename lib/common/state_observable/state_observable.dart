class StateObservable<T> {
  late T _state;
  late Function(void Function() fn) setWidgetState;
  late final List<Function(T s)> _subscribers;

  get state {
    return _state;
  }

  StateObservable(
      {required T state, required Function(void Function() fn) setState}) {
    _state = state;
    _subscribers = [];
    setWidgetState = setState;
  }

  void setState(T newState) {
    setWidgetState(() {
      _state = newState;
    });

    _notify();
  }

  void _notify() {
    for (var sub in _subscribers) {
      sub(_state);
    }
  }

  void setSubscription(Function(T s) callback) {
    _subscribers.add(callback);
  }
}
