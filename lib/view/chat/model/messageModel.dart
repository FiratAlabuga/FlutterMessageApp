class MessageModel {
  final String message;
  final int fromWho;
  final bool isSeenWhen;
  final String time;

  MessageModel(this.message, this.fromWho, this.isSeenWhen, this.time);
}
