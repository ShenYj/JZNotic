//
//  ViewController.m
//  JZNotic
//
//  Created by Jozo.Chan on 16/11/2.
//  Copyright © 2016年 i.Jozo. All rights reserved.
//

#import "ViewController.h"
#import "JZUserNotification.h"
#import "DownloadManager.h"
#import <AVFoundation/AVFoundation.h>
@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIProgressView *progress;
@property (nonatomic, copy) NSArray *sectionTitles;
@property (nonatomic, copy) NSArray *datas;

@end

@implementation ViewController
{
    AVPlayer *player;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    __weak typeof(self) weakSelf = self;
    [[DownloadManager sharedInstance] setProgressBlock:^(float persent) {
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.progress.progress = persent;
        });
    }];
    
    self.sectionTitles = @[
                           @"Local Notification",
                           @"Category",
                           @"Remote Notification",
                           @"附件"
                           ];
    
    self.datas = @[
                   @[
                       @"时间戳定时推送",
                       @"周期性定时推送",
                       @"指定位置推送"
                       ],
                   @[
                       @"设置categories",
                       @"推送category样式一",
                       @"推送category样式二",
                       @"推送category样式三带文本输入"
                       ],
                   @[
                       @"远程推送-普通",
                       @"远程推送-普通下载",
                       @"远程推送-静默下载"
                       ],
                   @[
                       @"附件-图片",
                       @"附件-图片-GIF",
                       @"附件-音频",
                       @"附件-视频",
                       @"自定义1",
                       @"自定义2"
                       ]
                   ];
    
    self.navigationItem.rightBarButtonItems = @[
                                                [[UIBarButtonItem alloc] initWithTitle:@"崩" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonAction:)],
                                                [[UIBarButtonItem alloc] initWithTitle:@"stop" style:UIBarButtonItemStylePlain target:self action:@selector(stopAction:)],
                                                [[UIBarButtonItem alloc] initWithTitle:@"pause" style:UIBarButtonItemStylePlain target:self action:@selector(pauseAction:)],
                                                [[UIBarButtonItem alloc] initWithTitle:@"start" style:UIBarButtonItemStylePlain target:self action:@selector(startAction:)]
                                                ];

}

#pragma mark - Action

- (void)stopAction:(UIBarButtonItem *)item
{
    [[DownloadManager sharedInstance] stop];
}

- (void)pauseAction:(UIBarButtonItem *)item
{
    [[DownloadManager sharedInstance] pause];
}

- (void)startAction:(UIBarButtonItem *)item
{
    [[DownloadManager sharedInstance] start];
}

- (void)rightBarButtonAction:(UIBarButtonItem *)item
{
    NSArray *a = @[];
    [a objectAtIndex:1];
}

#pragma mark - Delegate
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.datas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.datas objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = self.datas[indexPath.section][indexPath.row];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.sectionTitles[section];
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        
        switch (indexPath.row) {
            case 0:
            {
                [[JZUserNotification sharedNotification] addNotificationWithTimeIntervalTrigger];
            }
                break;
            case 1:
            {
                [[JZUserNotification sharedNotification] addNotificationWithCalendarTrigger];
            }
                break;
            case 2:
            {
                
                [[JZUserNotification sharedNotification] addNotificationWithLocationTrigger];
                
            }
                break;
            default:
                break;
        }
        
    }else if (indexPath.section == 1){
        
        switch (indexPath.row) {
            case 0:
            {
                [[JZUserNotification sharedNotification] setCategories];
            }
                break;
            case 1:
            {
                [[JZUserNotification sharedNotification] addNotificationWithCategroy1];
            }
                break;
            case 2:
            {
                [[JZUserNotification sharedNotification] addNotificationWithCategroy2];
            }
                break;
            case 3:
            {
                [[JZUserNotification sharedNotification] addNotificationWithCategroy3];
            }
                break;
            default:
                break;
        }
        
    }else if (indexPath.section == 2){
        
        switch (indexPath.row) {
            case 0:
            {
                
            }
                break;
            case 1:
            {
                
            }
                break;
            case 2:
            {
                
            }
                break;
                
            default:
                break;
        }
        
    }else{
        
        switch (indexPath.row) {
            case 0:
            {
                [[JZUserNotification sharedNotification] addNotificationWithAttachmentType:AttachmentTypeImage];
            }
                break;
            case 1:
            {
                [[JZUserNotification sharedNotification] addNotificationWithAttachmentType:AttachmentTypeImageGif];
            }
                break;
            case 2:
            {
                [[JZUserNotification sharedNotification] addNotificationWithAttachmentType:AttachmentTypeAudio];
            }
                break;
            case 3:
            {
                [[JZUserNotification sharedNotification] addNotificationWithAttachmentType:AttachmentTypeMovie];
            }
                break;
            case 4:
            {
                [[JZUserNotification sharedNotification] addNotificationWithUserDefined1];
            }
                break;
            case 5:
            {
                [[JZUserNotification sharedNotification] addNotificationWithUserDefined2];
            }
                break;
            default:
                break;
        }
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

