// import 'package:flutter/material.dart';
// import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
// import 'package:flutter_chat_ui/flutter_chat_ui.dart';
// import 'package:monumental_habits/util/helper.dart';

// import 'package:uuid/uuid.dart';

// class Community extends StatefulWidget {
//   const Community({super.key});

//   @override
//   State<Community> createState() => _ChatPageState();
// }

// class _ChatPageState extends State<Community> {
//   final messageController = TextEditingController();
//   final List<types.Message> _messages = [];
//   final _user = const types.User(
//     id: '82091008-a484-4a89-ae75-a22bf8d6f3ac',
//   );

//   @override
//   void initState() {
//     super.initState();
//   }

//   void _addMessage(types.Message message) {
//     setState(() {
//       _messages.insert(0, message);
//     });
//   }

//   void _handleSendPressed(types.PartialText message) {
//     final textMessage = types.TextMessage(
//       author: _user,
//       createdAt: DateTime.now().millisecondsSinceEpoch,
//       id: const Uuid().v4(),
//       text: message.text,
//     );

//     _addMessage(textMessage);
//   }

//   @override
//   Widget build(BuildContext context) => Chat(
//         //! THEMING
//         theme: DarkChatTheme(
//           inputElevation: 0,
//           backgroundColor: Colors.transparent,
//           primaryColor: Theme.of(context).colorScheme.primaryFixed,
//           inputTextCursorColor: const Color(darkPurple),
//           inputBackgroundColor: Theme.of(context).colorScheme.tertiary,
//           inputTextStyle: manrope,
//           inputTextColor: Colors.grey,
//         ),
//         //! THE KEYBOARD
//         inputOptions: InputOptions(
//           autofocus: false,
//           usesSafeArea: true,
//           textEditingController: messageController,
//           autocorrect: false,
//         ),
//         showUserAvatars: true,
//         showUserNames: true,
//         messages: _messages, 
//         onSendPressed: _handleSendPressed,
//         user: _user,
//       );
// }
