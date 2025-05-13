class ArchitectureTemplates {
  // Core Failures Template
  String get failuresTemplate => '''
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure([List properties = const <dynamic>[]]);
}

// General failures
class ServerFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class CacheFailure extends Failure {
  @override
  List<Object?> get props => [];
}
''';

  // Network Info Template
  String get networkInfoTemplate => '''
abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  @override
  Future<bool> get isConnected async {
    // TODO: Implement connection checking
    return true;
  }
}
''';

  // Constants Template
  String get constantsTemplate => '''
class AppConstants {
  // API
  static const String baseUrl = 'https://api.example.com';
  
  // Routes
  static const String homeRoute = '/home';
  static const String detailsRoute = '/details';
  
  // Shared Preferences Keys
  static const String userTokenKey = 'user_token';
  static const String userDataKey = 'user_data';
}
''';

  // API Service Template
  String get apiServiceTemplate => '''
class ApiService {
  // TODO: Implement API service methods
  
  Future<dynamic> get(String endpoint) async {
    // Implement GET request
    return null;
  }
  
  Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    // Implement POST request
    return null;
  }
}
''';
}
