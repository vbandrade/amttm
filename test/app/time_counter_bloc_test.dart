import 'package:amttm/app/time_counter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Test TimeCounterBloc", () {
    test('Start will start the respective stopwatch', () {
      final bloc = TimeCounterBloc();
      bloc.start(Timers.aDude);

      expect(bloc.isStopped, false);
      expect(bloc.isCounting, true);
    });
    test('Stop should stop all stopwatches ', () {
      final bloc = TimeCounterBloc();
      bloc.start(Timers.aDude);
      bloc.stop();
      expect(bloc.isStopped, true);
      expect(bloc.isCounting, true);
    });
  });
}
