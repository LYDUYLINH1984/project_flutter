import 'dart:async';
import 'package:flutter_app_sale_25042023/presentation/page/cart/bloc/count_bloc.dart';
import 'package:flutter_app_sale_25042023/presentation/page/cart/bloc/count_event.dart';

class CountBloc {
  final StreamController<int> _countController = StreamController();
  final StreamController<CountEvent> _eventController = StreamController();
  int _total = 0;

  Stream<int> getCountStream() => _countController.stream;

  CountBloc() {
    _countController.sink.add(_total);
    _eventController.stream.listen((event) {
        if (event is IncreaseEvent) {
          handleIncreaseEvent(event);
        }
        else if (event is DecreaseEvent){
          handleDecreaseEvent(event);
        }
        else if (event is ResetEvent){
          handleResetEvent(event);
        }
    });
  }

  void addEvent(CountEvent countEvent) {
    _eventController.sink.add(countEvent);
  }

  void handleIncreaseEvent(IncreaseEvent event) {
    _total += event.value;
    _countController.sink.add(_total);
  }

  void handleDecreaseEvent(DecreaseEvent event) {
    _total -= event.value;
    _countController.sink.add(_total);
  }

  void handleResetEvent(ResetEvent event) {
    _total = 0;
    _countController.sink.add(_total);
  }

}