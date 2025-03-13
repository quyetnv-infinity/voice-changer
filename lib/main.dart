import 'dart:io';

import 'package:ffmpeg_kit_flutter_full_gpl/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/return_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';

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

  Future<String> changeVoiceToMale(String inputPath) async {
    Directory tempDir = await getTemporaryDirectory();
    String outputPath = '${tempDir.path}/male_voice.mp3';

    // Bộ lọc âm thanh để tạo giọng nam
    String command = '-y -i "$inputPath" -af "asetrate=44100*0.8,atempo=1.2" -acodec libmp3lame -qscale:a 2 "$outputPath"';

    await FFmpegKit.execute(command).then((session) async {
      final logs = await session.getLogs();
      logs.forEach((log) {
        print(log.getMessage());
      });
      final returnCode = await session.getReturnCode();

      if (ReturnCode.isSuccess(returnCode)) {
        print("✅ Voice changed successfully! File saved at: $outputPath");
      } else {
        print("❌ Error processing audio: ${await session.getFailStackTrace()}");
      }
    });

    return outputPath;
  }

  Future<String> changeVoiceToFemale(String inputPath) async {
    Directory tempDir = await getTemporaryDirectory();
    String outputPath = '${tempDir.path}/female_voice.mp3';

    // FFmpeg command to create a female voice effect
    String command = '''-y -i "$inputPath" -af "asetrate=44100*1.2,atempo=0.9,highpass=f=300,lowpass=f=3000" -acodec libmp3lame -qscale:a 2 "$outputPath"''';
    // String command = '''-y -i "$inputPath" -af "asetrate=44100*1.15,atempo=0.95,highpass=f=250,lowpass=f=3200" -acodec libmp3lame -qscale:a 2 "$outputPath"''';

    await FFmpegKit.execute(command).then((session) async {
      final logs = await session.getLogs();
      logs.forEach((log) {
        print(log.getMessage());
      });
      final returnCode = await session.getReturnCode();

      if (ReturnCode.isSuccess(returnCode)) {
        print("✅ Female voice created successfully! File saved at: $outputPath");
      } else {
        print("❌ Error processing audio: ${await session.getFailStackTrace()}");
      }
    });

    return outputPath;
  }

  Future<String> changeVoiceToRobot(String inputPath) async {
    Directory tempDir = await getTemporaryDirectory();
    String outputPath = '${tempDir.path}/robot_voice.mp3';

    // Lệnh FFmpeg để tạo giọng robot
    String command = '''-y -i "$inputPath" -af "flanger,chorus=0.7:0.9:50:0.4:0.25:2,aecho=0.8:0.88:6:0.4" -acodec libmp3lame -qscale:a 2 "$outputPath"''';
    // String command = '''-y -i "$inputPath" -af "flanger,atempo=0.9,lowpass=f=1000,aecho=0.8:0.88:6:0.4" -acodec libmp3lame -qscale:a 2 "$outputPath"''';
    // String command = '''-y -i "$inputPath" -af "tremolo=5.0:0.5,atempo=0.9,lowpass=f=1000,aecho=0.8:0.88:6:0.4" -acodec libmp3lame -qscale:a 2 "$outputPath"''';

    await FFmpegKit.execute(command).then((session) async {
      final logs = await session.getLogs();
      logs.forEach((log) {
        print(log.getMessage());
      });
      final returnCode = await session.getReturnCode();

      if (ReturnCode.isSuccess(returnCode)) {
        print("✅ Voice changed successfully! File saved at: $outputPath");
      } else {
        print("❌ Error processing audio: ${await session.getFailStackTrace()}");
      }
    });

    return outputPath;
  }

  Future<String> changeVoiceToBaby(String inputPath) async {
    Directory tempDir = await getTemporaryDirectory();
    String outputPath = '${tempDir.path}/baby_voice.mp3';

    // FFmpeg command to create a baby voice effect
    String command = '''-y -i "$inputPath" -af "asetrate=44100*1.3,atempo=0.8,highpass=f=300,lowpass=f=3000" -acodec libmp3lame -qscale:a 2 "$outputPath"''';

    await FFmpegKit.execute(command).then((session) async {
      final logs = await session.getLogs();
      logs.forEach((log) {
        print(log.getMessage());
      });
      final returnCode = await session.getReturnCode();

      if (ReturnCode.isSuccess(returnCode)) {
        print("✅ Baby voice created successfully! File saved at: $outputPath");
      } else {
        print("❌ Error processing audio: ${await session.getFailStackTrace()}");
      }
    });

    return outputPath;
  }

  Future<String> changeVoiceToMonster(String inputPath) async {
    Directory tempDir = await getTemporaryDirectory();
    String outputPath = '${tempDir.path}/monster_voice.mp3';

    // FFmpeg command to create a deep, scary monster voice
    String command = '''-y -i "$inputPath" -af "asetrate=44100*0.5,atempo=1.5,lowpass=f=500,aecho=0.9:0.8:20:0.6" -acodec libmp3lame -qscale:a 2 "$outputPath"''';

    await FFmpegKit.execute(command).then((session) async {
      final logs = await session.getLogs();
      logs.forEach((log) {
        print(log.getMessage());
      });
      final returnCode = await session.getReturnCode();

      if (ReturnCode.isSuccess(returnCode)) {
        print("✅ Monster voice created successfully! File saved at: $outputPath");
      } else {
        print("❌ Error processing audio: ${await session.getFailStackTrace()}");
      }
    });

    return outputPath;
  }

  Future<String> changeVoiceToDeath(String inputPath) async {
    Directory tempDir = await getTemporaryDirectory();
    String outputPath = '${tempDir.path}/death_voice.mp3';

    // FFmpeg command to create a deep, eerie death voice
    String command = '''-y -i "$inputPath" -af "asetrate=44100*0.6,atempo=1.2,lowpass=f=500,flanger,chorus=0.5:0.9:50:0.4:0.25:2,aecho=0.8:0.9:50:0.5" -acodec libmp3lame -qscale:a 2 "$outputPath"''';

    await FFmpegKit.execute(command).then((session) async {
      final logs = await session.getLogs();
      logs.forEach((log) {
        print(log.getMessage());
      });
      final returnCode = await session.getReturnCode();

      if (ReturnCode.isSuccess(returnCode)) {
        print("✅ Death voice created successfully! File saved at: $outputPath");
      } else {
        print("❌ Error processing audio: ${await session.getFailStackTrace()}");
      }
    });

    return outputPath;
  }

  Future<String> changeVoiceToNervous(String inputPath) async {
    Directory tempDir = await getTemporaryDirectory();
    String outputPath = '${tempDir.path}/nervous_voice.mp3';

    // FFmpeg command to create a nervous, shaky voice
    String command = '''-y -i "$inputPath" -af "asetrate=44100*1.1,atempo=1.3,vibrato=f=8,afftdn=nr=20" -acodec libmp3lame -qscale:a 2 "$outputPath"''';

    await FFmpegKit.execute(command).then((session) async {
      final logs = await session.getLogs();
      logs.forEach((log) {
        print(log.getMessage());
      });
      final returnCode = await session.getReturnCode();

      if (ReturnCode.isSuccess(returnCode)) {
        print("✅ Nervous voice created successfully! File saved at: $outputPath");
      } else {
        print("❌ Error processing audio: ${await session.getFailStackTrace()}");
      }
    });

    return outputPath;
  }

  Future<String> changeVoiceToCave(String inputPath) async {
    Directory tempDir = await getTemporaryDirectory();
    String outputPath = '${tempDir.path}/cave_voice.mp3';

    // Corrected FFmpeg command without aconvolution
    String command = '''-y -i "$inputPath" -af "aecho=0.8:0.88:60:0.4,lowpass=f=500" -acodec libmp3lame -qscale:a 2 "$outputPath"''';
    // String command = '''-y -i "$inputPath" -af "aecho=0.9:0.8:100:0.3,lowpass=f=400" -acodec libmp3lame -qscale:a 2 "$outputPath"''';
    // String command = '''-y -i "$inputPath" -af "aecho=0.7:0.9:30:0.5,lowpass=f=800" -acodec libmp3lame -qscale:a 2 "$outputPath"''';

    await FFmpegKit.execute(command).then((session) async {
      final logs = await session.getLogs();
      logs.forEach((log) {
        print(log.getMessage());
      });
      final returnCode = await session.getReturnCode();

      if (ReturnCode.isSuccess(returnCode)) {
        print("✅ Cave voice created successfully! File saved at: $outputPath");
      } else {
        print("❌ Error processing audio: ${await session.getFailStackTrace()}");
      }
    });

    return outputPath;
  }

  Future<String> changeVoiceToSquirrel(String inputPath) async {
    Directory tempDir = await getTemporaryDirectory();
    String outputPath = '${tempDir.path}/squirrel_voice.mp3';

    // FFmpeg command to create a squirrel voice effect
    String command = '''-y -i "$inputPath" -af "asetrate=44100*1.5,atempo=1.25" -acodec libmp3lame -qscale:a 2 "$outputPath"''';

    await FFmpegKit.execute(command).then((session) async {
      final logs = await session.getLogs();
      logs.forEach((log) {
        print(log.getMessage());
      });
      final returnCode = await session.getReturnCode();

      if (ReturnCode.isSuccess(returnCode)) {
        print("✅ Squirrel voice created successfully! File saved at: $outputPath");
      } else {
        print("❌ Error processing audio: ${await session.getFailStackTrace()}");
      }
    });

    return outputPath;
  }


  void processAndPlayVoice({required Function(String) voiceChangeFunc}) async {
    String assetPath = "assets/audio/hello.mp3";

    // Copy file từ assets vào thư mục tạm
    String tempInputPath = await copyAssetToTemp(assetPath);

    // Chuyển đổi giọng nói
    String tempOutputPath = await voiceChangeFunc(tempInputPath);

    // Phát file âm thanh sau khi chỉnh sửa
    await playAudio(tempOutputPath);
  }

  @override
  Widget build(BuildContext context) {

    List<SoundModel> sounds = [
      SoundModel(name: "Male", voiceChangeFunc: changeVoiceToMale),
      SoundModel(name: "Female", voiceChangeFunc: changeVoiceToFemale),
      SoundModel(name: "Robot", voiceChangeFunc: changeVoiceToRobot),
      SoundModel(name: "Baby", voiceChangeFunc: changeVoiceToBaby),
      SoundModel(name: "Monster", voiceChangeFunc: changeVoiceToMonster),
      SoundModel(name: "Death", voiceChangeFunc: changeVoiceToDeath),
      SoundModel(name: "Cave", voiceChangeFunc: changeVoiceToCave),
      SoundModel(name: "Nervous", voiceChangeFunc: changeVoiceToNervous),
      SoundModel(name: "Squirrel", voiceChangeFunc: changeVoiceToSquirrel),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(onPressed: () async {
              // String path = await copyAssetToTemp("assets/audio/good-morning.mp3");
              String path = await copyAssetToTemp("assets/audio/why-hello-there.mp3");
              playAudio(path);
            }, child: Text("Play audio")),
            Expanded(
              child: ListView.builder(
                itemCount: sounds.length,
                itemBuilder: (ctx, index) {
                  return ElevatedButton(onPressed: () => processAndPlayVoice(voiceChangeFunc: sounds[index].voiceChangeFunc), child: Text(sounds[index].name));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SoundModel {
  final String name;
  final Function(String) voiceChangeFunc;

  SoundModel({required this.name, required this.voiceChangeFunc});
}