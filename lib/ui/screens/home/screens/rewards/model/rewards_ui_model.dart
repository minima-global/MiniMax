import 'package:minimax/data/services/ping/ping_response_model.dart';

abstract class RewardsUIModel {
  abstract final String totalRewards;
  abstract final String dailyNodeRewards;
  abstract final String inviteRewards;
  abstract final String additionalRewards;

  static RewardsUIModel fromPingResponseModel(PingResponseModel? pingResponseModel) {
    if (pingResponseModel is CorrectPingUidResponseModel) {
      return ValidRewardsUIModel(
        rewards: pingResponseModel.rewards.communityRewards +
            pingResponseModel.rewards.dailyRewards +
            pingResponseModel.rewards.inviterRewards +
            pingResponseModel.rewards.previousRewards,
        dailyNodeRewards: pingResponseModel.rewards.dailyRewards + pingResponseModel.rewards.previousRewards,
        inviteRewards: pingResponseModel.rewards.inviterRewards,
        additionalRewards: pingResponseModel.rewards.communityRewards,
      );
    } else {
      return NotValidRewardsUIModel();
    }
  }
}

class ValidRewardsUIModel extends RewardsUIModel {
  @override
  final String totalRewards;
  @override
  final String dailyNodeRewards;
  @override
  final String inviteRewards;
  @override
  final String additionalRewards;

  ValidRewardsUIModel({
    required num rewards,
    required num dailyNodeRewards,
    required num inviteRewards,
    required num additionalRewards,
  })  : totalRewards = rewards.toStringAsFixed(2),
        dailyNodeRewards = dailyNodeRewards.toStringAsFixed(2),
        inviteRewards = inviteRewards.toStringAsFixed(2),
        additionalRewards = additionalRewards.toStringAsFixed(2);
}

class NotValidRewardsUIModel extends RewardsUIModel {
  @override
  String get additionalRewards => "";

  @override
  String get dailyNodeRewards => "";

  @override
  String get inviteRewards => "";

  @override
  String get totalRewards => "";
}
