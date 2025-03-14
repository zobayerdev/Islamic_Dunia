// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'dart:typed_data';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:image_picker/image_picker.dart';
import 'package:islamic_dunia/assets_helper/app_colors.dart';
import 'package:islamic_dunia/assets_helper/app_fonts.dart';
import 'package:islamic_dunia/assets_helper/app_images.dart';
import 'package:islamic_dunia/assets_helper/app_lottie.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Gemini gemini = Gemini.instance;
  List<ChatMessage> messages = [];
  ChatUser currentUser = ChatUser(
    id: "0",
    firstName: "আপনি",
    profileImage: AppImages.muslim_man,
  );
  ChatUser geminiUser = ChatUser(
    id: "1",
    firstName: "ইসলামিক বট",
    profileImage: AppImages.muslim_man,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cDCE4E6.withOpacity(0.9),
      body: SafeArea(
        child: Column(
          children: [
            Text(
              "ইসলামিক বট",
              style: TextFontStyle.textLine12w500Kalpurush.copyWith(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            Expanded(child: _buildUI()),
          ],
        ),
      ),
    );
  }

  Widget _buildUI() {
    return DashChat(
      inputOptions: InputOptions(
        inputTextStyle: TextFontStyle.textLine12w500Kalpurush,
        inputMaxLines: 5,
        trailing: [
          IconButton(
            onPressed: _sendMediaMessage,
            icon: Icon(
              Icons.image,
            ),
          ),
        ],
      ),
      currentUser: currentUser,
      onSend: _sendMessage,
      messages: messages,
    );
  }

  void _sendMessage(ChatMessage chatMessage) {
    setState(() {
      messages = [chatMessage, ...messages];

      // Add loading message after the user sends a message
      ChatMessage loadingMessage = ChatMessage(
        createdAt: DateTime.now(),
        user: geminiUser,
        text: "অনুগ্রহ করে কিচ্ছুক্ষণ অপেক্ষা করুন…",
      );
      messages = [loadingMessage, ...messages];
    });

    try {
      String question = chatMessage.text;
      List<Uint8List>? images;
      if (chatMessage.medias?.isNotEmpty ?? false) {
        images = [File(chatMessage.medias!.first.url).readAsBytesSync()];
      }

      // Buffer for accumulating the response
      StringBuffer responseBuffer = StringBuffer();

      gemini
          .streamGenerateContent(
        question,
        images: images,
      )
          .listen(
        (event) {
          // Extracting text from the response parts
          String response = event.content?.parts
                  ?.whereType<TextPart>()
                  .map((part) => part.text)
                  .join(" ") ??
              "";

          // Append response part to the buffer
          if (response.isNotEmpty) {
            responseBuffer.write(response);
          }
        },
        onDone: () {
          // Once the stream is done, send the final response
          String finalResponse = responseBuffer.toString().trim();

          if (finalResponse.isNotEmpty) {
            // Remove the loading message once the response is ready
            setState(() {
              messages.removeWhere((message) =>
                  message.text == Lottie.asset(AppLottie.lottieRoute));
            });

            // Send the complete message from Gemini
            ChatMessage message = ChatMessage(
              createdAt: DateTime.now(),
              user: geminiUser,
              text: finalResponse,
            );

            setState(() {
              messages = [message, ...messages]; // Add Gemini's response
            });
          }
        },
        onError: (error) {
          print('Error: $error'); // Handle any errors
        },
      );
    } catch (e) {
      print('Error: $e'); // Catch any other errors
    }
  }

  void _sendMediaMessage() async {
    ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      ChatMessage chatMessage = ChatMessage(
        user: currentUser,
        createdAt: DateTime.now(),
        text: "এই ছবিটি আমাকে একটু বুঝিয়ে বলুন",
        medias: [
          ChatMedia(
            url: image.path,
            fileName: "",
            type: MediaType.image,
          ),
        ],
      );
      _sendMessage(chatMessage);
    }
  }
}
