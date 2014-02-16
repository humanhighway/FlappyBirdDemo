
part of GameLib;

class RepeatGround extends Shape {
  
  int _speed = new GameModel().speed;
  int _gameW = new GameModel().gameWidth;
  
  EventStreamSubscription _eventStreamSubscription;
  
  RepeatGround() {
    
    GameModel model = new GameModel();
    Matrix matrix = new Matrix.fromIdentity();
    GraphicsPattern pattern = new GraphicsPattern.repeatX(resources.getBitmapData("ground"), matrix);
    graphics..beginPath()
            ..rect(0, 0, (model.gameWidth + model.speed) * 2, 50)
            ..closePath()
            ..fillPattern(pattern);
    run();
  }
  
  void run() {
    if (_eventStreamSubscription != null) {
      _eventStreamSubscription.resume();
    } else {
      _eventStreamSubscription = this.onEnterFrame.listen(_run);
    }
  }
  
  void _run(e) {
    if (this.x <= -_gameW && this.x%_speed == 0) {
      this.x = 0;
    } else {
      this.x -= _speed;
    }
  }
  
  void stop() {
    _eventStreamSubscription.cancel();
    _eventStreamSubscription = null;
  }
}
