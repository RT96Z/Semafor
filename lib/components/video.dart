import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


import 'package:semafor/components/model_for_video.dart';


final CollectionReference clubData =
    FirebaseFirestore.instance.collection('game');

/// fetch and display video of goal, later can be multi use
class VideoScreen extends StatefulWidget {
  const VideoScreen({Key? key}) : super(key: key);


  _VideoScreenState createState() => _VideoScreenState();
}
int indexPosition=0;
class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController _controller;

    Future<int?> getIndex() async {
    var b = await clubData.doc('Event').collection('Events').doc('Video').get();
    setState(() {
      indexPosition = b['video'];
    });
    return null;
  }

  void initState() {
    super.initState();
    
    _controller = VideoPlayerController.asset(videoModels[indexPosition].url)..initialize().then((_) {
      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed. 

          _controller.play();
        
       
       
      });
  }

  @override
  Widget build(BuildContext context) {
    getIndex();

    return Center(
          child:  VideoPlayer(_controller),
                
              
        );
      
    
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}