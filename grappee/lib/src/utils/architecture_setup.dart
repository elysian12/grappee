import 'dart:io';
import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart' as path;
import '../templates/architecture_templates.dart';

class ArchitectureSetup {
  final Logger _logger;

  ArchitectureSetup(this._logger);

  Future<void> setupArchitecture(
      String projectPath, String architecture) async {
    final templates = ArchitectureTemplates();

    // Create directories based on chosen architecture
    switch (architecture) {
      case 'clean':
        await _setupCleanArchitecture(projectPath, templates);
        break;
      case 'mvvm':
        await _setupMvvmArchitecture(projectPath, templates);
        break;
      case 'bloc':
        await _setupBlocArchitecture(projectPath, templates);
        break;
      default:
        throw Exception('Unknown architecture: $architecture');
    }

    // Update pubspec.yaml with needed dependencies
    await _updatePubspec(projectPath, architecture);

    _logger.success('Architecture setup complete!');
  }

  Future<void> _setupCleanArchitecture(
      String projectPath, ArchitectureTemplates templates) async {
    final libPath = path.join(projectPath, 'lib');

    // Create main directories
    final directories = [
      'core',
      'core/error',
      'core/network',
      'core/utils',
      'data',
      'data/datasources',
      'data/models',
      'data/repositories',
      'domain',
      'domain/entities',
      'domain/repositories',
      'domain/usecases',
      'presentation',
      'presentation/bloc',
      'presentation/pages',
      'presentation/widgets',
    ];

    for (final dir in directories) {
      _logger.info('Creating directory: $dir');
      await Directory(path.join(libPath, dir)).create(recursive: true);
    }

    // Add placeholder files
    await File(path.join(libPath, 'core/error/failures.dart'))
        .writeAsString(templates.failuresTemplate);

    await File(path.join(libPath, 'core/utils/constants.dart'))
        .writeAsString(templates.constantsTemplate);

    await File(path.join(libPath, 'core/network/network_info.dart'))
        .writeAsString(templates.networkInfoTemplate);
  }

  Future<void> _setupMvvmArchitecture(
      String projectPath, ArchitectureTemplates templates) async {
    final libPath = path.join(projectPath, 'lib');

    // Create main directories
    final directories = [
      'core',
      'core/services',
      'core/utils',
      'models',
      'views',
      'viewmodels',
      'widgets',
    ];

    for (final dir in directories) {
      _logger.info('Creating directory: $dir');
      await Directory(path.join(libPath, dir)).create(recursive: true);
    }

    // Add placeholder files
    await File(path.join(libPath, 'core/services/api_service.dart'))
        .writeAsString(templates.apiServiceTemplate);

    await File(path.join(libPath, 'core/utils/constants.dart'))
        .writeAsString(templates.constantsTemplate);
  }

  Future<void> _setupBlocArchitecture(
      String projectPath, ArchitectureTemplates templates) async {
    final libPath = path.join(projectPath, 'lib');

    // Create main directories
    final directories = [
      'core',
      'core/utils',
      'data',
      'data/repositories',
      'logic',
      'logic/blocs',
      'logic/cubits',
      'presentation',
      'presentation/screens',
      'presentation/widgets',
    ];

    for (final dir in directories) {
      _logger.info('Creating directory: $dir');
      await Directory(path.join(libPath, dir)).create(recursive: true);
    }

    // Add placeholder files
    await File(path.join(libPath, 'core/utils/constants.dart'))
        .writeAsString(templates.constantsTemplate);

    await File(path.join(libPath, 'logic/blocs/README.md'))
        .writeAsString('# Blocs\n\nStore your BLoC classes in this directory.');
  }

  Future<void> _updatePubspec(String projectPath, String architecture) async {
    final pubspecPath = path.join(projectPath, 'pubspec.yaml');
    final file = File(pubspecPath);
    String content = await file.readAsString();

    // Add architecture-specific dependencies
    switch (architecture) {
      case 'clean':
      case 'bloc':
        if (!content.contains('flutter_bloc:')) {
          content = content.replaceFirst(
            'dependencies:',
            'dependencies:\n  flutter_bloc: ^8.1.2\n  equatable: ^2.0.5\n  get_it: ^7.6.0\n  dartz: ^0.10.1',
          );
        }
        break;
      case 'mvvm':
        if (!content.contains('provider:')) {
          content = content.replaceFirst(
            'dependencies:',
            'dependencies:\n  provider: ^6.0.5\n  get_it: ^7.6.0',
          );
        }
        break;
    }

    await file.writeAsString(content);
  }
}
