import 'package:flutter_test/flutter_test.dart';
import 'package:minimax/data/dependencies/persistence.dart';
import 'package:minimax/ui/screens/congratulations/congratulations_controller.dart';
import 'package:mocktail/mocktail.dart';

class MockMinimaStorage extends Mock implements MinimaStorage {}

void main() {
  late MinimaStorage storage;

  late CongratulationsController subject;

  setUp(() {
    storage = MockMinimaStorage();

    subject = CongratulationsController(storage);
  });

  test("setUserConfiguredDevice", () {
    // Given
    when(() => storage.getUserConfiguredDeviceFirstTime()).thenAnswer((_) => Future.value(true));

    // When
    subject.setUserConfiguredDevice();

    // Then
    verify(() => storage.setUserConfiguredDeviceFirstTime(true));
  });
}
