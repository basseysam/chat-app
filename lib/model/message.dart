import 'package:chat_app/utils/database_service.dart';

class Message {


  String userID;
  String message;
  String time;
  String sender;
  String read;

  Message(this.userID, this.message, this.time, this.sender, this.read);


  Map<String, dynamic> toMap() => {
    DatabaseService.COLUMN_USER_ID : userID,
    DatabaseService.COLUMN_MESSAGE : message,
    DatabaseService.COLUMN_TIMESTAMP : time,
    DatabaseService.COLUMN_SENDER : sender,
    DatabaseService.COLUMN_READ : read
  };
}