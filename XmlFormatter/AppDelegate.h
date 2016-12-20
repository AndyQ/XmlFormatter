//
//  AppDelegate.h
//  XmlFormater
//
//  Created by Andy Qua on 30/01/2013.
//  Copyright (c) 2013 Andy Qua. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSButton *btnFormat;
@property (assign) IBOutlet NSTextView *textView;

- (IBAction)formatPressed:(id)sender;
@end
