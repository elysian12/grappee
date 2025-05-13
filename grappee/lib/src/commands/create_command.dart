import 'dart:io';
import 'package:args/command_runner.dart';
import 'package:mason_logger/mason_logger.dart';
import '../utils/dependency_checker.dart';
import '../utils/project_creator.dart';

class CreateCommand extends Command<void> {
  @override
  final String name = 'create';

  @override
  final String description =
      'Create a new Grappus project with standardized architecture';

  final Logger _logger;

  CreateCommand(this._logger) {
    argParser.addOption(
      'name',
      abbr: 'n',
      help: 'Name of the project',
      mandatory: true,
    );

    argParser.addOption(
      'org',
      help: 'Organization name (e.g., com.grappus)',
      defaultsTo: 'com.grappus',
    );

    argParser.addOption(
      'template',
      abbr: 't',
      help: 'Project template to use',
      allowed: ['basic', 'full'],
      defaultsTo: 'basic',
    );
  }

  @override
  Future<void> run() async {
    final projectName = argResults!['name'] as String;
    final orgName = argResults!['org'] as String;
    final template = argResults!['template'] as String;

    _logger.info('Creating new Grappus project: $projectName');

    // Check for very_good_cli
    final dependencyChecker = DependencyChecker(_logger);
    await dependencyChecker.ensureVeryGoodCliInstalled();

    // Create project using very_good_cli
    final creator = ProjectCreator(_logger);
    await creator.createProject(projectName, orgName, template);

    _logger.success('Project created successfully!');
  }
}
