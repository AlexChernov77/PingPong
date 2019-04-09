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
#import "DependencyInjection.h"
#import "PresenterDelegate.h"
#import "CustomButton.h"

static const CGFloat RacketViewHeight = 10.f;
static const CGFloat RacketViewHWidth = 70.f;
static const CGFloat VerticalMargin = 50.f;

@interface ViewController ()

@property id<PresenterDelegate> presenterDelegate;
@property (strong, nonatomic) UIView *topRacket;
@property (strong, nonatomic) PlayerRacketView *bottomRacket;
@property (strong, nonatomic) UIView *ball;
@property (assign, nonatomic) CGFloat dX;
@property (assign, nonatomic) CGFloat dY;
@property (strong, nonatomic) CustomButton *pauseButton;
@property (strong, nonatomic) UIView *pauseScreen;
@property (strong, nonatomic) NSTimer *gameTimer;
    
@end

@implementation ViewController
    
-(void)viewDidLoad
{
    [super viewDidLoad];
	[DependencyInjection assignView:self];
    [self setupViews];
    [self startGame];
}


#pragma mark- Layout & Setup

-(void)setupViews
{
        self.presenterDelegate.topScore = 0;
        self.presenterDelegate.bottomScore = 0;
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
	
        self.pauseButton = [[CustomButton alloc] initWithParamets:@"Пауза" :UIColor.greenColor : CGRectMake(CGRectGetWidth(self.view.frame)/2 - 40.0, CGRectGetHeight(self.view.frame)/2 - 15.0, 80.0, 30.0)];
        [self.pauseButton addTarget:self action:@selector(pauseGame) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview: self.pauseButton];
}

-(void)setupButtons
{
	CustomButton *easyButton = [[CustomButton alloc] initWithParamets:@"Легко" :UIColor.blackColor : CGRectMake(0,CGRectGetHeight(self.view.frame)/4 + 160, CGRectGetWidth(self.view.frame)/3, 80)];
	[easyButton addTarget:self action:@selector(changeSpeed:) forControlEvents:UIControlEventTouchUpInside];
	[self.pauseScreen addSubview: easyButton];
	
	CustomButton *medium = [[CustomButton alloc] initWithParamets:@"Средне" :
							UIColor.blueColor :
							CGRectMake(CGRectGetWidth(self.view.frame)/3,
									   CGRectGetHeight(self.view.frame)/4 + 160,
									   CGRectGetWidth(self.view.frame)/3, 80)];
	[medium addTarget:self action:@selector(changeSpeed:) forControlEvents:UIControlEventTouchUpInside];
	[self.pauseScreen addSubview: medium];
	
	
	CustomButton *hard = [[CustomButton alloc] initWithParamets:@"Сложно" :
						  UIColor.redColor :
						  CGRectMake(CGRectGetWidth(self.view.frame)*2/3,
									 CGRectGetHeight(self.view.frame)/4 + 160,
									 CGRectGetWidth(self.view.frame)/3, 80)];
	[hard addTarget:self action:@selector(changeSpeed:) forControlEvents:UIControlEventTouchUpInside];
	[self.pauseScreen addSubview: hard];
}

-(void)setupPauseView
{
	self.pauseScreen = [[UIView alloc] initWithFrame:CGRectMake(0, 0,CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
	self.pauseScreen.backgroundColor = [UIColor greenColor];
	
	[self.view addSubview:self.pauseScreen];
}

-(void)setupLabel
{
	UILabel *text = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)/2 - 200, CGRectGetHeight(self.view.frame)/4, 400,160)];
	text.numberOfLines = 0;
	text.text = [[NSString alloc] initWithFormat:@"Счет\n\nБот - %ld \n Вы - %ld \n\n\n Выберете сложность игры:",(long)self.presenterDelegate.topScore, (long)self.presenterDelegate.bottomScore];
	text.textAlignment = NSTextAlignmentCenter;
	[self.pauseScreen addSubview: text];
}


#pragma mark - Game Methods

-(void)startGame
{
    self.ball.center = self.view.center;
    self.dX = self.dY = 1.0;
    self.gameTimer = [NSTimer scheduledTimerWithTimeInterval:[self.presenterDelegate currentSpeed] target:self selector:@selector(moveBall) userInfo:nil repeats:YES];
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
		[self.presenterDelegate incrementTopScore];
        [self resetOrContinueGame: YES];
    }
    if(self.ball.frame.origin.y < 0)
    {
		[self.presenterDelegate incrementBottomScore];
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
        self.ball.center = self.presenterDelegate.savePoint;
		[self transitionAnimation:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn] : kCATransition];
    }
        
    self.gameTimer = [NSTimer scheduledTimerWithTimeInterval:[self.presenterDelegate currentSpeed] target:self selector:@selector(moveBall) userInfo:nil repeats:YES];
}
    
-(void)pauseGame
{
    [self stopTimer];
    self.presenterDelegate.savePoint = self.ball.center;
	[self setupPauseView];
	[self setupLabel];
	[self setupButtons];
	[self transitionAnimation:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut] : kCATransitionPush];
}


#pragma mark - ViewInput
    
- (void)assign:(nonnull id<PresenterDelegate>)presenterDelegate
{
	self.presenterDelegate = presenterDelegate;
}


#pragma mark - Addition Methods

-(void)changeSpeed:(UIButton*)sender
{
	[self.presenterDelegate changeSpeed:sender.titleLabel.text];
	[self resetOrContinueGame: NO];
}

-(CATransition*)transitionAnimation: (CAMediaTimingFunction*) timingFunction : (CATransitionType) type
{
	CATransition *transition = [CATransition animation];
	transition.duration = 1.5;
	transition.timingFunction = timingFunction;
	transition.type = type;
	[self.view.layer addAnimation:transition forKey:kCATransition];
	return transition;
}

@end
