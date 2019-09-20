

class _Item<T> {
  final T data;
  bool running;
  _Item<T> next;

  _Item(this.data);
}

class AsyncFIFOQueue<T> {
  _Item<T> _current;

  final Duration _delay;

  AsyncFIFOQueue(this._delay);

  void push(T item) {
    if (_current != null) {
      _setNext(_current, _Item(item));
    } else {
      _current = _Item(item);
      _current.running = true;

      Future.delayed(_delay, () {

      });
    }
  }

  void _setNext(_Item current, _Item item) {
    if (current.next == null) {
      current.next = item;
    } else {
      _setNext(current.next, item);
    }
  }

  void dispose() {}
}

void main() {}
