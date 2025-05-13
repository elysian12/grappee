import 'dart:io';
import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart' as path;
import 'package:process_run/process_run.dart';
import 'architecture_setup.dart';

class ProjectCreator {
  final Logger _logger;

  ProjectCreator(this._logger);

  Future<void> createProject(String name, String org, String template) async {
    // Step 1: Use very_good create to scaffold the project
    _logger.info('Creating Flutter project using very_good_cli...');

    final args = [
      'create',
      'flutter_app',
      name,
      '--org',
      org,
      '--desc',
      'A Grappus Flutter project',
    ];

    final result = await Process.run('very_good', args);

    if (result.exitCode != 0) {
      _logger.err('Failed to create project:');
      _logger.err(result.stderr.toString());
      throw Exception('very_good create failed');
    }

    // Step 2: Set up Grappus architecture
    _logger.info('Setting up Grappus architecture...');

    final projectPath = path.join(Directory.current.path, name);
    final architecture = template == 'basic' ? 'clean' : 'bloc';

    final architectureSetup = ArchitectureSetup(_logger);
    await architectureSetup.setupArchitecture(projectPath, architecture);

    _logger.info('Installing dependencies...');
    await Process.run('flutter', ['pub', 'get'], workingDirectory: projectPath);

    _logger.success('Project created with Grappus architecture!');
    _logger.info('');
    _logger.info('Next steps:');
    _logger.info('  cd $name');
    _logger.info('  flutter run');
  }
}
