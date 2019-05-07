import 'package:scoped_model/scoped_model.dart';

class BaseModel extends Model {
  bool _loading = false;

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }
}
