abstract class LocalStorageService {
  Future<void> saveTheme(bool darkMode);
  Future<bool?> getTheme();
}
