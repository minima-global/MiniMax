import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minimax/data/dependencies/persistence.dart';
import 'package:mocktail/mocktail.dart';
import 'package:quiver/testing/src/async/fake_async.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  late FlutterSecureStorage storage;

  late MinimaStorage subject;

  setUp(() {
    storage = MockFlutterSecureStorage();

    subject = MinimaStorage(storage);
  });

  test("Value not there", () async {
    // Given
    when(() => storage.read(key: "_userConfiguredDeviceFirstTime")).thenAnswer((_) => Future.value(null));

    // When
    bool result = await subject.getUserConfiguredDeviceFirstTime();

    // Then
    expect(result, false);
  });

  test("Value false", () async {
    // Given
    when(() => storage.read(key: "_userConfiguredDeviceFirstTime")).thenAnswer((_) => Future.value("false"));

    // When
    bool result = await subject.getUserConfiguredDeviceFirstTime();

    // Then
    expect(result, false);
  });

  test("Value true", () async {
    // Given
    when(() => storage.read(key: "_userConfiguredDeviceFirstTime")).thenAnswer((_) => Future.value("true"));

    // When
    bool result = await subject.getUserConfiguredDeviceFirstTime();

    // Then
    expect(result, true);
  });

  test("Setting value", () async {
    FakeAsync().run((fakeAsync) {
      // Given
      when(() => storage.write(key: any(named: "key"), value: any(named: "value"))).thenAnswer((_) => Future.value());

      // When
      subject.setUserConfiguredDeviceFirstTime(true);
      fakeAsync.flushTimers();

      // Then
      verify(() => storage.write(key: "_userConfiguredDeviceFirstTime", value: "true"));
    });
  });
}
