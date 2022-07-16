import 'package:chat_app/ui/screens/chat_details_screen.dart';
import 'package:flutter/material.dart';

import '../../model/chat_model.dart';
import '../../utils/database_service.dart';
import '../widget/conversation_list.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {


  List<ChatUsers> chatUsers = [
    ChatUsers(name: "Jane Russel", messageText: "Awesome Setup", imageURL: "", time: "Now"),
    ChatUsers(name: "Glady's Murphy", messageText: "That's Great", imageURL: "", time: "Yesterday"),
    ChatUsers(name: "Jorge Henry", messageText: "Hey where are you?", imageURL: "", time: "31 Mar"),
    ChatUsers(name: "Philip Fox", messageText: "Busy! Call me in 20 mins", imageURL: "", time: "28 Mar"),
    ChatUsers(name: "Debra Hawkins", messageText: "Thankyou, It's awesome", imageURL: "", time: "23 Mar"),
    ChatUsers(name: "Jacob Pena", messageText: "will update you in evening", imageURL: "", time: "17 Mar"),
    ChatUsers(name: "Andrey Jones", messageText: "Can you please share the file?", imageURL: "", time: "24 Feb"),
    ChatUsers(name: "John Wick", messageText: "How are you?", imageURL: "", time: "18 Feb"),
  ];

  final GlobalKey<FormState> _formKey = GlobalKey();
  final _usernameController = TextEditingController();
  late final DatabaseService _dbService;
  @override
  void initState() {
     _dbService = DatabaseService.dbInstance;
    // TODO: implement initState
    super.initState();
  }


 void submit(){
     _dbService.addUser(_usernameController.text.trim());

     Navigator.of(context)
         .pushNamed(ChatDetailPage.routeName, arguments: _usernameController.text.trim());

     _usernameController.clear();

      //Navigator.pushNamed(context, ChatDetailPage.routeName);

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      "Conversations",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, top: 2, bottom: 2),
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.pink[50],
                      ),
                      child: InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                  title: const Text('Add Chat'),
                                  content: Form(
                                    key: _formKey,
                                    child: TextFormField(
                                      controller: _usernameController,
                                        cursorColor: Colors.black,
                                        style: const TextStyle(
                                            fontStyle: FontStyle.normal,
                                            color: Colors.black,
                                            fontSize: 17.0,
                                            fontWeight: FontWeight.normal
                                        ),
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(25.0),
                                            borderSide:  const BorderSide(color: Colors.pinkAccent ),

                                          ),

                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(25.0),
                                              borderSide:  const BorderSide(color: Colors.pinkAccent ),

                                            ),
                                          label: const Text('username'),
                                          labelStyle: const TextStyle(
                                            color: Colors.black
                                          ),
                                          hintText: 'Enter Username',
                                          hintStyle: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 11
                                          )
                                        )

                                      /*appInputDecoration(
                                            labelText: "Email Address",
                                            prefixIcon: Icons.alternate_email_outlined)*/
                                    )
                                  ),
                                  actions: [

                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () {
                                          submit();
                                          /*_usernameController.clear();
                                          Navigator.pop(context);*/
                                        },
                                        child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: Colors.pink[50],
                                            ),
                                          child: const Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: Text('Proceed'),
                                          ),
                                        ),
                                      ),
                                    )

                                  ],
                                );

                            },
                          );
                        },
                        child: Row(
                          children: const <Widget>[
                            Icon(
                              Icons.add,
                              color: Colors.pink,
                              size: 20,
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Text(
                              "Add New",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16, left: 16, right: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search...",
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey.shade600,
                    size: 20,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: EdgeInsets.all(8),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.grey.shade100)),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: chatUsers.length,
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 16, bottom: 20),
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index){
                  return ConversationList(
                    name: chatUsers[index].name,
                    messageText: chatUsers[index].messageText,
                    imageUrl: chatUsers[index].imageURL,
                    time: chatUsers[index].time,
                    isMessageRead: (index == 0 || index == 3)?true:false,
                  );
                },
              ),
            ),
          ],
        ),
    );
  }
}
