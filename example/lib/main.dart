import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gallery_3d/gallery_3d.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  var imageUrlList = [
    "https://i0.hdslb.com/bfs/manga-static/42b2143b5694835ae35763bea634cdfc36392801.jpg@300w.jpg",
    "https://i0.hdslb.com/bfs/manga-static/87e22d652eb4c456fe251e15b57bbb25da39925a.jpg@300w.jpg",
    "https://i0.hdslb.com/bfs/manga-static/3f01609c36d4816eb227c95ac31471710fa706e6.jpg@300w.jpg",
    "https://i0.hdslb.com/bfs/manga-static/6b5ab1a7cb883504db182ee46381835e70d6d460.jpg@300w.jpg",
    "https://i0.hdslb.com/bfs/manga-static/5482454680757477d728dae82f80a280a9cc97a2.jpg@300w.jpg",
    // "https://i0.hdslb.com/bfs/manga-static/5482454680757477d728dae82f80a280a9cc97a2.jpg@300w.jpg",
    // "https://i0.hdslb.com/bfs/manga-static/5482454680757477d728dae82f80a280a9cc97a2.jpg@300w.jpg",
    // "https://i0.hdslb.com/bfs/manga-static/5482454680757477d728dae82f80a280a9cc97a2.jpg@300w.jpg",
    // "https://i0.hdslb.com/bfs/manga-static/5482454680757477d728dae82f80a280a9cc97a2.jpg@300w.jpg",
    // "https://i0.hdslb.com/bfs/manga-static/5482454680757477d728dae82f80a280a9cc97a2.jpg@300w.jpg",
    // "https://i0.hdslb.com/bfs/manga-static/5482454680757477d728dae82f80a280a9cc97a2.jpg@300w.jpg",
    // "https://i0.hdslb.com/bfs/manga-static/5482454680757477d728dae82f80a280a9cc97a2.jpg@300w.jpg",
  ];

  int currentIndex = 0;

  Widget buildGallery3D() {
    return Gallery3D(
        autoLoop: false,
        itemCount: 3,
        width: MediaQuery.of(context).size.width,
        height: 300,
        isClip: false,

        // ellipseHeight:s 80,
        itemConfig: GalleryItemConfig(
          width: 220,
          height: 300,
          radius: 10,
          isShowTransformMask: false,
          // shadows: [
          //   BoxShadow(
          //       color: Color(0x90000000), offset: Offset(2, 0), blurRadius: 5)
          // ]
        ),
        currentIndex: currentIndex,
        onItemChanged: (index) {
          setState(() {
            this.currentIndex = index;
          });
        },
        onActivePage: (index) {
          print('onActivePage $index');
        },
        onClickItem: (index) => print("currentIndex:$index"),
        itemBuilder: (context, index) {
          return Image.network(
            imageUrlList[index],
            fit: BoxFit.fill,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                BackgrounBlurView(
                  imageUrl: imageUrlList[currentIndex],
                ),
                Container(
                  padding: EdgeInsets.only(top: 40),
                  child: buildGallery3D(),
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class BackgrounBlurView extends StatelessWidget {
  final String imageUrl;
  BackgrounBlurView({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        height: 200,
        width: MediaQuery.of(context).size.width,
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
      ),
      BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(
            color: Colors.black.withOpacity(0.1),
            height: 200,
            width: MediaQuery.of(context).size.width,
          ))
    ]);
  }
}
