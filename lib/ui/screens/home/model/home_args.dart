import 'package:minimax/ui/utils/consumer.dart';

class HomeArgs {
  final Consumer<bool>? consumer;

  HomeArgs._() : consumer = Consumer(false);

  HomeArgs.fromIsAlreadyConnected(bool isAlreadyConnected) : consumer = Consumer(isAlreadyConnected);
}
