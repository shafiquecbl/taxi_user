import 'package:taxi_user/data/model/language.dart';
import 'package:taxi_user/utils/app_constants.dart';

class LanguageRepo {
  List<LanguageModel> getAllLanguages() {
    return AppConstants.languages;
  }
}
