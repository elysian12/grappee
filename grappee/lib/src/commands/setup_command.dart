import 'dart:io';
import 'package:args/command_runner.dart';
import 'package:mason_logger/mason_logger.dart';
import '../utils/dependency_checker.dart';
import '../utils/architecture_setup.dart';

class SetupCommand extends Command<void> {
  @override
  final String name = 'setup';

  @override
  final String description =
      'Set up Grappus architecture in an existing project';

  final Logger _logger;

  SetupCommand(this._logger) {
    argParser.addOption(
      'path',
      abbr: 'p',
      help: 'Path to the project',
      defaultsTo: '.',
    );

    argParser.addOption(
      'architecture',
      abbr: 'a',
      help: 'Architecture type to set up',
      allowed: ['mvvm', 'clean', 'bloc'],
      defaultsTo: 'clean',
    );
  }

  @override
  Future<void> run() async {
    final projectPath = argResults!['path'] as String;
    final architecture = argResults!['architecture'] as String;

    _logger.info('Setting up Grappus $architecture architecture');

    // Set up architecture
    final setupManager = ArchitectureSetup(_logger);
    await setupManager.setupArchitecture(projectPath, architecture);

    _logger.success('Architecture setup complete!');
  }
}
