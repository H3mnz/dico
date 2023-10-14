class ResultModel {
  late String word;
  late String mean;
  ResultModel({required this.word, required this.mean});
  ResultModel.fromJson(Map<String, dynamic> result) {
    word = result['en'];
    mean = result['fa'];
  }
}
