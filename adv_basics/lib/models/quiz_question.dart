class QuizQuestion {
  const QuizQuestion(this.text, this.answers);

  final String text;
  final List<String> answers;

  List<String> get shuffledAnswers {
    final shufflerList = List.of(answers);

    shufflerList.shuffle();
    return shufflerList;
  }
}
