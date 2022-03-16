class PingResponseModel {
  final String inviteCode;
  final RewardsResponseModel rewards;

  PingResponseModel.fromJson(dynamic json)
      : inviteCode = json['inviteCode'],
        rewards = RewardsResponseModel.fromJson(json['rewards']);
}

class RewardsResponseModel {
  final num dailyRewards;
  final num previousRewards;
  final num communityRewards;
  final num inviterRewards;

  RewardsResponseModel.fromJson(dynamic json)
      : dailyRewards = json['dailyRewards'],
        previousRewards = json['previousRewards'],
        communityRewards = json['communityRewards'],
        inviterRewards = json['inviterRewards'];
}
