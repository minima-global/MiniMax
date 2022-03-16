import 'package:minimax/ui/widgets/status.dart';

class IncentiveProgramModel {
  final num minimaBalance;
  final DateTime lastPing;
  final Status status;

  IncentiveProgramModel({
    required this.minimaBalance,
    required this.lastPing,
    required this.status,
  });

  IncentiveProgramModel.offline()
      : minimaBalance = 0,
        lastPing = DateTime.now(),
        status = Status.inactive;
}
