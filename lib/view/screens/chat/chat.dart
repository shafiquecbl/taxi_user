// ignore_for_file: unused_field, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:taxi_user/common/buttons.dart';
import 'package:taxi_user/common/icons.dart';
import 'package:taxi_user/common/network_image.dart';
import 'package:taxi_user/common/textfield.dart';
import 'package:taxi_user/controller/localization_controller.dart';
import 'package:taxi_user/helper/navigation.dart';
import 'package:taxi_user/helper/timeago.dart';
import 'package:taxi_user/utils/icons.dart';
import 'package:taxi_user/utils/style.dart';
import 'package:taxi_user/view/base/divider.dart';
import 'package:taxi_user/view/base/view_image.dart';

class LiveChat extends StatefulWidget {
  const LiveChat({super.key});

  @override
  State<LiveChat> createState() => _LiveChatState();
}

class _LiveChatState extends State<LiveChat> {
  final TextEditingController messageController = TextEditingController();
  bool _isComposing = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const CustomBackButton(),
          title: const Text('Live Chat'),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                  child: ListView.builder(
                      itemCount: messageList.length,
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      reverse: true,
                      itemBuilder: (context, index) {
                        return _chatBubble(messageList[index],
                            index % 2 == 0 ? true : false, index);
                      })),
              const CustomDivider(),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                        child: CustomTextField(
                      padding: EdgeInsets.zero,
                      hintText: 'Type your message here',
                      controller: messageController,
                      onChanged: (value) {
                        setState(() {
                          _isComposing = value.isNotEmpty;
                        });
                      },
                    )),
                    const SizedBox(width: 15),
                    Center(
                      child: CustomIcon(
                        iconSize: 24,
                        color: !_isComposing
                            ? Theme.of(context).colorScheme.error
                            : null,
                        icon: !_isComposing ? FFIcons.camera : FFIcons.send,
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Widget _chatBubble(Map<String, dynamic> message, bool isMe, int index) {
    final bubbleColor =
        isMe ? Theme.of(context).primaryColor : Theme.of(context).cardColor;
    final bubbleAlign = isMe
        ? LocalizationController.to.isLtr
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start
        : LocalizationController.to.isLtr
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.end;
    final bubbleBorderRadius = isMe
        ? const BorderRadius.only(
            topLeft: Radius.circular(15),
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          )
        : const BorderRadius.only(
            topRight: Radius.circular(15),
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          );

    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0).copyWith(
          left: !isMe ? 0.0 : getPixels(context, 70),
          right: !isMe ? getPixels(context, 70) : 0.0,
        ),
        child: Column(
          crossAxisAlignment: bubbleAlign,
          children: [
            Container(
              decoration: BoxDecoration(
                color: bubbleColor,
                borderRadius: bubbleBorderRadius,
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: LocalizationController.to.isLtr
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  if (message['image'])
                    SizedBox(
                        height: 250,
                        width: 250,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: GestureDetector(
                                onTap: () {
                                  launchScreen(
                                      ViewImage(image: message['message']));
                                },
                                child: Hero(
                                    tag: message['message'],
                                    child: CustomNetworkImage(
                                        url: message['message']))))),
                  if (!message['image'])
                    Text(
                      message['message'],
                      style: TextStyle(color: isMe ? Colors.white : null),
                    ),
                  const SizedBox(height: 5.0),
                  Text(
                    getTime(DateTime.now()),
                    style: TextStyle(
                      color:
                          isMe ? Colors.white70 : Theme.of(context).hintColor,
                      fontSize: 10.0,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5.0),
            // if index is 0 or the previous message is not from the same sender
            if (index == 0 || !isMe)
              Row(
                mainAxisAlignment: bubbleAlign == CrossAxisAlignment.end
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                children: [
                  if (isMe)
                    Text(
                      'Sent',
                      style: TextStyle(
                        color: Theme.of(context).hintColor,
                        fontSize: 10.0,
                      ),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

List<Map<String, dynamic>> messageList = [
  {
    'message': 'Hello',
    'isMe': true,
    'time': DateTime.now(),
    'image': false,
  },
  {
    'message': 'How are you?',
    'isMe': false,
    'time': DateTime.now().add(const Duration(minutes: 5)),
    'image': false,
  },
  {
    'message': 'I\'m good, thanks!',
    'isMe': true,
    'time': DateTime.now().add(const Duration(minutes: 10)),
    'image': false,
  },
  {
    'message': 'https://i.imgur.com/QyB5vKb.jpg',
    'isMe': false,
    'time': DateTime.now().add(const Duration(minutes: 15)),
    'image': true,
  },
  {
    'message': 'LOL that\'s hilarious',
    'isMe': true,
    'time': DateTime.now().add(const Duration(minutes: 20)),
    'image': false,
  },
  {
    'message': 'What are you up to?',
    'isMe': false,
    'time': DateTime.now().add(const Duration(minutes: 25)),
    'image': false,
  },
  {
    'message': 'Just chilling at home',
    'isMe': true,
    'time': DateTime.now().add(const Duration(minutes: 30)),
    'image': false,
  },
  {
    'message': 'Nice, wanna hang out later?',
    'isMe': false,
    'time': DateTime.now().add(const Duration(minutes: 35)),
    'image': false,
  },
  {
    'message': 'Sure, what do you have in mind?',
    'isMe': true,
    'time': DateTime.now().add(const Duration(minutes: 40)),
    'image': false,
  },
  {
    'message': 'How about we go to the park?',
    'isMe': false,
    'time': DateTime.now().add(const Duration(minutes: 45)),
    'image': false,
  },
  {
    'message': 'Sounds good to me',
    'isMe': true,
    'time': DateTime.now().add(const Duration(minutes: 50)),
    'image': false,
  },
  {
    'message':
        'By the way, did you see the latest episode of your favorite show?',
    'isMe': false,
    'time': DateTime.now().add(const Duration(minutes: 55)),
    'image': false,
  },
  {
    'message': 'Not yet, I\'m planning to watch it tonight',
    'isMe': true,
    'time': DateTime.now().add(const Duration(minutes: 60)),
    'image': false,
  },
  {
    'message': 'It\'s so good, you\'re gonna love it!',
    'isMe': false,
    'time': DateTime.now().add(const Duration(minutes: 65)),
    'image': false,
  },
  {
    'message': 'Can\'t wait!',
    'isMe': true,
    'time': DateTime.now().add(const Duration(minutes: 70)),
    'image': false,
  },
  {
    'message': 'https://i.imgur.com/6iGm6RE.jpg',
    'isMe': false,
    'time': DateTime.now().add(const Duration(minutes: 75)),
    'image': true,
  },
  {
    'message': 'Wow, that is really cute!',
    'isMe': true,
    'time': DateTime.now().add(const Duration(minutes: 80)),
    'image': false,
  },
  {
    'message': 'Yeah, I thought you\'d like it!',
    'isMe': false,
    'time': DateTime.now().add(const Duration(minutes: 85)),
    'image': false,
  },
  {
    'message': 'By the way, did you finish that project we were working on?',
    'isMe': false,
    'time': DateTime.now().add(const Duration(minutes: 90)),
    'image': false,
  },
  {
    'message': 'Not yet, I still have a bit more work to do on it.',
    'isMe': true,
    'time': DateTime.now().add(const Duration(minutes: 95)),
    'image': false,
  },
  {
    'message': 'Alright, just let me know if you need any help!',
    'isMe': false,
    'time': DateTime.now().add(const Duration(minutes: 100)),
    'image': false,
  },
  {
    'message': 'Thanks, I appreciate it!',
    'isMe': true,
    'time': DateTime.now().add(const Duration(minutes: 105)),
    'image': false,
  },
  {
    'message': 'No problem!',
    'isMe': false,
    'time': DateTime.now().add(const Duration(minutes: 110)),
    'image': false,
  },
  {
    'message': 'Hey, I have to go now. Talk to you later!',
    'isMe': true,
    'time': DateTime.now().add(const Duration(minutes: 115)),
    'image': false,
  },
].reversed.toList();
