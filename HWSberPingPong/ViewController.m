//
//  ViewController.m
//  HWSberPingPong
//
//  Created by Александр on 07/04/2019.
//  Copyright © 2019 Александр. All rights reserved.
//

#import "ViewController.h"
#import "PlayerRacketView.h"
#import "HWSberViewControllerPresenter.h"

static const CGFloat RacketViewHeight = 10.f;
static const CGFloat RacketViewHWidth = 70.f;
static const CGFloat VerticalMargin = 50.f;

@interface ViewController ()

@property (strong, nonatomic) UIView *topRacket;
@property (strong, nonatomic) PlayerRacketView *bottomRacket;
@property (strong, nonatomic) UIView *ball;
@property (assign, nonatomic) CGFloat dX;
@property (assign, nonatomic) CGFloat dY;
@property (assign, nonatomic) uint32_t topScore;
@property (assign, nonatomic) uint32_t bottomScore;
@property (strong, nonatomic) UIButton *pauseButton;
@property (strong, nonatomic) UIView *pauseScreen;
@property (strong, nonatomic) NSTimer *gameTimer;
@property (assign, nonatomic) double currentSpeed;
@property (assign, nonatomic) CGPoint savePoint;
@property (strong, nonatomic) HWSberViewControllerPresenter *presenter;
    
@end

@implementation ViewController
    
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self setupViews];
    [self startGame];
}


#pragma mark- Layout & Setup

-(void)setupViews
{
        self.topScore = 0;
        self.bottomScore = 0;
        self.view.backgroundColor = [UIColor blackColor];
        
        self.topRacket = [[UIView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - RacketViewHWidth)/2, VerticalMargin, RacketViewHWidth, RacketViewHeight)];
        self.topRacket.backgroundColor = [UIColor whiteColor];
        [self.view addSubview: self.topRacket];
        
        self.bottomRacket = [[PlayerRacketView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - RacketViewHWidth)/2, self.view.frame.size.height - VerticalMargin, RacketViewHWidth, RacketViewHeight)];
        self.bottomRacket.backgroundColor = [UIColor whiteColor];
        [self.view addSubview: self.bottomRacket];
        
        self.ball = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 30.0, 30.0)];
        self.ball.backgroundColor = [UIColor yellowColor];
        self.ball.layer.masksToBounds = YES;
        self.ball.layer.cornerRadius = self.ball.frame.size.height / 2;
        [self.view addSubview: self.ball];
    
    
        //переделать с навигейшеном
        self.pauseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.pauseButton.frame = CGRectMake(CGRectGetWidth(self.view.frame)/2 - 40.0, CGRectGetHeight(self.view.frame)/2 - 15.0, 80.0, 30.0);
        self.pauseButton.backgroundColor = [UIColor greenColor];
        [self.pauseButton setTitle:@"Пауза" forState:UIControlStateNormal];
        [self.pauseButton addTarget:self action:@selector(pauseGame) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview: self.pauseButton];
}


#pragma mark- Game Methods

-(void)startGame
{
    self.ball.center = self.view.center;
    self.dX = self.dY = 1.0;
    self.currentSpeed = 0.005f; // По умолчанию, скорость нормальная
    self.gameTimer = [NSTimer scheduledTimerWithTimeInterval:self.currentSpeed target:self selector:@selector(moveBall) userInfo:nil repeats:YES];
}
    
-(void)moveBall
{
    [self checkTopView];
    
    if (CGRectIntersectsRect(self.ball.frame, self.topRacket.frame) || CGRectIntersectsRect(self.ball.frame, self.bottomRacket.frame))
    {
        self.dY *= -1;
    }
        
    if ((self.ball.frame.origin.x + self.ball.frame.size.width > self.view.frame.size.width) ||
        (self.ball.frame.origin.x < 0))
    {
        self.dX *= -1;
    }
        
    if (self.ball.frame.origin.y + self.ball.frame.size.height > self.view.frame.size.height){
        self.topScore++;
        [self resetOrContinueGame: YES];
    }
    if(self.ball.frame.origin.y < 0)
    {
        self.bottomScore++;
        [self resetOrContinueGame: YES];
    }
        
    self.ball.center = CGPointMake(self.ball.center.x + self.dX, self.ball.center.y + self.dY);
}

-(void)checkTopView
{
    if (self.ball.center.x >= self.view.frame.size.width - RacketViewHWidth/2)
    {
        self.topRacket.center = CGPointMake(self.view.frame.size.width - RacketViewHWidth/2, VerticalMargin);
    }
    else if (self.ball.center.x <= RacketViewHWidth/2)
    {
        self.topRacket.center = CGPointMake(RacketViewHWidth/2, VerticalMargin);
    }
    else
    {
        self.topRacket.center = CGPointMake(self.ball.center.x, VerticalMargin);
    }
}
    
-(void)stopTimer
{
    [self.gameTimer invalidate];
    self.gameTimer = nil;
}
    
-(void)resetOrContinueGame: (BOOL) reset
{
    if (reset)
    {
        [self stopTimer];
        self.ball.center = self.view.center;
        self.dY *= -1;
        self.dX *= -1;
    }
    else
    {
        [self.pauseScreen removeFromSuperview];
        self.ball.center = self.savePoint;
        
        CATransition *transition = [CATransition animation];
        transition.duration = 1.5;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        transition.subtype = kCATransitionFromTop;
        transition.type = kCATransitionReveal;
        [self.view.layer addAnimation:transition forKey:kCATransition];
    }
        
    self.gameTimer = [NSTimer scheduledTimerWithTimeInterval:self.currentSpeed target:self selector:@selector(moveBall) userInfo:nil repeats:YES];
}
    
-(void)pauseGame
{
    [self stopTimer];
    self.savePoint = self.ball.center;
    
    self.pauseScreen = [[UIView alloc] initWithFrame:CGRectMake(0, 0,CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
    self.pauseScreen.backgroundColor = [UIColor greenColor];
    
    UILabel *text = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)/2 - 200, CGRectGetHeight(self.view.frame)/4, 400,160)];
    text.numberOfLines = 0;
    text.text = [[NSString alloc] initWithFormat:@"Счет\n\nКомпьютер - %d \n Игрок - %d \n\n\n Выберете скорость игры:",self.topScore, self.bottomScore];
    text.textAlignment = NSTextAlignmentCenter;
    [self.pauseScreen addSubview: text];
        
    UIButton *slowButton = [UIButton buttonWithType:UIButtonTypeCustom];
    slowButton.frame = CGRectMake(0,CGRectGetHeight(self.view.frame)/4 + 160, CGRectGetWidth(self.view.frame)/3, 80);
    slowButton.backgroundColor = [UIColor lightGrayColor];
    [slowButton setTitle:@"Медленно" forState:UIControlStateNormal];
    [slowButton addTarget:self action:@selector(slow) forControlEvents:UIControlEventTouchUpInside];
    [self.pauseScreen addSubview: slowButton];
        
    UIButton *normalButton = [UIButton buttonWithType:UIButtonTypeCustom];
    normalButton.frame = CGRectMake(CGRectGetWidth(self.view.frame)/3, CGRectGetHeight(self.view.frame)/4 + 160, CGRectGetWidth(self.view.frame)/3, 80);
    normalButton.backgroundColor = [UIColor grayColor];
    [normalButton setTitle:@"Обычная" forState:UIControlStateNormal];
    [normalButton addTarget:self action:@selector(normal) forControlEvents:UIControlEventTouchUpInside];
    [self.pauseScreen addSubview: normalButton];
        
    UIButton *fastButton = [UIButton buttonWithType:UIButtonTypeCustom];
    fastButton.frame = CGRectMake(CGRectGetWidth(self.view.frame)*2/3, CGRectGetHeight(self.view.frame)/4 + 160, CGRectGetWidth(self.view.frame)/3, 80);
    fastButton.backgroundColor = [UIColor darkGrayColor];
    [fastButton setTitle:@"Быстро" forState:UIControlStateNormal];
    [fastButton addTarget:self action:@selector(fast) forControlEvents:UIControlEventTouchUpInside];
    [self.pauseScreen addSubview: fastButton];
        
    [self.view addSubview:self.pauseScreen];
        
    CATransition *transition = [CATransition animation];
    transition.duration = 1.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    [self.view.layer addAnimation:transition forKey:kCATransition];
}
    
-(void)slow
{
    self.currentSpeed = 0.01f;
    [self resetOrContinueGame: NO];
}
    
-(void)normal
{
    self.currentSpeed = 0.005f;
    [self resetOrContinueGame: NO];
}
    
-(void)fast
{
    self.currentSpeed = 0.0025f;
    [self resetOrContinueGame: NO];
}
    
@end
