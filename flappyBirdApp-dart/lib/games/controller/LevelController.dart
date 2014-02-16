part of GameLib;

class LevelController {
  
  Bird _bird;
  CountView _countView;
  RepeatGround _ground;
  Sprite _container;
  Shape _flickr;
  GameOver _gameOver;
  List<Pipes> _pool;
  int _speed = new GameModel().speed;
  int _pipesGap = 360;

  EventStreamSubscription _eventStreamSubscription;
  
  LevelController(FlappyBirdApp app) {
    _container = app.pipesContainer;
    _bird = app.bird;
    _countView = app.countView;
    _ground = app.ground;
    _pool = new List<Pipes>();
  } 
  
  void start() {
    _container.x  = 0;
    _eventStreamSubscription = _container.onEnterFrame.listen(_run);
  }
  
  void _run(e) {
    updatePosition();
    checkStatus();
    updateCountView();
  }
  
  void updatePosition() {

    _container.x -= _speed;
    
    //remove out of screen pipes
    Pipes pipes;
    int pipeNum = _container.numChildren;
    while(pipeNum-- > 0) {
      pipes = _container.getChildAt(pipeNum);
      if (112 + pipes.x + _container.x < 0) {
        _pool.add(pipes);
        pipes.removeFromParent();
      }
    }
    
    // add new pipes
    if (_container.x.toInt() % _pipesGap == 0) {
      pipes = createPipes();
      pipes.x = -_container.x + 1000;
      _container.addChild(pipes);
    }
    
  }
  
  void updateCountView() {

    int currentLevel = 0;
    if (_container.x > -1000) {
      currentLevel = 0;
    } else {
      currentLevel = ((-_container.x + 56 - 1000) ~/ _pipesGap).toInt();
    }
    _countView.count = currentLevel;
  }
  
  void checkStatus() {
    GameModel model = new GameModel();
    if (model.isGameOver) {
      gameEnd();
      return;
    }
    
    int pipeNum = _container.numChildren;
    Pipes pipes;
    
    while(pipeNum-- > 0) {
      pipes = _container.getChildAt(pipeNum);
      
      if (pipes.upPipe.hitTestObject(_bird.detectShape) || 
          pipes.downPipe.hitTestObject(_bird.detectShape)) {
        model.status = GameModel.GAME_OVER;
        gameEnd();
        return;
      }
      
    }
  }
  
  void gameEnd() {

    GameModel model = new GameModel();
    
    Stage stage = _container.stage;
    _flickr = new Shape();
    _flickr.graphics..beginPath()
                    ..rect(0, 0, model.gameWidth, model.gameHeight)
                    ..closePath()
                    ..fillColor(0xffffffff);
    stage.addChild(_flickr);
    
    Tween tween = new Tween(_flickr, .4, TransitionFunction.easeInSine);
    tween..animate.alpha.to(0)
         ..delay = .1
         ..onComplete = changeGameStatusToWait;
    
    stage.juggler.add(tween);
    
    
    _gameOver = new GameOver();
    _gameOver..x = (model.gameWidth - _gameOver.width) * .5 
             ..y = (model.gameHeight - _gameOver.height) * .5; 
    stage.addChild(_gameOver);
    
    _eventStreamSubscription.cancel();
    _eventStreamSubscription = null;
    
    resources.getSound("SoundCrash").play();
    _ground.stop();
  }
  
  void changeGameStatusToWait(){
    _flickr.removeFromParent();
    _flickr = null;
    new GameModel().status = GameModel.WAIT_TO_BACK_BEGIN;
  }
  
  void reset() {
    int pipeNum = _container.numChildren;
    while(pipeNum-- > 0) {
      _container.getChildAt(pipeNum).removeFromParent();
    }
    _countView.count = 0;
    _gameOver.removeFromParent();
    _gameOver = null;
    _ground.run();
  }
  
  Pipes createPipes() {
    if (_pool.length < 1) {
      return new Pipes();    
    } else {
      Pipes pipes = _pool.removeAt(0);
      pipes.rebuild();
      return pipes;
    }
  }
  
}