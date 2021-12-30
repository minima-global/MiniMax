import 'package:minimax/ui/widgets/status.dart';

class IncentiveCashModel {
  final num minimaBalance;
  final DateTime lastPing;
  final Status status;

  IncentiveCashModel({
    required this.minimaBalance,
    required this.lastPing,
    required this.status,
  });

  IncentiveCashModel.offline()
      : minimaBalance = 0,
        lastPing = DateTime.now(),
        status = Status.unknown;
}
