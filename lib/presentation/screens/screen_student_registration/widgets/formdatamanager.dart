// Create a new file: form_data_manager.dart

class FormDataManager {
  static final FormDataManager _instance = FormDataManager._internal();
  factory FormDataManager() => _instance;
  FormDataManager._internal();

  // Map to store form data temporarily
  Map<String, dynamic> _formData = {};

  // Save form data
  void saveFormData({
    required String name,
    required String age,
    required String school,
    required String city,
    required String country,
    required String dob,
    String? imagePath,
  }) {
    _formData = {
      'name': name,
      'age': age,
      'school': school,
      'city': city,
      'country': country,
      'dob': dob,
      'imagePath': imagePath,
    };
  }

  // Get form data
  Map<String, dynamic> getFormData() {
    return Map<String, dynamic>.from(_formData);
  }

  // Clear form data
  void clearFormData() {
    _formData.clear();
  }

  // Check if form data exists
  bool hasFormData() {
    return _formData.isNotEmpty;
  }
}