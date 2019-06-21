library auto_suggestion_text_field;

import 'package:auto_suggestion_text_field/auto_suggestion_text_field.dart';
import 'package:auto_suggestion_text_field/blocs/bloc_provider.dart';
import 'package:auto_suggestion_text_field/blocs/text_field_bloc.dart';
import 'package:auto_suggestion_text_field/model/text_field_prop.dart';
import 'package:flutter/material.dart';

class SuggestionTextField extends StatelessWidget {
  final TextFieldProperties props;
  const SuggestionTextField({
    Key key,
    @required this.props,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: TextFieldBloc(),
      child: AutoSugesstionTextField(
        props: this.props,
      ),
    );
  }
}
