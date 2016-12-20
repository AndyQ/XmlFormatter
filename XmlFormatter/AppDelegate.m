//
//  AppDelegate.m
//  XmlFormater
//
//  Created by Andy Qua on 30/01/2013.
//  Copyright (c) 2013 Andy Qua. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

- (IBAction)formatPressed:(id)sender
{
    NSString *text = _textView.string;
    NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
    
    // Format XML
    NSError *error = nil;
    NSXMLDocument *responseXML = [[NSXMLDocument alloc] initWithData:data options:NSXMLDocumentTidyXML error:&error];
    
    if (error ==  nil && responseXML != nil )
    {
        NSString *formattedText = [responseXML XMLStringWithOptions:NSXMLNodePrettyPrint];
        [_textView setString:[formattedText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        return;
    }

    NSLog(@"Error converting XML response : %@", error);
    
    
    // If we got here, XML Formatting failed - lets try JSON
    error = nil;
    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    if ( error == nil )
    {
        data = [NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingPrettyPrinted error:&error];
        if ( error == nil )
        {
            NSString *formattedText = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            [_textView setString:formattedText];
            return;
        }
    }
    
    NSLog(@"Error converting JSON response: %@", error);
    
    NSAlert *alert = [[NSAlert alloc] init];
    [alert addButtonWithTitle:@"OK"];
    [alert setMessageText:@"Failed to format"];
    [alert setInformativeText:@"Sorry, unable to format text as either XML or JSON."];
    [alert setAlertStyle:NSWarningAlertStyle];
    [alert beginSheetModalForWindow:_window modalDelegate:nil didEndSelector:nil contextInfo:nil];
    
}
@end
