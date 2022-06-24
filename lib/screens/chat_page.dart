import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_order_project/models/chat.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

class Chatpage extends StatefulWidget {
  const Chatpage({Key? key}) : super(key: key);

  @override
  State<Chatpage> createState() => _ChatpageState();
}

class _ChatpageState extends State<Chatpage> {
  List<Message> messages = [
    Message(
        text: 'hello may i help you?',
        date: DateTime.now().subtract(Duration(minutes: 1)),
        isSentByMe: false),
    // Message() //message...
    // Message() //message...
    //Message() //message...
  ].reversed.toList();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('chat page'),
          backgroundColor: Colors.orange,
        ),
        body: Column(children: [
          Expanded(
            child: GroupedListView<Message, DateTime>(
              padding: const EdgeInsets.all(8),
              elements: messages,
              groupBy: (message) => DateTime(
                message.date.year,
                message.date.month,
                message.date.day,
              ),
              groupHeaderBuilder: (Message message) => SizedBox(
                height: 40,
                child: Center(
                    child: Card(
                  color: Colors.orange,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      DateFormat.yMMMd().format(message.date),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                )),
              ),
              itemBuilder: (context, Message message) => Align(
                alignment: message.isSentByMe
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Card(
                  elevation: 8,
                  child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(message.text)),
                ),
              ),
            ),
          ),
          Container(
            color: Colors.grey,
            child: TextField(
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(12), hintText: 'type here...'),
              onSubmitted: (text) {
                final message = Message(
                  text: text,
                  date: DateTime.now(),
                  isSentByMe: true,
                );

                setState(() => messages.add(message));
              },
            ),
          )
        ]),
      );
}
