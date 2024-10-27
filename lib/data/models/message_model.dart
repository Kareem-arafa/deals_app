class MessageModel {
  int? id;
  int? senderId;
  int? recipientId;
  String? text;
  int? received;
  String? createdAt;
  String? updatedAt;
  int? deletedBySender;
  int? deletedByRecipient;

  MessageModel({
    this.id,
    this.senderId,
    this.recipientId,
    this.text,
    this.received,
    this.createdAt,
    this.updatedAt,
    this.deletedBySender,
    this.deletedByRecipient,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderId = json['sender_id'];
    recipientId = json['recipient_id'];
    text = json['text'];
    received = json['received'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedBySender = json['deleted_by_sender'];
    deletedByRecipient = json['deleted_by_recipient'];
  }
}
