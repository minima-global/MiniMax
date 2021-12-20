import 'package:flutter_test/flutter_test.dart';
import 'package:minimax/data/dependencies/persistence.dart';
import 'package:minimax/ui/screens/decider/decider_controller.dart';
import 'package:minimax/ui/screens/decider/model/decider_model.dart';
import 'package:mocktail/mocktail.dart';
import 'package:quiver/testing/async.dart';

import '../../../utils/rx_stream/test_observer.dart';

class MockMinimaStorage extends Mock implements MinimaStorage {}

void main() {
  late MinimaStorage storage;

  late DeciderController subject;

  setUp(() {
    storage = MockMinimaStorage();

    subject = DeciderController(storage);
  });

  test("User configured", () {
    FakeAsync().run((fakeAsync) {
      // Given
      when(() => storage.getUserConfiguredDeviceFirstTime()).thenAnswer((_) => Future.value(true));
      TestObserver<DeciderModel?> observer = subject.decider.testObserver;

      // When
      subject.onInit();
      fakeAsync.flushTimers();

      // Then
      expect(observer.history, containsAllInOrder([DeciderModel.goMain]));
    });
  });

  test("User not configured", () {
    FakeAsync().run((fakeAsync) {
      // Given
      when(() => storage.getUserConfiguredDeviceFirstTime()).thenAnswer((_) => Future.value(false));
      TestObserver<DeciderModel?> observer = subject.decider.testObserver;

      // When
      subject.onInit();
      fakeAsync.flushTimers();

      // Then
      expect(observer.history, containsAllInOrder([DeciderModel.setUp]));
    });
  });
}