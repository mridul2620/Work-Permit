class QuestionLists {
  final int quesId;
  final int quesNo;
  final String quesName;
  bool? answer;

  QuestionLists(
      {required this.quesId, required this.quesName, required this.quesNo, this.answer});
}
