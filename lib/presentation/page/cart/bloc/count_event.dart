abstract class CountEvent { }

class IncreaseEvent extends CountEvent {
  int value;

  IncreaseEvent({required this.value});
}

class DecreaseEvent extends CountEvent {
  int value;

  DecreaseEvent({required this.value});
}

class ResetEvent extends CountEvent {
  int value;

  ResetEvent({required this.value});
}