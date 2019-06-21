import 'package:rxdart/rxdart.dart';

import 'bloc_provider.dart';

class TextFieldBloc extends BlocBase {
  List<String> _suggestions = [];
  String _suggestionErrorMsg = "No suggestions available ";

  ///Clear Text
  BehaviorSubject<bool> _clearTextController = BehaviorSubject<bool>();
  Sink<bool> get _clearTextSink => _clearTextController.sink;
  Stream<bool> get clearTextStream => _clearTextController.stream;

  ///Suggestion Controller
  BehaviorSubject<List<String>> _suggestionController =
      BehaviorSubject<List<String>>();
  Sink<List<String>> get _suggestionSink => _suggestionController.sink;
  Stream<List<String>> get suggestionStream => _suggestionController.stream;

  ///Select Value
  BehaviorSubject<String> _selectValueController = BehaviorSubject<String>();
  Sink<String> get _selectValueSink => _selectValueController.sink;
  Stream<String> get selectValueStream => _selectValueController.stream;

  ///Error Value
  BehaviorSubject<String> _errorController = BehaviorSubject<String>();
  Sink<String> get _errorSink => _errorController.sink;
  Stream<String> get errorStream => _errorController.stream;

  TextFieldBloc() {
    _addListener();
  }

  @override
  void dispose() {
    _clearTextController.close();
    _suggestionController.close();
    _selectValueController.close();
    _errorController.close();
  }

  void _addListener() {
    clearTextStream.listen((cleared) => _handleTextClear(cleared));
    selectValueStream.listen((value) => _handleValueSelection(value));
  }

  void listSuggestions(List<String> data, String char) {
    _clearSuggestions();
    _clearError();
    if (char == null || char.isEmpty) {
      _updateSuggestionList();
      return;
    }
    _suggestions = _getMatchedSuggestions(data, char);
    _handleInvalidChar(char);
    _updateSuggestionList();
  }

  List<String> _getMatchedSuggestions(List<String> data, String char) {
    final List<String> result = [];
    for (final item in data.toSet()) {
      if (item.toUpperCase().startsWith(char.toUpperCase())) {
        result.add(item);
      } else if (char.length >= 2) {
        if (item.toUpperCase().contains(char.toUpperCase())) {
          result.add(item);
        }
      }
    }
    return result;
  }

  void _clearSuggestions() => _suggestions.clear();

  void _clearError() => _errorSink.add(null);

  void _handleInvalidChar(String char) => _suggestions.isEmpty
      ? _errorSink.add(_suggestionErrorMsg)
      : _clearError();

  void _updateSuggestionList() => _suggestionSink.add(_suggestions);

  void selectValue(String value) {
    if (value != null && value.isNotEmpty) _selectValueSink.add(value);
  }

  void _handleTextClear(bool cleared) {
    if (cleared) {
      _clearSuggestions();
      _updateSuggestionList();
    }
    _clearError();
  }

  void _handleValueSelection(String value) {
    _clearSuggestions();
    _updateSuggestionList();
    _clearError();
  }

  void setSuggestionErrorMsg(String errorMsg) {
    if (errorMsg != null && errorMsg.isNotEmpty) {
      _suggestionErrorMsg = errorMsg;
    }
  }

  void clearText() => _clearTextSink.add(true);
}
