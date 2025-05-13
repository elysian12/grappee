import 'dart:io';
import 'package:args/command_runner.dart';
import 'package:grappee/grappee.dart';
import 'package:mason_logger/mason_logger.dart';

Future<void> main(List<String> args) async {
  final logger = Logger();

  try {
    final runner = CommandRunner('grappee', 'Grappus project setup CLI tool')
      ..addCommand(CreateCommand(logger))
      ..addCommand(SetupCommand(logger));

    await runner.run(args);
  } catch (e) {
    logger.err('$e');
    exit(1);
  }
}
