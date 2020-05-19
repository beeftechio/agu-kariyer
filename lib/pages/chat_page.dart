import 'package:agucareer/models/message_model.dart';
import 'package:agucareer/models/user_model.dart';
import 'package:agucareer/viewmodels/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  final User me;
  final User it;

  ChatPage({this.me, this.it});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  var _messageController = TextEditingController();
  var _scrollControoler = ScrollController();

  @override
  Widget build(BuildContext context) {
    final _userModel = Provider.of<UserModel>(context);
    User _from = widget.me;
    User _to = widget.it;

    void _sendMessage() async {
      try {
        if (_messageController.text.trim().length > 0) {
          Message _sentMessage = Message(
              from: _from.userID,
              to: _to.userID,
              isMine: true,
              message: _messageController.text);
          var result = await _userModel.sendMessage(_sentMessage);
          if (result) {
            _messageController.clear();
            _scrollControoler.animateTo(0,
                duration: const Duration(milliseconds: 100),
                curve: Curves.easeOut);
          }
        }
      } catch (e) {
        debugPrint("ChatPage ERROR ${e.toString()}");
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Sohbet"),
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder<List<Message>>(
              stream: _userModel.getMessages(_from.userID, _to.userID),
              builder: (context, streamData) {
                if (!streamData.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.red,
                    ),
                  );
                } else {
                  var messages = streamData.data;
                  return ListView.builder(
                    reverse: true,
                    controller: _scrollControoler,
                    itemBuilder: (context, index) {
                      return _createMessageBox(messages[index]);
                    },
                    itemCount: messages.length,
                  );
                }
              },
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 8, left: 8),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    cursorColor: Colors.blueGrey,
                    style: new TextStyle(fontSize: 16.0, color: Colors.black),
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Mesajınızı yazın",
                        border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                            borderSide: BorderSide.none)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  child: FloatingActionButton(
                    elevation: 0,
                    backgroundColor: Colors.blue,
                    child: Icon(
                      Icons.navigation,
                      size: 35,
                      color: Colors.white,
                    ),
                    onPressed: () => _sendMessage(),
                  ),
                )
              ],
            ),
          )
        ],
      )),
    );
  }

  Widget _createMessageBox(Message message) {
    Color _inMessageColor = Colors.blue;
    Color _outMessageColor = Colors.amber;

    var _timeValue = _showTimeStamp(message.date ?? Timestamp(1, 1));

    var _isMyMessage = message.isMine;
    if (_isMyMessage) {
      return Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Flexible(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: _outMessageColor,
                    ),
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(4),
                    child: Text(message.message),
                  ),
                ),
                Text(_timeValue)
              ],
            )
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.it.profileURL),
                ),
                Flexible(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: _inMessageColor,
                    ),
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(4),
                    child: Text(
                      message.message,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Text(_timeValue)
              ],
            )
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      );
    }
  }

  String _showTimeStamp(Timestamp date) {
    var _formatter = DateFormat.Hm();
    return _formatter.format(date.toDate());
  }
}