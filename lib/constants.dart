import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:voice_changer_flutter/main.dart';

Future<String> getSoundCommand({required String inputPath, required String outputPath, required SoundModel soundModel}) async {
  String command = "";
  switch (soundModel.id) {
    case "male":
      command = '-y -i "$inputPath" -af "asetrate=44100*0.8,atempo=1.2" -acodec libmp3lame -qscale:a 2 "$outputPath"';
      break;
    case "female":
      command = '''-y -i "$inputPath" -af "asetrate=44100*1.2,atempo=0.9,highpass=f=300,lowpass=f=3000" -acodec libmp3lame -qscale:a 2 "$outputPath"''';
      break;
    case "robot":
      command = '''-y -i "$inputPath" -af "flanger,chorus=0.7:0.9:50:0.4:0.25:2,vibrato=f=8,aecho=0.8:0.88:6:0.4" -acodec libmp3lame -qscale:a 2 "$outputPath"''';
      break;
    case "baby":
      command = '''-y -i "$inputPath" -af "asetrate=44100*1.3,atempo=0.8,highpass=f=300,lowpass=f=3000" -acodec libmp3lame -qscale:a 2 "$outputPath"''';
      break;
    case "monster":
      command = '''-y -i "$inputPath" -af "asetrate=44100*0.5,atempo=1.5,lowpass=f=500,aecho=0.9:0.8:20:0.6" -acodec libmp3lame -qscale:a 2 "$outputPath"''';
      // command = '-i "$inputPath" -af "aresample=44100,asetrate=44100*0.7,aresample=44100,atempo=1.1,lowpass=f=1200,highpass=f=200,equalizer=f=300:width=200:g=10,areverse,aecho=0.8:0.1:20:0.4,areverse" -c:a libmp3lame -b:a 192k -y "$outputPath"';
      // String command = '-i "$inputPath" -af "aresample=44100,asetrate=44100*0.6,aresample=44100,atempo=1.3,lowpass=f=1000,highpass=f=250,equalizer=f=400:width=200:g=12,vibrato=f=4:d=0.2,areverse,aecho=0.9:0.2:25:0.5,areverse" -c:a libmp3lame -b:a 192k -y "$outputPath"';
      break;
    case "death":
      // command = '-i "$inputPath" -af "aresample=44100,asetrate=44100*0.45,aresample=44100,atempo=1.5,lowpass=f=800,highpass=f=300,equalizer=f=350:width=100:g=18,equalizer=f=1800:width=100:g=-8,areverse,aecho=0.9:0.1:70:0.4,areverse,vibrato=f=3:d=0.1" -c:a libmp3lame -b:a 192k -y "$outputPath"';
      command = '''-y -i "$inputPath" -af "asetrate=44100*0.6,atempo=1.2,lowpass=f=500,flanger,chorus=0.5:0.9:50:0.4:0.25:2,aecho=0.8:0.9:50:0.5" -acodec libmp3lame -qscale:a 2 "$outputPath"''';
      break;
    case "nervous":
      command = '-i "$inputPath" -af "vibrato=f=8:d=0.5,aecho=0.8:0.6:40:0.5,tremolo=f=6:d=0.7,highpass=f=1000,lowpass=f=8000,volume=1.2" -c:a libmp3lame -y "$outputPath"';
      // command = '''-y -i "$inputPath" -af "asetrate=44100*1.1,atempo=1.3,vibrato=f=8,afftdn=nr=20" -acodec libmp3lame -qscale:a 2 "$outputPath"''';
      break;
    case "cave":
      command = '''-y -i "$inputPath" -af "aecho=0.8:0.88:60:0.4,lowpass=f=500,volume=2.0" -acodec libmp3lame -qscale:a 2 "$outputPath"''';
      break;
    case "squirrel":
      command = '''-y -i "$inputPath" -af "asetrate=44100*1.5,atempo=1.25" -acodec libmp3lame -qscale:a 2 "$outputPath"''';
      break;
    case "zombie":
      command = '''-y -i "$inputPath" -filter_complex "asetrate=22050, atempo=0.8, afftdn=nr=20, chorus=0.7:0.9:55:0.4:0.25:2, vibrato=f=4, flanger, apulsator=mode=sine:hz=0.5" -acodec libmp3lame -qscale:a 2 "$outputPath"''';
      break;
    case "duck":
      command = '-i "$inputPath" -af "aresample=48000,asetrate=48000*0.4,aresample=48000,atempo=2.0,highpass=f=800,lowpass=f=4000,equalizer=f=2000:width=400:g=15" -c:a libmp3lame -b:a 192k -y "$outputPath"';
      break;
    case "under_water":
      command = '''-y -i "$inputPath" -af "asetrate=44100*0.7, atempo=1.2, lowpass=f=400, highpass=f=60, aecho=0.8:0.88:6:0.4, afftdn=nr=50" -acodec libmp3lame -qscale:a 2 "$outputPath"''';
      break;
    case "telephone":
      command = '''-y -i "$inputPath" -af "highpass=f=300, lowpass=f=3400, volume=1.5, atempo=0.9, acrusher=8:4:12:0:log, afftdn=nr=15" -acodec libmp3lame -qscale:a 2 "$outputPath"''';
      break;
  }
  return command;
}