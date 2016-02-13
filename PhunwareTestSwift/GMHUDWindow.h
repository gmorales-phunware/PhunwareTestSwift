//
//  GMHUDWindow.h
//  Hipster
//
//  Created by Rockstar. on 8/20/14.
//  Copyright (c) 2014 Bnei Baruch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GMHUDWindow : UIWindow

@property (nonatomic, assign) BOOL hidesVignette;

+ (GMHUDWindow *)defaultWindow;

@end
