import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_flutter/utils/colors.dart';
import 'package:instagram_flutter/utils/global_variables.dart';
import 'package:instagram_flutter/widgets/post_card.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: width > webScreen
          ? null
          : AppBar(
              backgroundColor: width > webScreen
                  ? webBackgroundColor
                  : mobileBackgroundColor,
              centerTitle: true,
              title: SvgPicture.asset(
                'assests/ic_instagram.svg',
                colorFilter:
                    const ColorFilter.mode(primaryColor, BlendMode.srcATop),
                height: 50,
              ),
              /* actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.messenger_outline_outlined),
                ),
              ], */
            ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none || ConnectionState.waiting:
              return const LinearProgressIndicator(
                  color: Color.fromARGB(255, 0, 255, 8));

            default:
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) => Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: width > webScreen ? width * 0.3 : 0,
                    vertical: width > webScreen ? 15 : 0,
                  ),
                  child: PostCard(
                    snap: snapshot.data!.docs[index].data(),
                  ),
                ),
              );
          }
        },
      ),
    );
  }
}
