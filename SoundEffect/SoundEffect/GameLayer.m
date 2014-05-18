//
//  HelloWorldLayer.m
//  SoundEffect
//
//  Created by EUNJI KIM on 13. 6. 25..
//  Copyright __MyCompanyName__ 2013년. All rights reserved.
//


#import "GameLayer.h"
#define FRONT_CLOUD_SIZE 563
#define BACK_CLOUD_SIZE  509
#define FRONT_CLOUD_TOP  310
#define BACK_CLOUD_TOP   230

@implementation GameLayer
+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	GameLayer *layer = [GameLayer node];
	[scene addChild: layer];
	return scene;
}

- (void)createCloudWithSize:(int)imgSize top:(int)imgTop fileName:(NSString*)fileName interval:(int)interval z:(int)z {
    id enterRight	= [CCMoveTo actionWithDuration:interval position:ccp(0, imgTop)];
    id enterRight2	= [CCMoveTo actionWithDuration:interval position:ccp(0, imgTop)];
    id exitLeft		= [CCMoveTo actionWithDuration:interval position:ccp(-imgSize, imgTop)];
    id exitLeft2	= [CCMoveTo actionWithDuration:interval position:ccp(-imgSize, imgTop)];
    id reset		= [CCMoveTo actionWithDuration:0  position:ccp( imgSize, imgTop)];
    id reset2		= [CCMoveTo actionWithDuration:0  position:ccp( imgSize, imgTop)];
    id seq1			= [CCSequence actions: exitLeft, reset, enterRight, nil];
    id seq2			= [CCSequence actions: enterRight2, exitLeft2, reset2, nil];
    
    CCSprite *spCloud1 = [CCSprite spriteWithFile:fileName];
    [spCloud1 setAnchorPoint:ccp(0,1)];
    [spCloud1.texture setAliasTexParameters];
    [spCloud1 setPosition:ccp(0, imgTop)];
    [spCloud1 runAction:[CCRepeatForever actionWithAction:seq1]];
    [self addChild:spCloud1 z:z ];
    
    CCSprite *spCloud2 = [CCSprite spriteWithFile:fileName];
    [spCloud2 setAnchorPoint:ccp(0,1)];
    [spCloud2.texture setAliasTexParameters];
    [spCloud2 setPosition:ccp(imgSize, imgTop)];
    [spCloud2 runAction:[CCRepeatForever actionWithAction:seq2]];
    [self addChild:spCloud2 z:z ];
}

//새를 클릭했을 시에 일어나는 연기 애니메이션을 생성하는 메소드입니다.
- (void)createGun {
    //스프라이트 프레임 케쉬에 스프라이트를 저장합니다.
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"gun.plist"];
    
    //연기 이미지를 표시하기 위해 Sprite를 이용합니다.
    gunSmoke = [[CCSprite alloc] init];
    //GameLayer에 배경 Sprite를 Child로 넣습니다. z-index는 5로 설정합니다.
    [self addChild:gunSmoke z:5];
    
    //프레임을 담을 NSMutableArray형의 smokeFrames이름의 배열을 만듭니다.
    NSMutableArray *smokeFrames = [NSMutableArray array];
    //NSInteger형의 idx변수가 1부터 10미만이 될 때까지 1씩 증가시키며 for구문을 실행시킵니다.
    for(NSInteger idx = 1; idx < 10; idx++) {
        //알맞은 이미지를 프레임에 순서대로 담습니다.
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"shotgun_smoke2_%04d.png",idx]];
        //프레임을 배열에 저장합니다.
        [smokeFrames addObject:frame];
    }
    //프레임으로 CCAimation을 만듭니다. 각 프레임당 시간을 0.05초로 정해줍니다.
    CCAnimation *smokeAnimation = [CCAnimation animationWithSpriteFrames:smokeFrames delay:0.05f];
    //CCAnimation에  action을 줄 CCAnimte를 만듭니다.
    smokeAnimate = [[CCAnimate alloc] initWithAnimation:smokeAnimation];
    //스프라이트 프레임 케쉬에 저장한 스프라이트를 제거합니다.
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"gun.plist"];
}

//전봇대 줄 위로 새가 날아와 앉는 애니메이션을 생성하는 메소드입니다.
- (void)createBird {
    //스프라이트 프레임 케쉬에 스프라이트를 저장합니다.
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"bluebird.plist"];
    
    //새 이미지를 표시하기 위해 Sprite를 이용합니다.
    CCSprite *bird = [[CCSprite alloc] init];
    //새 위치를 지정합니다.
    [bird setPosition:ccp(50, 280)];
    //GameLayer에 배경 Sprite를 Child로 넣습니다. z-index는 5로 설정합니다.
    [self addChild:bird z:5];
    
    //프레임을 담을 NSMutableArray형의 flyFrames이름의 배열을 만듭니다.
    NSMutableArray *flyFrames = [NSMutableArray array];
    //NSInteger형의 idx변수가 1부터 17미만이 될 때까지 1씩 증가시키며 for구문을 실행시킵니다.
    for(NSInteger idx = 1; idx < 17; idx++) {
        //알맞은 이미지를 프레임에 순서대로 담습니다.
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"blue_fly%04d.png",idx]];
        //프레임을 배열에 저장합니다.
        [flyFrames addObject:frame];
    }
    //프레임으로 CCAimation을 만듭니다. 각 프레임당 시간을 0.05초로 정해줍니다.
    CCAnimation *flyAnimation = [CCAnimation animationWithSpriteFrames:flyFrames delay:0.05f];
    //CCAnimation에  action을 줄 CCAnimte를 만듭니다.
    CCAnimate *flyAnimate = [[CCAnimate alloc] initWithAnimation:flyAnimation];
    
    //프레임을 담을 NSMutableArray형의 sitFrames이름의 배열을 만듭니다.
    NSMutableArray *sitFrames = [NSMutableArray array];
    //NSInteger형의 idx변수가 1부터 61미만이 될 때까지 1씩 증가시키며 for구문을 실행시킵니다.
    for (NSInteger idx = 1; idx <61; idx++)  {
        //알맞은 이미지를 프레임에 순서대로 담습니다.
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"blue_sit_%04d.png",idx]];
        //프레임을 배열에 저장합니다.
        [sitFrames addObject:frame];
    }
    //프레임으로 CCAimation을 만듭니다. 각 프레임당 시간을 0.05초로 정해줍니다.
    CCAnimation *sitAnimation = [CCAnimation animationWithSpriteFrames:sitFrames delay:0.05f];
    //CCAnimation에  action을 줄 CCAnimte를 만듭니다.
    sitAnimate = [[CCAnimate alloc] initWithAnimation:sitAnimation];
    //스프라이트 프레임 케쉬에 저장한 스프라이트를 제거합니다.
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"bluebird.plist"];
    //CCRepeatForever를 사용하여 flyAnimaite를 반복 실행합니다.
    id actionFlyRepeat  = [CCRepeatForever actionWithAction:flyAnimate];
    //runAction을 사용하여 새가 움직이도록 해 봅니다.
    [bird runAction:actionFlyRepeat];
    
    //CCMoveTo를 사용하여 2초동안 타겟 위치인 (300,160)으로 움직입니다.
    id actionMoveTo = [CCMoveTo actionWithDuration:2 position:ccp(300, 160)];
    //CCCallFuncN을 사용하여 액션이 끝났을 때 moveComplete 메소드를 호출합니다.
    id moveComplete = [CCCallFuncN actionWithTarget:self selector:@selector(moveComplete:)];
    //CCSequence를 사용하여 actionMoveTo, moveComplete 순으로 액션을 실행합니다.
    id actionSeqence= [CCSequence actions:actionMoveTo, moveComplete, nil];
    //runAction을 사용하여 새가 자리에 앉도록 액션을 실행하도록합니다.
    [bird runAction:actionSeqence];
    
    
    
}

-(void)moveComplete:(id)bird {
    //미리 만든 bird스프라이트에서 하나씩 실행합니다.
    CCSprite *sprite = (CCSprite *)bird;
    //스프라이트의 모든 액션을 중지합니다.
    [sprite stopAllActions];
    //CCRepeatForever를 사용하여 sitAnimate를 실행하도록 합니다.
    id actionSitRepeat = [CCRepeatForever actionWithAction:sitAnimate];
    //runAction을 사용하여 주어진 액션을 실행하도록합니다.
    [sprite runAction:actionSitRepeat];
    
}


-(id) init
{
	if( (self=[super init])) {
        self.isTouchEnabled = YES;
        
        //총이 쐈을 경우를 위한 사운드 효과를 preload를 사용하여 미리 메모리에 올려 놓습니다.
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"handgun_fire.wav"];
        //배경음악을 위한 음악을 preload를 사용하여 미리 메모리에 올려 놓습니다.
        [[SimpleAudioEngine sharedEngine] preloadBackgroundMusic:@"bird.m4a"];
        //게임이 시작되면 배경 백그라운드 음악이 재생됩니다.
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"bird.m4a" loop:YES];
        //배경 백그라운드 음악의 음량을 0.5로 조절합니다.
        [[SimpleAudioEngine sharedEngine] setBackgroundMusicVolume:0.5f];
        //사운드 효과의 음량을 0.5로 지정합니다.
        [[SimpleAudioEngine sharedEngine] setEffectsVolume:0.5f];
        
        CCSprite *back = [CCSprite spriteWithFile:@"back.png"];
        [back setPosition:ccp(240, 160)];
        [self addChild:back z:0];
        
        CCSprite *setting = [CCSprite spriteWithFile:@"setting.png"];
        [setting setPosition:ccp(240, 160)];
        [self addChild:setting z:2];
        
        CCSprite *pole = [CCSprite spriteWithFile:@"pole.png"];
        [pole setAnchorPoint:ccp(0.5f, 0.0f)];
        [pole setPosition:ccp(240, 0)];
        [self addChild:pole z:2];
        
        [self createCloudWithSize:FRONT_CLOUD_SIZE top:FRONT_CLOUD_TOP fileName:@"cloud_front.png" interval:15 z:2];
        [self createCloudWithSize:BACK_CLOUD_SIZE  top:BACK_CLOUD_TOP  fileName:@"cloud_back.png"  interval:30 z:1];
        [self createBird];
        [self createGun];
    }
	return self;
}

#pragma mark -
#pragma mark TouchHandler

//처음 손가락이 화면에 닿는 순간 호출됩니다.
-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // touch 라는 문구를 출력합니다.
    // 화면의 터치하는 곳의 좌표를 glLocation으로 정의하고
    // glLocation인 곳에서 연기를 나타내는 스프라이트인 gunSmoke를 나타나게합니다.
    UITouch *touch = [touches anyObject];
	
    CGPoint location = [touch locationInView:[touch view]];
	
    CGPoint glLocation = [[CCDirector sharedDirector] convertToGL:location];
	
    [gunSmoke setPosition:glLocation];
    
    //연기 애니메이션을 나타내는 smokeAnimate가 일어나지 않으면 gunSmoke가 smokeAnimate를 하지않게 합니다.
    if (![smokeAnimate isDone]) [gunSmoke stopAction:smokeAnimate];
    //gunSmoke가 smokeAnimate를 수행하게 합니다.
    [gunSmoke runAction:smokeAnimate];
    //사운드 효과를 재생한다.
    [[SimpleAudioEngine sharedEngine] playEffect:@"handgun_fire.wav"];
}

-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
}

@end
