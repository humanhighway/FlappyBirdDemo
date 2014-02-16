library FlappyBirdApp;

import 'dart:html' as html;
import 'package:stagexl/stagexl.dart';
import 'flappyBirdAppLib.dart' as lib;
import 'GameLib.dart';

class FlappyBirdApp
{
  Stage stage;
  RenderLoop renderLoop;
  lib.FlappyBirdApp exportRoot;
  double canvasRatio = 640 / 891;

  FlappyBirdApp() {

    html.CanvasElement canvas = html.querySelector("#canvas") as html.CanvasElement;
    // auto resize canvas ratio
    html.window.onResize.listen((html.Event e) => _windowResizeHandler());
    _windowResizeHandler();
    
    stage = new Stage(canvas, width:640, height:891, webGL:false, frameRate:30);
    
    renderLoop = new RenderLoop();
    renderLoop.addStage(stage);
  
    lib.initResources("./")
      ..load().then(_start).catchError(_loadError)
      ..onProgress.listen(_loadProgress);
  }

  void _loadError(e) {
    print("One or more resource failed to load.");
  }

  void _loadProgress(e) {
    // total: lib.resources.resources.length
    // loaded: lib.resources.finishedResources.length
  }

  void _start(result) {
    GameModel model = new GameModel()..gameWidth = stage.sourceWidth 
                                     ..gameHeight = stage.sourceHeight;
    exportRoot = new lib.FlappyBirdApp();
    stage.addChild(exportRoot);
  }
  
  void _windowResizeHandler() {
    html.CanvasElement canvas = html.querySelector("#canvas") as html.CanvasElement;
    double ratio = html.window.innerWidth / html.window.innerHeight;
    if (ratio > canvasRatio) {
      canvas..style.width = '${(canvasRatio * html.window.innerHeight).toInt()}px'
            ..style.height = '${html.window.innerHeight}px';
    } else {
      canvas..style.width = '${(html.window.innerWidth).toInt()}px'
            ..style.height = '${html.window.innerWidth / canvasRatio}px';
    }
  }
  
}
