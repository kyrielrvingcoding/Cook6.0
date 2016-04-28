
//
//  AVPlayerController.m
//  AVPlayer
//
//  Created by 诸超杰 on 16/4/18.
//  Copyright © 2016年 诸超杰. All rights reserved.
//

#import "AVPlayerController.h"
#import "PlayVIew.h"
#import "AppDelegate.h"
#import "NSTimer+Addition.h"
#import <MediaPlayer/MediaPlayer.h>
typedef NS_ENUM(NSInteger, PlayState) {
    playStatePlaying,//播放中
    playStatePruse//暂停
    
};

@interface AVPlayerController ()

@property (nonatomic, strong) PlayVIew *playView;
@property (nonatomic, assign, readonly) PlayState playState;//播放状态

@property (nonatomic, strong) AVPlayerItem *item;
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) NSURL *url;//播放的
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) AVPlayerLayer *layer;
@property (nonatomic, assign) float nowTime;//记录时间
@property (nonatomic, strong) UISlider *volumeSlider;//声音
@property (nonatomic, strong) UIPanGestureRecognizer *pan;
@property (nonatomic, assign) int mark;
@property (nonatomic, strong) NSMutableArray *stepArray;
@property (nonatomic, assign) NSUInteger stepNumber;//当前显示的操作步骤
@property (nonatomic, assign) CGRect frame;
@end

@implementation AVPlayerController

//隐藏其他的显示中间时间的的
- (void)hiddenOtherExceptMovieLabel:(BOOL)isHidden {
    self.playView.alreadyTImeLabel.hidden = isHidden;
    self.playView.remain.hidden = isHidden;
    self.playView.backButton.hidden = isHidden;
    self.playView.timeSlider.hidden = isHidden;
    self.playView.playButton.hidden = isHidden;
    self.playView.titleLabel.hidden = isHidden;
    self.playView.clearLabel.hidden = isHidden;
    self.playView.backView.hidden = isHidden;
//    self.playView.moveTimeLabel.hidden = !isHidden;
    if (isHidden) {
        self.playView.backgroundColor = [UIColor clearColor];
        _pan.enabled = YES;
    } else {
    self.playView.backgroundColor = [UIColor blackColor];
        _pan.enabled = NO;
    }
}

//KVO当item加载完成时
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    //当item准备播放的时候.把播放器打开，关闭风火轮
    if ([change[@"new"] isEqualToNumber:@1]) {
        self.playView.activityView.hidden = YES;
        [self.playView.activityView stopAnimating];
        [self playAndPruse:self.playView.playButton];
        self.playView.alpha = 0.55;
//        _timer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(timerChange:) userInfo:nil repeats:YES];
//        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
//        [[NSRunLoop currentRunLoop] run];
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerChange:) userInfo:nil repeats:YES];
//        [_timer pauseTimer];//先关就可以在滑动的手势中关闭定时器，不然就不行
        //更新播放界面子视图
        [self valueChanged:self.playView.timeSlider forEvent:nil];
        [self refreshPlayViewSubView];

    }
    

}

- (NSMutableArray *)stepArray {
    if (_stepArray == nil) {
        _stepArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _stepArray;
}

//刷新播放界面的子视图，入时间，拖动条等
- (void)refreshPlayViewSubView {
    long long seconds = self.player.currentItem.duration.value / self.player.currentItem.duration.timescale;
    self.playView.timeSlider.maximumValue = seconds;
    float m = seconds / 60;
    int s = seconds % 60;
    self.playView.remain.text = [NSString stringWithFormat:@"%02d:%02d", (int)m, s];
    [self noIshidden];

}

//更新播放页面
- (void)refreshView {
    //获得当前播放页面的总时间
    //正中心显示菊花//
    //    [_player replaceCurrentItemWithPlayerItem:_item];
    
    [self.player.currentItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    [self.playView.activityView startAnimating];
    self.playView.titleLabel.text = _model.name;
    StepListModel *model = _model.stepListModelArray[0];
    self.playView.stepLabel.text = model.details;
    NSLog(@"refreshView");
}

//定时器方法，用于刷新界面
- (void)timerChange:(NSTimer *)timer {
    if (_mark == 1) {
        return;
    }
    long long seconds = self.player.currentItem.currentTime.value / self.player.currentItem.currentTime.timescale;
    if (self.playView.hidden == NO) {
        //显示出来的时候，才更新数据
//        NSLog(@"定时器方法");
        float m = seconds / 60;
        int s = seconds % 60;
        self.playView.timeSlider.value = seconds;
        self.playView.alreadyTImeLabel.text = [NSString stringWithFormat:@"%02d:%02d", (int)m, s];
    }
    
}

//url的set方法，用于item和_player的创建
- (void)setUrl:(NSURL *)url {
    _item = [[AVPlayerItem alloc] initWithURL:url];
    _player = [[AVPlayer alloc] initWithPlayerItem:_item];
    [self.player.currentItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    _layer = [AVPlayerLayer playerLayerWithPlayer:_player];
    _layer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
    [self.view.layer insertSublayer:_layer atIndex:0];
    NSLog(@"setUrl");
}
- (void)ssss:(id)ss {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(ssss:) userInfo:nil repeats:YES];
    _mark = 0;
 
    if (!_model.playUrl) {
        _model.playUrl = [NSString stringWithFormat:@"http://tv.ecook.cn/s/%@.mp4",_model.ID];
    }
    [self setUrl:[NSURL URLWithString:_model.playUrl]];
    
    
   MPVolumeView  *volumeView = [[MPVolumeView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    self.volumeSlider = volumeView.subviews[0];
    
    NSArray *playViews = [[NSBundle mainBundle] loadNibNamed:@"PlayView" owner:nil options:nil];
    PlayVIew *playView = playViews[0];
    playView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    _playView = playView;
    [self.view addSubview:_playView];
    
    [_playView.playButton addTarget:self action:@selector(playAndPruse:) forControlEvents:UIControlEventTouchUpInside];
    [_playView.backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    UIImage *circluImage = [UIImage imageNamed:@"点1"];
    //
      UIGraphicsBeginImageContextWithOptions(CGSizeMake(20, 20), NO, 0.0);
    [circluImage drawInRect:CGRectMake(0, 0, 20, 20)];
    
  
      UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    
    [self.playView.timeSlider setThumbImage:newImage forState:(UIControlStateNormal)];
    [self.playView.timeSlider addTarget:self action:@selector(valueChanged:forEvent:) forControlEvents:UIControlEventValueChanged];
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapByfinger:)];
    [self.view addGestureRecognizer:tapGR];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panAction:)];
    _pan = pan;
    _pan.enabled = NO;
    [self.view addGestureRecognizer:_pan];
    
   
    UIPanGestureRecognizer *stepPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(StepPan:)];
    [self.playView.stepView addGestureRecognizer:stepPan];
    [self.playView.stepButton addTarget:self action:@selector(showStepLabel:) forControlEvents:UIControlEventTouchUpInside];
    for (int i = 0; i < _model.stepListModelArray.count; i ++) {
        StepListModel *stepModel = _model.stepListModelArray[i];
        [self.stepArray addObject:stepModel.details];
    }
    _stepNumber = 1;
    [self refreshView];
    NSLog(@"viewDidLoad");

}

- (void)StepPan:(UIPanGestureRecognizer *)pan {
    CGPoint point = [pan translationInView:self.view];
    

    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            self.frame = self.playView.stepLabel.frame;
            break;
            
        case UIGestureRecognizerStateChanged:
            //改变frame
            if (self.frame.origin.x + 100 > self.playView.stepLabel.x && self.frame.origin.x - 100 < self.playView.stepLabel.x) {
                self.playView.stepLabel.x += point.x;
            }
            
            break;
            

        case UIGestureRecognizerStateEnded:
            if (self.playView.stepLabel.x > self.frame.origin.x) {
                if (_stepNumber == 1) {
                    _stepNumber = _stepArray.count + 1;
                }
                _stepNumber -= 1;
                [UIView animateWithDuration:0.3 animations:^{
                    self.playView.stepLabel.x = SCREENWIDTH;
                } completion:^(BOOL finished) {
                    self.playView.stepLabel.text =[NSString stringWithFormat:@"步骤%lu:    %@",(unsigned long)_stepNumber , _stepArray[_stepNumber - 1]];
                    self.playView.stepLabel.x = -SCREENWIDTH;
                    [UIView animateWithDuration:0.3 animations:^{
                         self.playView.stepLabel.frame = self.frame;
                    }];
                }];
               
            } else {
                
                if (_stepNumber == _stepArray.count) {
                    _stepNumber = 0;
                }
                
                _stepNumber += 1;
                [UIView animateWithDuration:0.3 animations:^{
                    self.playView.stepLabel.x = -SCREENWIDTH;
                } completion:^(BOOL finished) {
                    self.playView.stepLabel.text =[NSString stringWithFormat:@"步骤%lu:  %@",(unsigned long)_stepNumber , _stepArray[_stepNumber - 1]];
                    self.playView.stepLabel.x = SCREENWIDTH;
                    [UIView animateWithDuration:0.3 animations:^{
                        self.playView.stepLabel.frame = self.frame;
                    }];
                }];
            }
            
            break;
            

        default:
            break;
    }
    
    [pan setTranslation:CGPointZero inView:self.view];
    
}

- (void)showStepLabel:(UIButton *)button {
    button.userInteractionEnabled = NO;



    if (self.playView.stepView.frame.origin.y < self.view.frame.size.height) {
        self.playView.stepView.userInteractionEnabled = NO;
        CGRect frame = self.playView.stepView.frame;
        frame.origin.y = self.view.frame.size.height;
        [UIView animateWithDuration:1 animations:^{
            self.playView.stepView.frame = frame;
        } completion:^(BOOL finished) {
            button.userInteractionEnabled = YES;
        }];
    } else {
        CGRect frame = self.playView.stepView.frame;
        [UIView animateWithDuration:1 animations:^{
            self.playView.stepView.frame = CGRectMake(frame.origin.x, 302, frame.size.width, frame.size.height);
            
        } completion:^(BOOL finished) {
            self.playView.stepView.userInteractionEnabled = YES;
            button.userInteractionEnabled = YES;
        }];

    }
    
}

- (void)valueChanged:(UISlider *)sender forEvent:(UIEvent *)event
{
    
    UITouch *touch = [[event allTouches]anyObject];
    if (touch == nil) {
        return;
    }
    switch (touch.phase)
    {
        case UITouchPhaseBegan:{

            if (self.playState == playStatePlaying) {
            [self playAndPruse:self.playView.playButton];
            }
            

            _mark = 1;
//            [_timer pauseTimer];
            
            

            break;
        }
        case UITouchPhaseMoved:{
            float m = sender.value / 60;
            int s = (int)sender.value % 60;
            self.playView.alreadyTImeLabel.text = [NSString stringWithFormat:@"%02d:%02d", (int)m, s];
            _mark = 1;
            
            break;
        }
        case UITouchPhaseEnded:{
            CMTime newTime = self.player.currentTime;
            newTime.value = newTime.timescale * sender.value;
            [self.player seekToTime:newTime completionHandler:^(BOOL finished) {
                _mark = 0;
                NSLog(@"===============================开启计时器");
                [self performSelector:@selector(open) withObject:self afterDelay:0.3];
               
            }];
           
            break;
        }
        default:
            break;
    }
    [self noIshidden];
}

- (void)open {
    if (self.playState == playStatePruse) {
        [self playAndPruse:self.playView.playButton];
    }

}

- (void)panAction:(UIPanGestureRecognizer *)pan {
    CGPoint point = [pan velocityInView:self.view];//多少像素秒
    NSString *style;
    if (point.x > 0)
    {
        style = @">>";//快进
    }
    else
    {
        style = @"<<";//后退
    }
    switch (pan.state)
    {
        case UIGestureRecognizerStateBegan:
        {
            if (fabs(point.x) > fabs(point.y))//如果x移动的决定值比y多
            {
                if (self.playState == playStatePlaying) {
                    [self playAndPruse:self.playView.playButton];
                }

                //水平移动
                self.playView.moveTimeLabel.hidden = NO;
                _nowTime = self.player.currentTime.value / self.player.currentTime.timescale;
                self.playView.moveTimeLabel.text = [self scheduleStr:_nowTime style:style];
            }
            else
            {
                
                
                //                self.volumSlider.hidden = NO;//把音量控件显示出来
            }
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
            if (fabs(point.x) > fabs(point.y))
            {
                //水平移动
                [self horizontaolMovement:point.x style:style];
            }
            else
            {
                self.volumeSlider.value += -point.x / 10000;
                
            }
            break;
        }
        case UIGestureRecognizerStateEnded:
        {
            if (fabs(point.x) > fabs(point.y))
            {
                //水平移动
                CMTime newTime = self
                .player.currentTime;
                newTime.value = newTime.timescale * _nowTime;
                [self.player seekToTime:newTime];//把时间调到移动到的点
                _nowTime = 0;//把移动的时间重置为0
                self.playView.moveTimeLabel.hidden = YES;
                [self performSelector:@selector(open) withObject:self afterDelay:0.3];
            }
            else
            {
                //竖直移动
                //                _volumSlider.hidden = YES;
            }
            break;
        }
            
        default:
            break;
    }
    
}

//显示隐藏的label
- (NSString *)scheduleStr:(float)time style:(NSString *)style
{
    int m = time / 60;
    int s = (int)time % 60;
    long long seconds = self.player.currentItem.duration.value / self.player.currentItem.duration.timescale;
    int duration = (int)seconds;
    int M = duration / 60;
    int S = duration % 60;
    return [NSString stringWithFormat:@"%@ %02d:%02d / %02d:%02d", style, m, s, M, S];
}


- (void)horizontaolMovement:(float)x style:(NSString *)style
{
    if (self.player.currentItem.duration.timescale == 0) {
        return;
    }
    long long seconds = self.player.currentItem.duration.value / self.player.currentItem.duration.timescale;
    int duration = (int)seconds;
    _nowTime += (x / duration * 5);
    NSLog(@"%f",_nowTime);
    if (_nowTime < 0)
    {
        _nowTime = 0;
    }
    else if (_nowTime > duration)
    {
        _nowTime = duration;
    }
    self.playView.moveTimeLabel.text = [self scheduleStr:_nowTime style:style];
}

- (void)tapByfinger:(UITapGestureRecognizer *)tap {
    [self noIshidden];//不管有么有显示，三秒后都执隐藏任务
//    self.playView.hidden = !self.playView.hidden;
    [self hiddenOtherExceptMovieLabel:!self.playView.playButton.hidden];
    
}

//暂停或者播放
- (void)playAndPruse:(UIButton *)sender {
    if (_playState == playStatePlaying) {
        [self.player pause];
        [sender setImage:[UIImage imageNamed:@"播放状态"]forState:UIControlStateNormal];
        _playState = playStatePruse;
        [self noIshidden];
    } else {
        [self.player play];
        [sender setImage:[UIImage imageNamed:@"暂停状态"] forState:(UIControlStateNormal)];
        _playState = playStatePlaying;
        [self noIshidden];
    }
    
}


//返回上一个界面
- (void)back:(UIButton *)sender {
    [_timer invalidate];//关闭定时器
    _timer = nil;
    //返回时候停止播放
    if (_playState == playStatePlaying) {
        [self playAndPruse:self.playView.playButton];
    }
    [self.player.currentItem removeObserver:self forKeyPath:@"status"];
    self.item = nil;
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    appDelegate.is_flip = NO;
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (void)noIshidden//三秒后执行隐藏任务
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(timerFunction) object:nil];//取消当前线程中还没有执行的名字为timerFunction
    
    //在当前线程中放入一个3秒后执行的任务
    [self performSelector:@selector(timerFunction) withObject:nil afterDelay:3];
}

- (void)timerFunction//把整个遮罩都隐藏掉都隐藏掉
{
//    self.playView.hidden = YES;

    [self hiddenOtherExceptMovieLabel:YES];
}

- (void)dealloc {
    NSLog(@"so;");
    if (self.player) {
        self.player = nil;
    }
}
//是当应用程序收到内存警告时，会被触发，而且是工程中所有的控制器对象(viewController类被创建过对象，并且对象没有被释放)都会收到内存警告
//当收到内存警告是，要释放可再生的内存数据，通过方法可将资源重写加载回来
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    //是否当前页面
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
