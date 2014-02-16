library FlappyBirdAppLib;

/* WARNING: code generated using the Dart Toolkit for Adobe Flash Professional - do not edit */

import 'dart:html' as html;
import 'package:stagexl/stagexl.dart';
import 'GameLib.dart';

/* ASSETS PRELOADING */

ResourceManager resources;

ResourceManager initResources([String basePath = ""]) {
  resources = new ResourceManager()
  ..addTextureAtlas("_atlas_0", "${basePath}images/_atlas_0.json", "json")
  ..addBitmapData("BG_day", "${basePath}images/BG_day.png")
  ..addBitmapData("ground", "${basePath}images/ground.png")
  ..addSound("Tap", "${basePath}sound/Tap.wav")
  ..addSound("Point", "${basePath}sound/Point.wav")
  ..addSound("SoundCrash", "${basePath}sound/Sound_crash.wav");
  return resources;
}

/* STAGE CONTENT */

class FlappyBirdApp extends Sprite {
  
  BlogLink blogLink;
  Bird bird;
  TapIntro tapIntro;
  BG_day bg;
  RepeatGround ground;
  CountView countView;
  Sprite pipesContainer;
  Sprite tap;

  BirdController birdController;
  LevelController levelController;
  
  static const String _blogURL = "http://humanhighway.logdown.com";

  FlappyBirdApp() {

    bg = new BG_day();
    addChild(bg);
    
    tapIntro = new TapIntro()
              ..setTransform(324,449.5,1,1,0,0,0,320,445.5)
              ..mouseEnabled = false
              ..mouseChildren = false;
    addChild(tapIntro);

    pipesContainer = new Sprite();
    addChild(pipesContainer);

    bird = new Bird()
           ..setTransform(212,515,1,1,0,0,0,38,26.5);
    addChild(bird);
    
    ground = new RepeatGround()
             ..x = 0 
             ..y = 891 - 50;
    addChild(ground);
    
    countView = new CountView()
                ..count = 0
                ..x = 640 * .5 
                ..y = 209;
    addChild(countView);

    tap = new Sprite();
    tap.graphics..beginPath()
                ..rect(0, 0, 640, 891)
                ..closePath()
                ..fillColor(0x00000000);
    addChild(tap);
    
    blogLink = new BlogLink()
               ..setTransform(610,25,1,1,0,0,0,50,25);
    addChild(blogLink);
    
    if (Stage.isMobile) {
      Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
      tap.onTouchBegin.listen(gameTapHandler);
      blogLink.onTouchBegin.listen(linkTapHabdler);
    } else {
      tap.onMouseDown.listen(gameTapHandler);
      blogLink.onMouseDown.listen(linkTapHabdler);
    }
  }
  
  void gameTapHandler(e) {
    
    GameModel model = new GameModel();
    
    switch(model.status) {
      case GameModel.BEGIN:

        Tween tween = new Tween(tapIntro, .7, TransitionFunction.easeInSine)
                      ..animate.alpha.to(0)
                      ..delay = .1
                      ..onComplete = () => tapIntro.removeFromParent();
        
        Tween tween2 = new Tween(blogLink, .7, TransitionFunction.easeInSine)
                      ..animate.alpha.to(0)
                      ..delay = .1
                      ..onComplete = () => blogLink.removeFromParent();
        
        stage.juggler..add(tween)
                     ..add(tween2);
        
        model.status = GameModel.PLAYING;
        
        if (birdController == null) {
          birdController = new BirdController(bird);
        }
        birdController.fly();
        
        if (levelController == null) {
          levelController = new LevelController(this);
        }
        levelController.start();
        break;
      case GameModel.PLAYING:
        birdController.fly();
        break;
      case GameModel.WAIT_TO_BACK_BEGIN:
        if (model.isBirdLanding) {
          tapIntro.alpha = 1;
          blogLink.alpha = 1;
          stage..addChild(tapIntro)
               ..addChild(blogLink);
          levelController.reset();
          birdController.reset();
          model.reset();
        }
        break;
    }
  }
  
  void linkTapHabdler(e) {
    html.window.open(_blogURL, "_blank");
  }
}

/* LIBRARY */

class BG_day extends Bitmap {
  static BitmapData bmp;
  BG_day():super(bmp) {
    if (bitmapData == null) bitmapData = bmp = resources.getBitmapData("BG_day");
  }
}

class Dart extends Bitmap {
  static BitmapData bmp;
  Dart():super(bmp) {
    if (bitmapData == null) bitmapData = bmp = resources.getTextureAtlas("_atlas_0").getBitmapData("dart");
  }
}

class Flappy extends Bitmap {
  static BitmapData bmp;
  Flappy():super(bmp) {
    if (bitmapData == null) bitmapData = bmp = resources.getTextureAtlas("_atlas_0").getBitmapData("Flappy");
  }
}

class Flappy2 extends Bitmap {
  static BitmapData bmp;
  Flappy2():super(bmp) {
    if (bitmapData == null) bitmapData = bmp = resources.getTextureAtlas("_atlas_0").getBitmapData("Flappy2");
  }
}

class Flappy3 extends Bitmap {
  static BitmapData bmp;
  Flappy3():super(bmp) {
    if (bitmapData == null) bitmapData = bmp = resources.getTextureAtlas("_atlas_0").getBitmapData("Flappy3");
  }
}

class Flappy_bw extends Bitmap {
  static BitmapData bmp;
  Flappy_bw():super(bmp) {
    if (bitmapData == null) bitmapData = bmp = resources.getTextureAtlas("_atlas_0").getBitmapData("Flappy_bw");
  }
}

class Flappy_icon extends Bitmap {
  static BitmapData bmp;
  Flappy_icon():super(bmp) {
    if (bitmapData == null) bitmapData = bmp = resources.getTextureAtlas("_atlas_0").getBitmapData("Flappy_icon");
  }
}

class GameOver extends Bitmap {
  static BitmapData bmp;
  GameOver():super(bmp) {
    if (bitmapData == null) bitmapData = bmp = resources.getTextureAtlas("_atlas_0").getBitmapData("GameOver");
  }
}

class IntroScreen_arrow extends Bitmap {
  static BitmapData bmp;
  IntroScreen_arrow():super(bmp) {
    if (bitmapData == null) bitmapData = bmp = resources.getTextureAtlas("_atlas_0").getBitmapData("IntroScreen_arrow");
  }
}

class IntroScreen_getready extends Bitmap {
  static BitmapData bmp;
  IntroScreen_getready():super(bmp) {
    if (bitmapData == null) bitmapData = bmp = resources.getTextureAtlas("_atlas_0").getBitmapData("IntroScreen_getready");
  }
}

class IntroScreen_hand extends Bitmap {
  static BitmapData bmp;
  IntroScreen_hand():super(bmp) {
    if (bitmapData == null) bitmapData = bmp = resources.getTextureAtlas("_atlas_0").getBitmapData("IntroScreen_hand");
  }
}

class IntroScreen_tap extends Bitmap {
  static BitmapData bmp;
  IntroScreen_tap():super(bmp) {
    if (bitmapData == null) bitmapData = bmp = resources.getTextureAtlas("_atlas_0").getBitmapData("IntroScreen_tap");
  }
}

class IntroScreen_tap_right extends Bitmap {
  static BitmapData bmp;
  IntroScreen_tap_right():super(bmp) {
    if (bitmapData == null) bitmapData = bmp = resources.getTextureAtlas("_atlas_0").getBitmapData("IntroScreen_tap_right");
  }
}

class Num_0 extends Bitmap {
  static BitmapData bmp;
  Num_0():super(bmp) {
    if (bitmapData == null) bitmapData = bmp = resources.getTextureAtlas("_atlas_0").getBitmapData("num_0");
  }
}

class Num_1 extends Bitmap {
  static BitmapData bmp;
  Num_1():super(bmp) {
    if (bitmapData == null) bitmapData = bmp = resources.getTextureAtlas("_atlas_0").getBitmapData("num_1");
  }
}

class Num_2 extends Bitmap {
  static BitmapData bmp;
  Num_2():super(bmp) {
    if (bitmapData == null) bitmapData = bmp = resources.getTextureAtlas("_atlas_0").getBitmapData("num_2");
  }
}

class Num_3 extends Bitmap {
  static BitmapData bmp;
  Num_3():super(bmp) {
    if (bitmapData == null) bitmapData = bmp = resources.getTextureAtlas("_atlas_0").getBitmapData("num_3");
  }
}

class Num_4 extends Bitmap {
  static BitmapData bmp;
  Num_4():super(bmp) {
    if (bitmapData == null) bitmapData = bmp = resources.getTextureAtlas("_atlas_0").getBitmapData("num_4");
  }
}

class Num_5 extends Bitmap {
  static BitmapData bmp;
  Num_5():super(bmp) {
    if (bitmapData == null) bitmapData = bmp = resources.getTextureAtlas("_atlas_0").getBitmapData("num_5");
  }
}

class Num_6 extends Bitmap {
  static BitmapData bmp;
  Num_6():super(bmp) {
    if (bitmapData == null) bitmapData = bmp = resources.getTextureAtlas("_atlas_0").getBitmapData("num_6");
  }
}

class Num_7 extends Bitmap {
  static BitmapData bmp;
  Num_7():super(bmp) {
    if (bitmapData == null) bitmapData = bmp = resources.getTextureAtlas("_atlas_0").getBitmapData("num_7");
  }
}

class Num_8 extends Bitmap {
  static BitmapData bmp;
  Num_8():super(bmp) {
    if (bitmapData == null) bitmapData = bmp = resources.getTextureAtlas("_atlas_0").getBitmapData("num_8");
  }
}

class Num_9 extends Bitmap {
  static BitmapData bmp;
  Num_9():super(bmp) {
    if (bitmapData == null) bitmapData = bmp = resources.getTextureAtlas("_atlas_0").getBitmapData("num_9");
  }
}

class Pipe_section extends Bitmap {
  static BitmapData bmp;
  Pipe_section():super(bmp) {
    if (bitmapData == null) bitmapData = bmp = resources.getTextureAtlas("_atlas_0").getBitmapData("pipe_section");
  }
}

class Pipe_top extends Bitmap {
  static BitmapData bmp;
  Pipe_top():super(bmp) {
    if (bitmapData == null) bitmapData = bmp = resources.getTextureAtlas("_atlas_0").getBitmapData("pipe_top");
  }
}

class Stagexl extends Bitmap {
  static BitmapData bmp;
  Stagexl():super(bmp) {
    if (bitmapData == null) bitmapData = bmp = resources.getTextureAtlas("_atlas_0").getBitmapData("stagexl");
  }
}

class TapIntro extends Sprite {
  Stagexl instance;
  Dart instance_1;
  IntroScreen_getready instance_2;
  Flappy_bw instance_3;
  IntroScreen_hand instance_4;
  IntroScreen_arrow instance_5;
  IntroScreen_tap instance_6;
  IntroScreen_tap_right instance_7;
  Shape shape;

  TapIntro() {
    // Layer 1
    instance = new Stagexl()
    ..setTransform(103,2);

    instance_1 = new Dart()
    ..setTransform(0,4);

    instance_2 = new IntroScreen_getready()
    ..setTransform(107,313.5);

    instance_3 = new Flappy_bw()
    ..setTransform(271,466.5);

    instance_4 = new IntroScreen_hand()
    ..setTransform(283,576.5);

    instance_5 = new IntroScreen_arrow()
    ..setTransform(291.5,535.5);

    instance_6 = new IntroScreen_tap()
    ..setTransform(187,557);

    instance_7 = new IntroScreen_tap_right()
    ..setTransform(331,557);

    shape = _draw(87,33.5)
    .f(0xFFFF0000).s().p("AgxCVIAAhkIhkAAIAAhiIBkAAIAAhkIBiAAIAABkIBkAAIAABiIhkAAIAABkg").shape;

    addChild(shape);
    addChild(instance_7);
    addChild(instance_6);
    addChild(instance_5);
    addChild(instance_4);
    addChild(instance_3);
    addChild(instance_2);
    addChild(instance_1);
    addChild(instance);
  }
}

class BlogLink extends Sprite {
  TextField text;
  Shape shape;

  BlogLink() {
    // Layer 1
    text = new TextField("Luc", 
      new TextFormat("Helvetica", 30, 0xFFFFFF, bold:true, leading:2, leftMargin:2))
    ..name = "text"
    ..setTransform(11,24)
    ..width = 60
    ..height = 34
    ..multiline = true
    ..wordWrap = true;

    shape = _draw(40,40)
    .f(0xFF000000).s().p("AmPGQIAAsfIMfAAIAAMfg").shape;

    addChild(shape);
    addChild(text);
  }
}

class Bird extends MovieClip {
  Flappy instance;
  Flappy2 instance_1;
  Flappy3 instance_2;
  Shape detectShape;

  Bird([String mode, int startPosition, bool loop])
      : super(mode, startPosition, loop, {}) {
    // Layer 1
    instance = new Flappy();

    instance_1 = new Flappy2();

    instance_2 = new Flappy3();

    timeline.addTween(_tween({}).to({"state":[{"t":instance}]}).to({"state":[{"t":instance_1}]},6).to({"state":[{"t":instance_2}]},6).wait(6));

    detectShape = new Shape();
    detectShape.graphics.beginPath();
    detectShape.graphics.circle(38, 27, 20);
    detectShape.graphics.closePath();
    detectShape.graphics.fillColor(0x00000000);
    addChild(detectShape);

  }
}



/* SHORTCUTS */

const _tween = TimelineTween.get;
const _ease = TransitionFunction.custom;
const _draw = _ShapeFactory.create;

class _ShapeFactory {
  Shape _shape;
  Graphics _graphics;
  Function _endFill;
  Function _endStroke;
  num _strokeWidth = 1;
  String _strokeJoints = "miter";
  String _strokeCaps = "butt";
  
  static _ShapeFactory create(num x, num y) {
    return new _ShapeFactory(x, y);
  }
  
  Shape get shape {
    ef(); es();
    return _shape;
  }
  Graphics get graphics {
    ef(); es();
    return _graphics;
  }
  
  _ShapeFactory(num x, num y) {
    _shape = new Shape();
    _graphics = _shape.graphics;
    _shape.x = x.toDouble();
    _shape.y = y.toDouble();
  }
  
  _ShapeFactory beginLinearGradientFill(List<int> colors, List<num> stops, num x0, num y0, num x1, num y1) {
    return lf(colors, stops, x0, y0, x1, y1);
  }
  _ShapeFactory beginRadialGradientFill(List<int> colors, List<num> stops, num x0, num y0, num r0, num x1, num y1, num r1) {
    return rf(colors, stops, x0, y0, r0, x1, y1, r1);
  }
  _ShapeFactory beginBitmapFill(Bitmap image, [String repeat, Matrix mat]) {
    return bf(image, repeat, mat);
  }
  _ShapeFactory beginFill([int color]) {
    return f(color);
  }
  _ShapeFactory endFill() {
    return ef();
  }
  _ShapeFactory beginStroke([int color]) {
    return s(color);
  }
  _ShapeFactory beginLinearGradientStroke(List<int> colors, List<num> stops, num x0, num y0, num x1, num y1) {
    return ls(colors, stops, x0, y0, x1, y1);
  }
  _ShapeFactory beginRadialGradientStroke(List<int> colors, List<num> stops, num x0, num y0, num r0, num x1, num y1, num r1) {
    return rs(colors, stops, x0, y0, r0, x1, y1, r1);
  }
  _ShapeFactory setStrokeStyle(num thickness, [caps, joints, num miterLimit=10, bool ignoreScale=false]) {
    return ss(thickness, caps, joints, miterLimit, ignoreScale);
  }
  _ShapeFactory closePath() {
    return cp();
  }
  
  _ShapeFactory moveTo(num x, num y) {
    _graphics.moveTo(x, y);
    return this;
  }
  _ShapeFactory lineTo(num x, num y) {
    _graphics.lineTo(x, y);
    return this;
  }
  _ShapeFactory curveTo(num cx, num cy, num x, num y) {
    _graphics.quadraticCurveTo(cx, cy, x, y);
    return this;
  }
  _ShapeFactory drawCircle(num x, num y, num radius) {
    return dc(x, y, radius);
  }
  _ShapeFactory drawEllipse(num x, num y, num width, num height) {
    return de(x, y, width, height);
  }
  _ShapeFactory drawRect(num x, num y, num width, num height) {
    return dr(x, y, width, height);
  }
  _ShapeFactory drawRectRounded(num x, num y, num width, num height, num radius) {
    return rr(x, y, width, height, radius);
  }
  _ShapeFactory drawPolyStar (num x, num y, num radius, num sides, num pointSize, num angle) {
    return dp(x, y, radius, sides, pointSize, angle);
  }
  
  // fills
  _ShapeFactory lf(List<int> colors, List<num> stops, num x0, num y0, num x1, num y1) {
    ef();
    var gradient = new GraphicsGradient.linear(x0, y0, x1, y1);
    int n = colors.length;
    for(int i = 0; i<n; i++) {
      gradient.addColorStop(stops[i], colors[i]);
    }
    _endFill = () {
      _graphics.fillGradient(gradient);
    };
    return this;
  }
  _ShapeFactory rf(List<int> colors, List<num> stops, num x0, num y0, num r0, num x1, num y1, num r1) {
    ef();
    var gradient = new GraphicsGradient.radial(x0, y0, r0, x1, y1, r1);
    int n = colors.length;
    for(int i = 0; i<n; i++) {
      gradient.addColorStop(stops[i], colors[i]);
    }
    _endFill = () {
      _graphics.fillGradient(gradient);
    };
    return this;
  }
  _ShapeFactory bf(Bitmap image, [String repeat, Matrix mat]) {
    var bmp = image.bitmapData;
    GraphicsPattern pattern = null;
    if (mat != null) mat.translate(-_shape.x, -_shape.y);
    else mat = new Matrix(1, 0, 0, 1, -_shape.x, -_shape.y);
    switch (repeat) {
      case "repeat-x": pattern = new GraphicsPattern.repeatX(bmp, mat); break;
      case "repeat-y": pattern = new GraphicsPattern.repeatY(bmp, mat); break;
      case "no-repeat": pattern = new GraphicsPattern.noRepeat(bmp, mat); break;
      default: pattern = new GraphicsPattern.repeat(bmp, mat); break;
    }
    _endFill = () {
      _graphics.fillPattern(pattern);
    };
    return this;
  }
  _ShapeFactory f([int color]) {
    if (color == null) color = 0;
    ef();
    _endFill = () {
      _graphics.fillColor(color);
    };
    return this;
  }
  _ShapeFactory ef() {
    if (_endFill != null) {
      _endFill();
      _endFill = null;
    }
    return this;
  }
  
  // stroke
  _ShapeFactory s([int color]) {
    es();
    if (color == null) color = 0;
    _endStroke = () {
      _graphics.strokeColor(color, _strokeWidth, _strokeJoints, _strokeCaps);
    };
    _graphics.beginPath();
    return this;
  }
  _ShapeFactory ls(List<int> colors, List<num> stops, num x0, num y0, num x1, num y1) {
    es();
    var gradient = new GraphicsGradient.linear(x0, y0, x1, y1);
    int n = colors.length;
    for(int i = 0; i<n; i++) {
      gradient.addColorStop(stops[i], colors[i]);
    }
    _endStroke = () {
      _graphics.strokeGradient(gradient, _strokeWidth, _strokeJoints, _strokeCaps);
    };
    return this;
  }
  _ShapeFactory rs(List<int> colors, List<num> stops, num x0, num y0, num r0, num x1, num y1, num r1) {
    es();
    var gradient = new GraphicsGradient.radial(x0, y0, r0, x1, y1, r1);
    int n = colors.length;
    for(int i = 0; i<n; i++) {
      gradient.addColorStop(stops[i], colors[i]);
    }
    _endStroke = () {
      _graphics.strokeGradient(gradient, _strokeWidth, _strokeJoints, _strokeCaps);
    };
    return this;
  }
  _ShapeFactory es() {
    if (_endStroke != null) {
      _endStroke();
      _endStroke = null;
    }
    return this;
  }
  _ShapeFactory ss(num thickness, [caps, joints, num miterLimit=10, bool ignoreScale=false]) {
    _strokeWidth = thickness;
    if (caps != null) {
      switch(caps) {
        case 0: _strokeCaps = "butt"; break;
        case 1: _strokeCaps = "round"; break;
        case 2: _strokeCaps = "square"; break;
        default: _strokeCaps = caps.toString(); break;
      }
    }
    else _strokeCaps = "butt";
    if (joints != null) {
      switch(joints) {
        case 0: _strokeJoints = "miter"; break;
        case 1: _strokeJoints = "round"; break;
        case 2: _strokeJoints = "bevel"; break;
        default: _strokeJoints = joints.toString(); break;
      }
    }
    else _strokeJoints = "miter";
    return this;
  }
  
  _ShapeFactory cp() {
    _graphics.closePath();
    return this;
  }
  _ShapeFactory mt(num x, num y) {
    _graphics.moveTo(x, y);
    return this;
  }
  _ShapeFactory lt(num x, num y) {
    _graphics.lineTo(x, y);
    return this;
  }
  _ShapeFactory c(num cx, num cy, num x, num y) {
    _graphics.quadraticCurveTo(cx, cy, x, y);
    return this;
  }
  _ShapeFactory dc(num x, num y, num radius) {
    _graphics.circle(x, y, radius);
    return this;
  }
  _ShapeFactory de(num x, num y, num width, num height) {
    _graphics.ellipse(x, y, width, height);
    return this;
  }
  _ShapeFactory dr(num x, num y, num width, num height) {
    _graphics.rect(x, y, width, height);
    return this;
  }
  _ShapeFactory rr(num x, num y, num width, num height, num radius) {
    _graphics.rectRound(x, y, width, height, radius, radius);
    return this;
  }
  _ShapeFactory dp(num x, num y, num radius, num sides, num pointSize, num angle) {
    // TODO PolyStar
    return this;
  }
  
  // decodePath
  _ShapeFactory p(String str) {
    _graphics.decode(str);
    return this;
  }
}
