//
//  HelloWorldLayer.h
//  SoundEffect
//
//  Created by EUNJI KIM on 13. 6. 25..
//  Copyright __MyCompanyName__ 2013년. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "cocos2d.h"
//그리고 SimpleAudioEngine을 사용하기 위해서 아래와 같이 헤더 파일을 임포트합니다.
#import "SimpleAudioEngine.h"

@interface GameLayer : CCLayer {
    CCAnimate *sitAnimate; //CCAnimate형의 sitAnimate 전역변수 선언
    CCAnimate *smokeAnimate; //CCAnimate형의 smokeAnimate 전역변수 선언
    CCSprite *gunSmoke; //CCSprite형의 gunSmoke 전역변수 선언
}
+(CCScene *) scene;
@end
