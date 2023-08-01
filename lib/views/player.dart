import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/const/colors.dart';
import 'package:music_player/const/textstyle.dart';
import 'package:music_player/controller/player_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Player extends StatelessWidget {
  final List<SongModel> data;
  const Player({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<PlayerController>();
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Obx(
              () => Expanded(
                child: Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: QueryArtworkWidget(
                    id: data[controller.playindex.value].id,
                    type: ArtworkType.AUDIO,
                    artworkHeight: double.infinity,
                    artworkWidth: double.infinity,
                    nullArtworkWidget: Icon(
                      Icons.music_note,
                      color: bgcolor,
                      size: 54,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: whitecolor,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: Obx(
                  () => Column(
                    children: [
                      Text(
                        data[controller.playindex.value].displayNameWOExt,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: ourStyle(
                            color: bgdarkcolor, family: bold, size: 24),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        data[controller.playindex.value].artist.toString(),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: ourStyle(
                            color: bgdarkcolor, family: regular, size: 20),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Obx(
                        () => Row(
                          children: [
                            Text(
                              controller.position.value,
                              style: ourStyle(color: bgcolor),
                            ),
                            Expanded(
                                child: Slider(
                              value: controller.value.value,
                              min: Duration(seconds: 0).inSeconds.toDouble(),
                              max: controller.max.value,
                              onChanged: (newValue) {
                                controller
                                    .changedurationtoseconds(newValue.toInt());
                                newValue = newValue;
                              },
                              thumbColor: slidercolor,
                              inactiveColor: bgcolor,
                              activeColor: slidercolor,
                            )),
                            Text(
                              controller.duration.value,
                              style: ourStyle(color: bgcolor),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                              onPressed: () {
                                controller.playSongs(
                                    data[controller.playindex.value - 1].uri,
                                    controller.playindex.value - 1);
                              },
                              icon: const Icon(
                                Icons.skip_previous_rounded,
                                color: bgdarkcolor,
                                size: 40,
                              )),
                          Obx(
                            () => CircleAvatar(
                              radius: 35,
                              backgroundColor: bgcolor,
                              child: Transform.scale(
                                scale: 2.5,
                                child: IconButton(
                                  onPressed: () {
                                    if (controller.isplaying.value) {
                                      controller.audioplayer.pause();
                                      controller.isplaying(false);
                                    } else {
                                      controller.audioplayer.play();
                                      controller.isplaying(true);
                                    }
                                  },
                                  icon: controller.isplaying.value
                                      ? const Icon(
                                          Icons.pause,
                                          color: whitecolor,
                                        )
                                      : const Icon(
                                          Icons.play_arrow_rounded,
                                          color: whitecolor,
                                        ),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                controller.playSongs(
                                    data[controller.playindex.value + 1].uri,
                                    controller.playindex.value + 1);
                              },
                              icon: const Icon(
                                Icons.skip_next_rounded,
                                size: 40,
                                color: bgdarkcolor,
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
