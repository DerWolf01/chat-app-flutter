import 'package:advanced_change_notifier/advanced_change_notifier.dart';

typedef ListChangeNotifierCallback<T> = Future<void> Function(List<T>? value);

class ListChangeNotifier<T> with AdvancedChangeNotifier<T> {
  final List<ListChangeNotifierCallback<T>> _listeners = [];
  notifyListChangeListeners({List<T>? value}) {
    print("notifying listeners with --> $value");
    for (var l in _listeners) {
      l(value);
    }
  }

  addListChangeListener(ListChangeNotifierCallback<T> callback) {
    _listeners.add(callback);
  }

  removeListChangeListener(ListChangeNotifierCallback<T> callback) {
    _listeners.removeWhere(
      (element) => element == callback,
    );
  }
}
