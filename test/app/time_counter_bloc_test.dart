import 'package:amttm/app/time_counter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Test TimeCounterBloc", () {
    test('Start will start the respective stopwatch', () {
      final bloc = TimeCounterBloc();
      bloc.start(Timers.aDude);

      expect(bloc.allTimersAreStopped, false);
      expect(bloc.isMeetingRunning, true);
    });
    test('When starting a second stopwatch, the first must be stopped', () {
      final bloc = TimeCounterBloc();
      bloc.start(Timers.aDude);

      expect(bloc.timerTable[Timers.aDude].isRunning, true);
      expect(bloc.timerTable[Timers.notADude].isRunning, false);

      bloc.start(Timers.notADude);
      expect(bloc.timerTable[Timers.aDude].isRunning, false);
      expect(bloc.timerTable[Timers.notADude].isRunning, true);

      expect(bloc.allTimersAreStopped, false);
      expect(bloc.isMeetingRunning, true);
    });
    test('Stop should stop all stopwatches ', () {
      final bloc = TimeCounterBloc();
      bloc.start(Timers.aDude);
      bloc.stop();
      expect(bloc.allTimersAreStopped, true);
      expect(bloc.isMeetingRunning, true);
    });
    test('Reset stops all stopwatches and ends session', () {
      final bloc = TimeCounterBloc();
      bloc.start(Timers.aDude);
      bloc.reset();
      expect(bloc.timerTable[Timers.aDude].isRunning, false);
      expect(bloc.timerTable[Timers.notADude].isRunning, false);
      expect(bloc.allTimersAreStopped, true);
      expect(bloc.isMeetingRunning, false);
    });
  });
}
