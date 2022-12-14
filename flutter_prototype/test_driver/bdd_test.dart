import 'dart:async';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';
import 'package:glob/glob.dart';
import 'steps/InitialStateofApp';
import 'steps/EnterQueue.dart';
import 'steps/CheckQueueState.dart';

Future<void> main() {
  final config = FlutterTestConfiguration()
    ..features = [Glob(r"test_driver/features/**\.feature")]
    ..reporters = [
      ProgressReporter(),
      TestRunSummaryReporter(),
      JsonReporter(path: './report.json')
    ] // you can include the "StdoutReporter()" without the message level parameter for verbose log information
    ..stepDefinitions = [MainPage(), CheckStatus(), EnterQueuee()]
    ..restartAppBetweenScenarios = false
    ..targetAppPath = "test_driver/bdd.dart";
  //..stopAfterTestFailed = true;
  // ..tagExpression = "@smoke" // uncomment to see an example of running scenarios based on tag expressions
  // set to false if debugging to exit cleanly
  return GherkinRunner().execute(config);
}
