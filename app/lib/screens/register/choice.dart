class Choice {

  String value;
  bool selected;

  Choice(this.value, this.selected);

  static from(List<String> values) {

    List<Choice> choices = List();

    for (String value in values) {

      choices.add(Choice(value, false));
    }

    return choices;
  }
}