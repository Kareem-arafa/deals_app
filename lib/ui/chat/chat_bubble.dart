import 'package:dealz/data/models/message_model.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatefulWidget {
  final bool? isME;
  final MessageModel messageModel;

  const ChatBubble({Key? key, this.isME, required this.messageModel}) : super(key: key);

  @override
  _ChatBubbleState createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.isME!
          ? AlignmentDirectional.topEnd
          : AlignmentDirectional.topStart,
      child: IntrinsicWidth(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: !widget.isME!
                  ? [
                      Color(0xffe4e4e9),
                      Color(0xffe4e4e9),
                    ]
                  : [
                      Color(0xff15a8e1),
                      Color(0xff345ca1),
                    ],
              stops: [0, 1],
              begin: Alignment(-0.91, -0.41),
              end: Alignment(0.91, 0.41),
            ),
            borderRadius: BorderRadius.only(
              topLeft:
                  !widget.isME! ? Radius.circular(0.0) : Radius.circular(15.0),
              topRight:
                  !widget.isME! ? Radius.circular(15.0) : Radius.circular(0.0),
              bottomLeft: Radius.circular(15.0),
              bottomRight: Radius.circular(15.0),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(
              16,
            ),
            child: Column(
              children: [
                Align(
                  alignment: AlignmentDirectional.bottomStart,
                  child: Text(
                    widget.messageModel.text ?? "",
                    style: TextStyle(
                      color: widget.isME! ? Colors.white : Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
