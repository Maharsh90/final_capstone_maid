import 'package:flutter/material.dart';
import 'package:dialogflow/dialogflow.dart';


class ChatbotScreen extends StatefulWidget {
  @override
  _ChatbotScreenState createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Maid Services Chatbot'),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (_, int index) => _messages[index],
              itemCount: _messages.length,
            ),
          ),
          Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration: InputDecoration.collapsed(
                  hintText: 'Type a message',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: () => _handleSubmitted(_textController.text),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleSubmitted(String text) {
    _textController.clear();

    ChatMessage message = ChatMessage(
      text: text,
      name: 'User',
      type: MessageType.sent,
    );
    setState(() {
      _messages.insert(0, message);
    });

    _getResponse(text);
  }

  void _getResponse(query) async {
    AuthGoogle authGoogle = await AuthGoogle(
      fileJson: 'assets/your_key.json',
    ).build();

    Dialogflow dialogflow = Dialogflow.v2(
      authGoogle: authGoogle,
      language: Language.english,
    );

    AIResponse response = await dialogflow.detectIntent(query);
    ChatMessage botMessage = ChatMessage(
      text: response.getMessage() ?? CardDialogflow(response.getListMessage()[0]).title,
      name: 'Bot',
      type: MessageType.received,
    );
    setState(() {
      _messages.insert(0, botMessage);
    });
  }

  @override
  void dispose() {
    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }
    super.dispose();
  }
}
