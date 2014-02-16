part of GameLib;
class Pipes extends Sprite {
  
  Pipe upPipe;
  Pipe downPipe;
  
  int _gap = 150;
  int _gameH = new GameModel().gameHeight;
  Random _random = new Random();
  
  Pipes() {
    int ty = _random.nextInt(300) + 250;
    downPipe = new Pipe(Pipe.DOWN, ty);
    int upHeight = _gameH - ty - 200;
    upPipe = new Pipe(Pipe.UP, upHeight);
    upPipe.y = _gameH - upHeight;

    addChild(upPipe);
    addChild(downPipe);
  }
  
  // better than new a instance
  void rebuild() {
    int ty = _random.nextInt(300) + 250;
    downPipe.rebuild(ty);
    int upHeight = _gameH - ty - 200;
    upPipe..rebuild(upHeight)
          ..y = _gameH - upHeight;
  }
}
  