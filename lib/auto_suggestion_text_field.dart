import 'package:auto_suggestion_text_field/model/text_field_prop.dart';
import 'package:flutter/material.dart';

import 'package:auto_suggestion_text_field/blocs/bloc_provider.dart';
import 'package:auto_suggestion_text_field/blocs/text_field_bloc.dart';

class AutoSugesstionTextField extends StatefulWidget {
  final TextFieldProperties props;
  AutoSugesstionTextField({
    Key key,
    @required this.props,
  }) : super(key: key);

  @override
  _AutoSugesstionTextFieldState createState() =>
      _AutoSugesstionTextFieldState();
}

class _AutoSugesstionTextFieldState extends State<AutoSugesstionTextField> {
  TextFieldBloc _bloc;
  TextFieldProperties _props;
  TextEditingController _controller;

  @override
  void initState() {
    _initVariables();
    _addListener();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _suggestionTextField;
  }

  void _initVariables() {
    _props = widget.props;
    _bloc = BlocProvider.of<TextFieldBloc>(context);
    _bloc.setSuggestionErrorMsg(_props.error);
    if (_props.controller != null) {
      _controller = _props.controller;
    } else {
      _controller = TextEditingController();
    }
  }

  _addListener() {
    _bloc.clearTextStream.listen((textCleared) => _onTextCleared(textCleared));
    _bloc.selectValueStream.listen((value) => _onValueSelected(value));
  }

  static const _oneCellHeight = 10.0;

  double _containerHeight(int listLength) {
    if (listLength < 1) {
      return 0.0;
    }
    if (listLength == 1) {
      return _props.fieldHeight + _oneCellHeight;
    } else if (listLength == 2) {
      return _props.fieldHeight + _oneCellHeight * 2.0;
    }
    return _props.fieldHeight * 2.0;
  }

  get _suggestionTextField {
    return StreamBuilder(
      stream: _bloc.suggestionStream,
      builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
        return Card(
          color: _props.backgroundColor ?? Colors.white,
          elevation: _props.elevation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _textFieldContainer,
              _suggestionList(snapshot.data ?? []),
            ],
          ),
        );
      },
    );
  }

  Widget get _textFieldContainer {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(width: 10.0),
        _props.icon ??
            Icon(
              Icons.search,
              color: Theme.of(context).accentColor,
            ),
        SizedBox(width: 10.0),
        _textField,
        IconButton(
          icon: Icon(
            Icons.clear,
            color: Theme.of(context).accentColor,
          ),
          onPressed: _bloc.clearText,
        ),
        SizedBox(width: 10.0),
      ],
    );
  }

  Widget get _textField {
    return Flexible(
      child: StreamBuilder(
        stream: _bloc.errorStream,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          return TextField(
            onChanged: (char) => _onTextFieldValueChange(char),
            controller: _controller,
            cursorColor: Theme.of(context).accentColor,
            decoration: InputDecoration(
              labelText: _props.label ?? "",
              labelStyle: TextStyle(
                color: _props.labelColor ?? Theme.of(context).accentColor,
              ),
              hintText: _props.hint,
              errorText: snapshot.hasData ? snapshot.data : "",
              errorStyle: TextStyle(color: Theme.of(context).errorColor),
              border: InputBorder.none,
            ),
          );
        },
      ),
    );
  }

  Widget _suggestionList(List<String> suggestions) {
    if (suggestions.length < 1) {
      return Container(
        width: 0.0,
        height: 0.0,
      );
    }
    return Container(
      height: _containerHeight(suggestions.length),
      child: ListView.builder(
        itemCount: suggestions.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (context, i) => _listItem(suggestions[i]),
      ),
    );
  }

  Widget _listItem(String title) => ListTile(
        title: Text(title),
        onTap: () => _bloc.selectValue(title),
      );

  _onTextCleared(bool cleared) {
    if (cleared) {
      _controller.text = "";
      _props.onValueSelect("");
    }
  }

  _onTextFieldValueChange(String char) =>
      _bloc.listSuggestions(_props.data, char);

  _onValueSelected(String value) {
    _controller.text = value;
    _props.onValueSelect(value);
  }
}
