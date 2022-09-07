import 'package:flutter/material.dart';

class VideoModel{

final String name;
final String url;


const VideoModel({

  required this.name,
  required this.url,


});

}

// Svaki od ovih ima index 

// KAsnije name izbacit jer za ono što meni treba nije potrebno ga imati
const videoModels = [

  VideoModel(
    name: 'Empty',
    url: ''
  ),

  VideoModel(
    name: 'Goal audio',
    url: 'assets/video/goal_video.mp4'
  ),
    VideoModel(
    name: 'Hep reklama',
    url: 'assets/video/hep_reklama.mp4'
  ),




];