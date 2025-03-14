import 'dart:io';

import 'package:ffmpeg_kit_flutter_full_gpl/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/return_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';

import 'constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FlutterSoundPlayer _player = FlutterSoundPlayer();
  String assetPath = "assets/audio/audio.mp3";
  late String _outputPath;
  bool _loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTemporaryDirectory().then((tempDir) {
      setState(() {
        _outputPath = '${tempDir.path}/changed_voice.mp3';
      });
    });
  }

  Future<void> playAudio(String filePath) async {
    await _player.openPlayer();
    await _player.startPlayer(fromURI: filePath);
  }

  Future<String> copyAssetToTemp(String assetPath) async {
    ByteData data = await rootBundle.load(assetPath);
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = '${tempDir.path}/${assetPath.split('/').last}';
    File file = File(tempPath);
    await file.writeAsBytes(data.buffer.asUint8List(), flush: true);
    return tempPath;
  }

  Future<String> changeVoice({required String command, required String fileName}) async {
    await FFmpegKit.execute(command).then((session) async {
      final logs = await session.getLogs();
      logs.forEach((log) {
        print(log.getMessage());
      });
      final returnCode = await session.getReturnCode();

      if (ReturnCode.isSuccess(returnCode)) {
        print("✅ Voice created successfully! File saved at: $_outputPath");
      } else {
        print("❌ Error processing audio: ${await session.getFailStackTrace()}");
      }
    });

    return _outputPath;
  }

  void processAndPlayVoice(SoundModel soundModel) async {
    _player.stopPlayer();
    setState(() {
      _loading = true;
    });
    final stopwatch = Stopwatch()..start();
    // Copy file từ assets vào thư mục tạm
    String tempInputPath = await copyAssetToTemp(assetPath);
    stopwatch.stop();
    final command = await getSoundCommand(inputPath: tempInputPath, outputPath: _outputPath, soundModel: soundModel);
    // Chuyển đổi giọng nói
    String tempOutputPath = await changeVoice(command: command, fileName: '${soundModel.name.toLowerCase()}.mp3');

    // Phát file âm thanh sau khi chỉnh sửa
    await playAudio(tempOutputPath);
    print('Execution time: ${stopwatch.elapsedMilliseconds} ms');
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    List<SoundModel> sounds = [
      SoundModel(id: "male", name: "Male"),
      SoundModel(id: "female", name: "Female"),
      SoundModel(id: "robot", name: "Robot"),
      SoundModel(id: "baby", name: "Baby"),
      SoundModel(id: "monster", name: "Monster"),
      SoundModel(id: "death", name: "Death"),
      SoundModel(id: "cave", name: "Cave"),
      SoundModel(id: "nervous", name: "Nervous"),
      SoundModel(id: "squirrel", name: "Squirrel"),
      SoundModel(id: "zombie", name: "Zombie"),
      SoundModel(id: "duck", name: "Duck"),
      SoundModel(id: "under_water", name: "Under Water"),
      SoundModel(id: "telephone", name: "Telephone"),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(onPressed: () async {
                  // String path = await copyAssetToTemp("assets/audio/good-morning.mp3");
                  String path = await copyAssetToTemp(assetPath);
                  playAudio(path);
                }, child: Text("Play audio")),
                ElevatedButton(onPressed: () async {
                  // String path = await copyAssetToTemp("assets/audio/good-morning.mp3");
                  _player.pausePlayer();
                }, child: Text("Pause audio")),
                Expanded(
                  child: ListView.builder(
                    itemCount: sounds.length,
                    itemBuilder: (ctx, index) {
                      return ElevatedButton(onPressed: () => processAndPlayVoice(sounds[index]), child: Text(sounds[index].name));
                    },
                  ),
                )
              ],
            ),
          ),
          if (_loading)
          Positioned.fill(
            child: Container(
              color: Colors.black.withValues(alpha: 0.5),
              child: Center(child: CircularProgressIndicator(color: Colors.white,)),
            ),
          )
        ],
      ),
    );
  }
}

class SoundModel {
  final String id;
  final String name;

  SoundModel({required this.id, required this.name});
}