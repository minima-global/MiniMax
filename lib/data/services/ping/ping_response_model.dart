abstract class PingResponseModel {
  static PingResponseModel fromJson(dynamic json) {
    if (json == null) {
      return IncorrectUidPingResponseModel();
    } else {
      return CorrectPingUidResponseModel.fromJson(json);
    }
  }
}

class CorrectPingUidResponseModel extends PingResponseModel {
  final String inviteCode;
  final RewardsResponseModel rewards;

  CorrectPingUidResponseModel.fromJson(dynamic json)
      : inviteCode = json['inviteCode'],
        rewards = RewardsResponseModel.fromJson(json['rewards']);
}

class IncorrectUidPingResponseModel extends PingResponseModel { }

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
