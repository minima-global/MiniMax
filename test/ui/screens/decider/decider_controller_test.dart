import 'package:flutter_test/flutter_test.dart';
import 'package:minimax/data/dependencies/background.dart';
import 'package:minimax/data/dependencies/persistence.dart';
import 'package:minimax/ui/screens/decider/decider_controller.dart';
import 'package:minimax/ui/screens/decider/model/decider_model.dart';
import 'package:mocktail/mocktail.dart';
import 'package:quiver/testing/async.dart';

import '../../../utils/rx_stream/test_observer.dart';

class MockMinimaStorage extends Mock implements MinimaStorage {}

class MockBackgroundService extends Mock implements BackgroundService {}

void main() {
  late MinimaStorage storage;
  late MockBackgroundService backgroundService;

  late DeciderController subject;

  setUp(() {
    storage = MockMinimaStorage();
    backgroundService = MockBackgroundService();

    subject = DeciderController(storage, backgroundService);
  });

  test("User configured", () {
    FakeAsync().run((fakeAsync) {
      // Given
      when(() => storage.getUserConfiguredDeviceFirstTime()).thenAnswer((_) => Future.value(true));
      when(() => storage.getUserWantsToKeepRunningTheService()).thenAnswer((_) => Future.value(true));
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
      when(() => storage.getUserWantsToKeepRunningTheService()).thenAnswer((_) => Future.value(true));
      TestObserver<DeciderModel?> observer = subject.decider.testObserver;

      // When
      subject.onInit();
      fakeAsync.flushTimers();

      // Then
      expect(observer.history, containsAllInOrder([DeciderModel.setUp]));
    });
  });

  test("onInit starts background service if the user went through a decision - true", () {
    FakeAsync().run((fakeAsync) {
      // Given
      when(() => storage.getUserConfiguredDeviceFirstTime()).thenAnswer((_) => Future.value(false));
      when(() => storage.getUserWantsToKeepRunningTheService()).thenAnswer((_) => Future.value(true));

      // When
      subject.onInit();
      fakeAsync.flushTimers();

      // Then
      verify(() => backgroundService.startBackgroundService(true));
    });
  });

  test("onInit starts background service if the user went through a decision - false", () {
    FakeAsync().run((fakeAsync) {
      // Given
      when(() => storage.getUserConfiguredDeviceFirstTime()).thenAnswer((_) => Future.value(false));
      when(() => storage.getUserWantsToKeepRunningTheService()).thenAnswer((_) => Future.value(false));

      // When
      subject.onInit();
      fakeAsync.flushTimers();

      // Then
      verify(() => backgroundService.startBackgroundService(false));
    });
  });

  test("onInit does not start background service if the user didn't go through a decision", () {
    FakeAsync().run((fakeAsync) {
      // Given
      when(() => storage.getUserConfiguredDeviceFirstTime()).thenAnswer((_) => Future.value(false));
      when(() => storage.getUserWantsToKeepRunningTheService()).thenAnswer((_) => Future.value(null));

      // When
      subject.onInit();
      fakeAsync.flushTimers();

      // Then
      verifyNever(() => backgroundService.startBackgroundService(any()));
    });
  });
}
