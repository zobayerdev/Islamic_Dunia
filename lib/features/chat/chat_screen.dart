// import 'package:flutter/material.dart';
// import 'package:dash_chat_2/dash_chat_2.dart';
// import 'package:islamic_dunia/assets_helper/app_fonts.dart';
// import 'package:dio/dio.dart'; // Dio for making HTTP requests
// import 'package:image_picker/image_picker.dart';
// import 'package:islamic_dunia/assets_helper/app_colors.dart';
// import 'package:islamic_dunia/assets_helper/app_images.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class AiChatScreen extends StatefulWidget {
//   const AiChatScreen({super.key});

//   @override
//   State<AiChatScreen> createState() => _AiChatScreenState();
// }

// class _AiChatScreenState extends State<AiChatScreen> {
//   bool showIntro = true; // ✅ Track whether the intro is visible

//   // Text controller
//   final ChatUser currentUser = ChatUser(id: '0', firstName: 'User');
//   final ChatUser geminiUser = ChatUser(id: '1', firstName: 'AI Chat');
//   List<ChatMessage> messages = [];

//   final Dio dio = Dio();
//   final ImagePicker _picker = ImagePicker(); // Image Picker instance

//   // Function to send the message and get the response from the API
//   Future<void> onSend(ChatMessage message) async {
//     setState(() {
//       messages.add(message); // Add user message to chat

//       showIntro = false; // ✅ Hide intro when the first message is sent
//     });

//     final response = await generateHaiku(message.text);

//     if (response != null) {
//       setState(() {
//         messages.add(ChatMessage(
//           text: response,
//           user: geminiUser,
//           createdAt: DateTime.now(),
//         ));
//       });
//     }
//   }

//   Future<String?> generateHaiku(String userInput) async {
//     const apiKey = 'AIzaSyB2ZXwzrMUNLOap7S2zQmg52fjFWDwG61E';

//     const url = 'https://aistudio.google.com/completions';

//     try {
//       final response = await dio.post(
//         url,
//         data: {
//           "model": "gemini-v1",
//           "store": true,
//           "messages": [
//             {"role": "user", "content": userInput}
//           ]
//         },
//         options: Options(
//           headers: {
//             'Content-Type': 'application/json',
//             'Authorization': 'Bearer $apiKey',
//           },
//         ),
//       );

//       if (response.statusCode == 200) {
//         final data = response.data;
//         return data['choices'][0]['message']['content'];
//       } else {
//         print('Error: ${response.statusCode}');
//         return 'Failed to generate haiku';
//       }
//     } catch (e) {
//       print('Error: $e');
//       return 'Failed to generate haiku';
//     }
//   }

//   // Function to pick an image from gallery
//   Future<void> pickImage() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       // Add the selected image as a media message
//       setState(() {
//         messages.add(ChatMessage(
//           user: currentUser,
//           createdAt: DateTime.now(),
//           medias: [
//             ChatMedia(
//               url: pickedFile.path,
//               fileName: pickedFile.name,
//               type: MediaType.image,
//             )
//           ], // Assign the picked image path to 'image' field
//         ));
//       });
//     }
//   }

// // Overly dialog box Function---Start--//

//   bool showOverlay1 = true;
//   bool showOverlay2 = false;
//   bool showOverlay3 = false;
//   bool showOverlay4 = false;

//   @override
//   void initState() {
//     super.initState();
//     _checkFirstTime(); // ✅ Check if the overlay should be shown
//   }

//   Future<void> _checkFirstTime() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     bool hasSeenOverlay1 = prefs.getBool("hasSeenOverlay1") ?? false;
//     bool hasSeenOverlay2 = prefs.getBool("hasSeenOverlay2") ?? false;
//     bool hasSeenOverlay3 = prefs.getBool("hasSeenOverlay3") ?? false;
//     bool hasSeenOverlay4 = prefs.getBool("hasSeenOverlay4") ?? false;

//     setState(() {
//       showOverlay1 = !hasSeenOverlay1;
//       showOverlay2 = hasSeenOverlay1 && !hasSeenOverlay2;
//       showOverlay3 = hasSeenOverlay2 && !hasSeenOverlay3;
//       showOverlay4 = hasSeenOverlay3 && !hasSeenOverlay4;
//     });
//   }

//   Future<void> _hideOverlay1AndShowOverlay2() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setBool("hasSeenOverlay1", true);

//     setState(() {
//       showOverlay1 = false;
//       showOverlay2 = true;
//     });
//   }

//   Future<void> _hideOverlay2AndShowOverlay3() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setBool("hasSeenOverlay2", true);

//     setState(() {
//       showOverlay2 = false;
//       showOverlay3 = true;
//     });
//   }

//   Future<void> _hideOverlay3AndShowOverlay4() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setBool("hasSeenOverlay3", true);

//     setState(() {
//       showOverlay3 = false;
//       showOverlay4 = true;
//     });
//   }

//   Future<void> _hideOverlay4() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setBool("hasSeenOverlay4", true);

//     setState(() {
//       showOverlay1 = false;
//       showOverlay2 = false;
//       showOverlay3 = false;
//       showOverlay4 = false;
//     });
//   }
//   //Overly dialog box Function---End--//

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         SafeArea(
//           child: Scaffold(
//             backgroundColor: Colors.black,
//             // appBar: CustomAppBar(
//             //   title: "Chat With Bot",
//             //   leadingIconUnVisible: false,
//             //   profileIcon1: true,
//             //   isCenterd: false,
//             //   actions: [
//             //     Padding(
//             //       padding: EdgeInsets.all(8.sp),
//             //       child: CircleAvatar(
//             //         radius: 20.r,
//             //         backgroundColor: AppColor.c1D1D1D,
//             //         child: IconButton(
//             //           icon: Image.asset(
//             //             AppImages.them_2,
//             //             height: 36.h,
//             //             width: 36.w,
//             //           ),
//             //           onPressed: () {
//             //             // NavigationService.navigateTo(Routes.catProfileScreen);
//             //           },
//             //         ),
//             //       ),
//             //     ),
//             //     UIHelper.horizontalSpace(0.w),
//             //     Padding(
//             //       padding: EdgeInsets.all(8.sp),
//             //       child: CircleAvatar(
//             //         radius: 20.r,
//             //         backgroundColor: AppColor.c1D1D1D,
//             //         child: IconButton(
//             //           icon: Image.asset(
//             //             AppImages.them_icon,
//             //             height: 36.h,
//             //             width: 36.w,
//             //           ),
//             //           onPressed: () {
//             //             // NavigationService.navigateTo(Routes.catProfileScreen);
//             //           },
//             //         ),
//             //       ),
//             //     )
//             //   ],
//             // ),
//             body: Column(
//               children: [
//                 SizedBox(height: 20),
//                 if (showIntro)
//                   SizedBox(
//                     width: 298,
//                     height: 250,
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Container(
//                           width: 122,
//                           height: 122,
//                           padding: const EdgeInsets.all(6),
//                           decoration: ShapeDecoration(
//                             color: AppColors.c1C1C1C,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(122),
//                             ),
//                           ),
//                           child: Center(
//                             child: Container(
//                               width: 70,
//                               height: 70,
//                               clipBehavior: Clip.antiAlias,
//                               decoration: const BoxDecoration(),
//                               child: Image.asset(AppImages.chatIcon_2),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 20,
//                         ),
//                         SizedBox(
//                           width: double.infinity,
//                           height: 75,
//                           child: Text(
//                             'Your AI Companion – Here to Help, Anytime! you can discuss here for your pet health & foods',
//                             textAlign: TextAlign.center,
//                             style: TextFontStyle.textStyle16w800Poppins
//                                 .copyWith(color: AppColors.c919191),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 Expanded(
//                   child: DashChat(
//                     currentUser: currentUser,
//                     onSend: onSend,
//                     messages: messages.reversed.toList(),
//                     inputOptions: InputOptions(
//                       sendButtonBuilder: (sendMessage) => Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Container(
//                             height: 45,
//                             width: 45,
//                             decoration: const BoxDecoration(
//                               color: AppColors.c66FCF1,
//                               shape: BoxShape.circle,
//                             ),
//                             child: IconButton(
//                               icon: Image.asset(
//                                 AppImages.sendIcon,
//                                 color: AppColors.blackColor,
//                                 width: 20,
//                                 height: 20,
//                               ),
//                               onPressed: sendMessage,
//                             ),
//                           ),
//                         ],
//                       ),
//                       inputDecoration: InputDecoration(
//                         fillColor: AppColors.c1C1C1C,
//                         filled: true,
//                         hintText: 'Ask a Question...',
//                         hintStyle: TextFontStyle.textStyle12w400Poppins,
//                         contentPadding: const EdgeInsets.symmetric(
//                             horizontal: 20, vertical: 14),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(67),
//                           borderSide: BorderSide.none,
//                         ),
//                       ),
//                       inputTextStyle: TextFontStyle.textStyle14w400Poppins
//                           .copyWith(color: AppColors.whiteColor),
//                       leading: [
//                         Container(
//                           width: 50,
//                           height: 50,
//                           decoration: ShapeDecoration(
//                             color: AppColors.c1C1C1C,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(80),
//                             ),
//                           ),
//                           child: IconButton(
//                             icon: Image.asset(
//                               AppImages.plusIcon,
//                               height: 20,
//                               width: 20,
//                             ),
//                             onPressed: pickImage,
//                           ),
//                         ),
//                         SizedBox(height: 6),
//                       ],
//                     ),
//                     messageOptions: const MessageOptions(
//                       maxWidth: 248,
//                       textColor: Colors.white,
//                       containerColor: AppColors.c1C1C1C,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         if (showOverlay1)
//           Positioned(
//             top: 15,
//             left: -10,
//             right: 0,
//             bottom: 0,
//             child: GestureDetector(
//               onTap: _hideOverlay1AndShowOverlay2,
//               child: Container(
//                 width: double.infinity,
//                 height: double.infinity,
//                 color: Colors.black.withValues(alpha: (0.6 * 1).toDouble()),
//                 child: Opacity(
//                   opacity: 1.0, // Adjust if you want to fade images as well
//                   child: Stack(
//                     children: [
//                       Positioned(
//                         bottom: 70,
//                         left: 50,
//                         child: GestureDetector(
//                           onTap: _hideOverlay1AndShowOverlay2,
//                           child: Image.asset(
//                             AppImages.notify4,
//                             width: 150,
//                             height: 150,
//                           ),
//                         ),
//                       ),
//                       Positioned(
//                         bottom: 10,
//                         right: 90,
//                         child: GestureDetector(
//                           onTap: _hideOverlay1AndShowOverlay2,
//                           child: Image.asset(
//                             AppImages.askQuestion,
//                             width: 300,
//                             height: 45,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         if (showOverlay2)
//           Positioned(
//             top: 15,
//             left: -10,
//             right: 0,
//             bottom: 0,
//             child: Container(
//               width: double.infinity,
//               height: double.infinity,
//               color: Colors.black.withValues(alpha: (0.6 * 1).toDouble()),
//               child: Opacity(
//                 opacity: 1.0,
//                 child: GestureDetector(
//                   onTap: _hideOverlay2AndShowOverlay3,
//                   child: Stack(
//                     children: [
//                       Positioned(
//                         top: 19,
//                         right: 55,
//                         child: GestureDetector(
//                           onTap:
//                               _hideOverlay2AndShowOverlay3, // Move to Overlay 3
//                           child: Image.asset(
//                             AppImages.conversationIcon,
//                             width: 45,
//                             height: 45,
//                           ),
//                         ),
//                       ),
//                       Positioned(
//                         top: 65,
//                         right: 25,
//                         child: GestureDetector(
//                           onTap:
//                               _hideOverlay2AndShowOverlay3, // Move to Overlay 3
//                           child: Image.asset(
//                             AppImages.notify5,
//                             width: 155,
//                             height: 155,
//                           ),
//                         ),
//                       ),
//                       Positioned(
//                         bottom: 0,
//                         right: 10,
//                         child: GestureDetector(
//                           onTap:
//                               _hideOverlay2AndShowOverlay3, // Move to Overlay 3
//                           child: Image.asset(
//                             AppImages.girl_notify_screen,
//                             width: 450,
//                             height: 450,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         if (showOverlay3)
//           Positioned(
//             top: 15,
//             left: -10,
//             right: 0,
//             bottom: 0,
//             child: GestureDetector(
//               onTap: _hideOverlay3AndShowOverlay4,
//               child: Container(
//                 width: double.infinity,
//                 height: double.infinity,
//                 color: Colors.black.withValues(alpha: (0.6 * 1).toDouble()),
//                 child: Opacity(
//                   opacity: 1.0,
//                   child: Stack(
//                     children: [
//                       Positioned(
//                         bottom: 60,
//                         left: 5,
//                         child: GestureDetector(
//                           onTap:
//                               _hideOverlay3AndShowOverlay4, // Move to Overlay 4
//                           child: Image.asset(
//                             AppImages.notify6,
//                             width: 155,
//                             height: 155,
//                           ),
//                         ),
//                       ),
//                       Positioned(
//                         bottom: 10,
//                         left: 30,
//                         child: GestureDetector(
//                           onTap:
//                               _hideOverlay3AndShowOverlay4, // Move to Overlay 4
//                           child: Image.asset(
//                             AppImages.plusIconBlackWhite,
//                             width: 45,
//                             height: 45,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         if (showOverlay4)
//           Positioned(
//             child: GestureDetector(
//               onTap: _hideOverlay4,
//               child: Container(
//                 width: double.infinity,
//                 height: double.infinity,
//                 color: Colors.black.withValues(alpha: (0.6 * 1).toDouble()),
//                 child: Opacity(
//                   opacity: 1.0,
//                   child: Stack(
//                     children: [
//                       Positioned(
//                         top: 35,
//                         right: 9,
//                         child: GestureDetector(
//                           onTap: _hideOverlay4, // Move to Overlay 3
//                           child: Image.asset(
//                             AppImages.them_3,
//                             width: 45,
//                             height: 45,
//                           ),
//                         ),
//                       ),
//                       Positioned(
//                         top: 60,
//                         right: -5,
//                         child: GestureDetector(
//                           onTap: _hideOverlay4, // Hide all overlays
//                           child: Image.asset(
//                             AppImages.notify7,
//                             width: 155,
//                             height: 155,
//                           ),
//                         ),
//                       ),
//                       Positioned(
//                         bottom: 0,
//                         right: 10,
//                         child: GestureDetector(
//                           onTap: _hideOverlay4, // Move to Overlay 3
//                           child: Image.asset(
//                             AppImages.girl_notify_screen,
//                             width: 450,
//                             height: 450,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';

class AiChattingScreen extends StatefulWidget {
  const AiChattingScreen({super.key});

  @override
  State<AiChattingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<AiChattingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Setting Screen'),
      ),
    );
  }
}
