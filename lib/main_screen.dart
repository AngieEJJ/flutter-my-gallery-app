import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final ImagePicker _picker = ImagePicker(); //객체선언
  List<XFile>?
      images; // ImagePicker로 여러 장의 사진을 가져와서 XFile이라는 형태로 리스트에 담긴다. (처음엔 사진이 없는 상태니까 ? 허용)

  @override
  void initState() {
    super.initState();
    loadImages(); // 앱이 실행될 때 사진 선택이 로드될 수 있도록
  }

  Future<void> loadImages() async {
    images = await _picker
        .pickMultiImage(); //pickMultiImage를 마치고 나서 images에 들어갈 수 있도록 await.
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('안드로이드 픽셀 이미지 앨범'),
        ),
        body: images == null
            ? Center(
                child:Text('이미지가 없습니다'),
              )
            : FutureBuilder(
                future: images![0].readAsBytes(), // 데이터를 읽는 함수
                builder: (context, snapshot) {
                  final data = snapshot.data;
                  if (data == null ||
                      snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return Image.memory(
                    data, // 매개변수 (이미지 데이터를 나타내는 바이트 배열 -> 반드시 Unit8List 혹은 List<int>)
                    width: double.infinity
                  );
                }));
  }
}
