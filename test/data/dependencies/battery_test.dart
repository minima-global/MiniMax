import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minimax/data/dependencies/battery.dart';
import 'package:mocktail/mocktail.dart';

class MockChannel extends Mock implements MethodChannel {}

void main() {
  late MethodChannel _methodChannel;

  late BatteryProvider subject;

  setUp(() {
    _methodChannel = MockChannel();

    subject = BatteryProvider(_methodChannel);
  });

  test("Exception if method is not implemented", () {
    dynamic e;

    try {
      // Given
      when(() => _methodChannel.invokeMethod("ignoreBatteryOptimization")).thenAnswer((_) => Future.value(null));

      // When
      subject.ignoreBatteryOptimization();
    } catch (exception) {
      e = exception;
    }

    // Then
    expect(e, isNotNull);
  });

  for (bool possibleValue in [true, false]) {
    test("$possibleValue returned", () async {
      // Given
      when(() => _methodChannel.invokeMethod<bool?>("ignoreBatteryOptimization"))
          .thenAnswer((_) => Future.value(possibleValue));

      // When
      bool result = await subject.ignoreBatteryOptimization();

      // Then
      expect(result, possibleValue);
    });
  }
}
