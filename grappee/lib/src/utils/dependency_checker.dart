import 'dart:io';
import 'package:mason_logger/mason_logger.dart';
import 'package:process_run/process_run.dart';

class DependencyChecker {
  final Logger _logger;

  DependencyChecker(this._logger);

  /// Checks if very_good_cli is installed and installs it if needed
  Future<void> ensureVeryGoodCliInstalled() async {
    _logger.info('Checking for very_good_cli...');

    try {
      // Try to run very_good --version to check if it's installed
      final result = await Process.run('very_good', ['--version']);

      if (result.exitCode == 0) {
        _logger.success(
            'very_good_cli is already installed: ${result.stdout.toString().trim()}');
        return;
      }
    } catch (e) {
      // very_good_cli is not installed
      _logger.warn('very_good_cli not found. Installing...');

      try {
        _logger.info('Running: dart pub global activate very_good_cli');
        final installProcess = await Process.run(
          'dart',
          ['pub', 'global', 'activate', 'very_good_cli'],
        );

        if (installProcess.exitCode == 0) {
          _logger.success('very_good_cli installed successfully!');
        } else {
          _logger.err('Failed to install very_good_cli:');
          _logger.err(installProcess.stderr.toString());
          throw Exception('Failed to install very_good_cli');
        }
      } catch (e) {
        _logger.err('Error installing very_good_cli: $e');
        throw Exception('Failed to install very_good_cli: $e');
      }
    }
  }
}
