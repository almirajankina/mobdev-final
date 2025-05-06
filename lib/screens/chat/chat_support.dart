import 'package:flutter/material.dart';

import 'package:flutter_tawkto/flutter_tawk.dart';

void main() => runApp(const ChatSupport());

class ChatSupport extends StatelessWidget {
  const ChatSupport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Shoppe Support',
            style: TextStyle(backgroundColor: Colors.white),
          ),
          backgroundColor: Color(0xFF004CFF),
          elevation: 0,
        ),
        body: Tawk(
          directChatLink:
              'https://tawk.to/chat/681900735510d619105dc5ca/1iqgqjh11',
          visitor: TawkVisitor(
            name: 'test',
            email: 'test@gmail.com',
          ),
          onLoad: () {
            print('Hello!');
          },
          onLinkTap: (String url) {
            print(url);
          },
          placeholder: const Center(
            child: Text('Loading...'),
          ),
        ),
      ),
    );
  }
}
