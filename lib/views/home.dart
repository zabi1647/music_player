import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/const/colors.dart';
import 'package:music_player/const/textstyle.dart';
import 'package:music_player/controller/player_controller.dart';
import 'package:music_player/views/player.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(PlayerController());

    return Scaffold(
      backgroundColor: bgdarkcolor,
      appBar: AppBar(
        backgroundColor: bgdarkcolor,
        leading: const Icon(
          Icons.sort_rounded,
          color: whitecolor,
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: whitecolor,
              ))
        ],
        title: Text("Music",
            style: ourStyle(
              size: 18,
              family: bold,
            )),
      ),
      body: FutureBuilder<List<SongModel>>(
        future: controller.audioquary.querySongs(
            ignoreCase: true,
            orderType: OrderType.ASC_OR_SMALLER,
            sortType: null,
            uriType: UriType.EXTERNAL),
        builder: (BuildContext context, snapshot) {
          if (snapshot.data == null) {
            print("first if");
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data!.isEmpty) {
            print("Second");
            return Center(
              child: Text(
                "No Songs ",
                style: ourStyle(),
              ),
            );
          } else {
            print("third");
            return Padding(
              padding: const EdgeInsets.all(6.0),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 4),
                    child: Obx(
                      () => ListTile(
                        tileColor: bgcolor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        title: Text(
                          snapshot.data![index].displayNameWOExt,
                          style: ourStyle(family: bold, size: 15),
                        ),
                        subtitle: Text(
                          "Artist Name",
                          style: ourStyle(family: regular, size: 12),
                        ),
                        leading: QueryArtworkWidget(
                          id: snapshot.data![index].id,
                          type: ArtworkType.AUDIO,
                          nullArtworkWidget: Icon(
                            Icons.music_note,
                            color: whitecolor,
                            size: 32,
                          ),
                        ),
                        trailing: controller.playindex == index &&
                                controller.isplaying.value
                            ? Icon(
                                Icons.play_arrow,
                                color: whitecolor,
                                size: 26,
                              )
                            : null,
                        onTap: () {
                          Get.to(() => Player(
                                data: snapshot.data!,
                              ));
                          controller.playSongs(
                              snapshot.data![index].uri, index);
                        },
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
