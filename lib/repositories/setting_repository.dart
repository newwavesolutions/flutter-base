import 'package:flutter_base/network/api_client.dart';

abstract class SettingRepository {
  Future<void> getSettings();
}

class SettingRepositoryImpl extends SettingRepository {
  ApiClient _apiClient;

  SettingRepositoryImpl(ApiClient client) {
    _apiClient = client;
  }

  @override
  Future<void> getSettings() async {
    try {
      return await _apiClient.getSetting();
    } catch (error) {
      throw error;
    }
  }
}
