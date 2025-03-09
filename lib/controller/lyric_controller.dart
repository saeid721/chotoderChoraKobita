import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../repository/lyric_repository.dart';
import '../model/lyric_model.dart';

class LyricController extends GetxController {
  final LyricRepository _repository = LyricRepository();
  var lyrics = <Lyric>[].obs;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController fullLyricController = TextEditingController();

  @override
  void onInit() {
    fetchLyrics();
    super.onInit();
  }

  void fetchLyrics() async {
    lyrics.value = await _repository.getLyrics();
  }

  void addLyric() async {
    String title = titleController.text.trim();
    String fullLyric = fullLyricController.text.trim();
    if (title.isNotEmpty) {
      Lyric newLyric = Lyric(title: title, fullLyric: fullLyric);
      await _repository.insertLyric(newLyric);
      clearInputs();
      fetchLyrics();
    }
  }

  // Method to update lyric
  void updateLyric(int? lyricId) async {
    if (lyricId != null) {
      String title = titleController.text.trim();
      String fullLyric = fullLyricController.text.trim();
      if (title.isNotEmpty && fullLyric.isNotEmpty) {
        Lyric updatedLyric = Lyric(id: lyricId, title: title, fullLyric: fullLyric);
        await _repository.insertLyric(updatedLyric); // Insert will replace the lyric
        clearInputs();
        fetchLyrics();
        Get.back(); // Go back after updating
      }
    } else {
      // Handle the case where id is null (e.g., show an error message)
      Get.snackbar('Error', 'Lyric ID is missing.');
    }
  }


  void clearInputs() {
    titleController.clear();
    fullLyricController.clear();
  }

  @override
  void dispose() {
    titleController.dispose();
    fullLyricController.dispose();
    super.dispose();
  }
}
