//
//  ViewController.m
//  GCD
//
//  Created by He on 2018/3/16.
//  Copyright © 2018年 He. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    //GCD
//        //创建队列,参数1:队列唯一标示符,参数2:队列类型(串行或并发)
//            //串行
//    dispatch_queue_t queue1 = dispatch_queue_create("com.fjykt.testqueue1", DISPATCH_QUEUE_SERIAL);
//            //并发
//    dispatch_queue_t queue2 = dispatch_queue_create("com.fjykt.testqueque2", DISPATCH_QUEUE_CONCURRENT);
//        //获取主队列(串行队列)
//    dispatch_queue_t mainqueue = dispatch_get_main_queue();
//    //全局并发队列 参数1:优先级,参数二:暂时没用,写0
//    dispatch_queue_t gloal = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    //串行队列 添加同步任务 没有开启新线程,串行执行任务
//    dispatch_sync(queue1, ^{
//        for (int i = 0; i < 2; ++i) {
//            [NSThread sleepForTimeInterval:2];
//            NSLog(@"1--%@",[NSThread currentThread]);
//        }
//    });
//    dispatch_sync(queue1, ^{
//        for (int i = 0; i < 2; ++i) {
//            [NSThread sleepForTimeInterval:2];
//            NSLog(@"2--%@",[NSThread currentThread]);
//        }
//    });
//    //并发队列 添加同步任务 没有开启新线程,串行执行任务
//    dispatch_sync(queue2, ^{
//        for (int i = 0; i < 2; ++i) {
//            [NSThread sleepForTimeInterval:2];
//            NSLog(@"3--%@",[NSThread currentThread]);
//        }
//    });
//    dispatch_sync(queue2, ^{
//        for (int i = 0; i < 2; ++i) {
//            [NSThread sleepForTimeInterval:2];
//            NSLog(@"4--%@",[NSThread currentThread]);
//        }
//    });
//    //串行对列 添加异步任务 开启一条新线程,串行执行任务
//    dispatch_async(queue1, ^{
//        for (int i = 0; i < 2; ++i) {
//            [NSThread sleepForTimeInterval:2];
//            NSLog(@"5--%@",[NSThread currentThread]);
//        }
//    });
//    dispatch_async(queue1, ^{
//        for (int i = 0; i < 2; ++i) {
//            [NSThread sleepForTimeInterval:2];
//            NSLog(@"6--%@",[NSThread currentThread]);
//        }
//    });
//    //并发队列 添加异步任务 开启新线程 并发执行
//    dispatch_async(queue2, ^{
//        for (int i = 0; i < 2; ++i) {
//            [NSThread sleepForTimeInterval:2];
//            NSLog(@"7--%@",[NSThread currentThread]);
//        }
//    });
//    dispatch_async(queue2, ^{
//        for (int i = 0; i < 2; ++i) {
//            [NSThread sleepForTimeInterval:2];
//            NSLog(@"8--%@",[NSThread currentThread]);
//        }
//    });
//    //主线程 添加同步任务   死锁,卡住不执行
////    dispatch_sync(mainqueue, ^{
////        for (int i = 0; i < 2; ++i) {
////            [NSThread sleepForTimeInterval:2];
////            NSLog(@"9--%@",[NSThread currentThread]);
////        }
////    });
////    dispatch_sync(mainqueue, ^{
////        for (int i = 0; i < 2; ++i) {
////            [NSThread sleepForTimeInterval:2];
////            NSLog(@"10--%@",[NSThread currentThread]);
////        }
////    });
//
//    //主线程 添加异步任务  不开启新线程 串行执行
//    dispatch_async(mainqueue, ^{
//        for (int i = 0; i < 2; ++i) {
//            [NSThread sleepForTimeInterval:2];
//            NSLog(@"11--%@",[NSThread currentThread]);
//        }
//    });
//    dispatch_async(mainqueue, ^{
//        for (int i = 0; i < 2; ++i) {
//            [NSThread sleepForTimeInterval:2];
//            NSLog(@"12--%@",[NSThread currentThread]);
//        }
//    });
    
  //  [self communication];
  //  [self barrier];
   // [self apply];
    //[self after];
  //  [self groupNotify];
//     [self wait];
    [self enterAleave];
   // [self semaphoreSync];
   
    // Do any additional setup after loading the view, typically from a nib.
}
//GCD线程间的通信
- (void)communication {
    //获取全局并发队列
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(globalQueue, ^{
        // 异步追加任务
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"13---%@",[NSThread currentThread]);
        }
       // 回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            //追加在主线程中的任务
            [NSThread sleepForTimeInterval:2];
         NSLog(@"14---%@",[NSThread currentThread]);
        });
    });
}
//栅栏方法 实现异步执行完某组操作时,再执行另外一组操作
- (void)barrier {
    dispatch_queue_t queue = dispatch_queue_create("net.bujige.testQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"15---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"16---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    //栅栏
    dispatch_barrier_async(queue, ^{
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"栅栏---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"17---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"18---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    
}
//延迟操作
- (void)after {
    NSLog(@"%@",[NSThread currentThread]);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"延迟操作");
    });
}
//一次性代码(如单例)
- (void)once {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //只执行一次的操作
    });
}
//快速迭代(并发遍历)
- (void)apply {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    NSArray* array =[NSArray arrayWithObjects:@"1",@"2",@"3",nil];
    NSLog(@"开始遍历了");
    dispatch_apply(3, queue, ^(size_t index) {
        NSLog(@"%@",array[index]);
    });
    
}
//分组
- (void)groupNotify {
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"2---%@",[NSThread currentThread]);
        }
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"3---%@",[NSThread currentThread]);
        }
    });
}
- (void)wait {
    dispatch_group_t group =dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"1---%@",[NSThread currentThread]);
        }
    });
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"2---%@",[NSThread currentThread]);
        }
    });
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    NSLog(@"lalala");
}
//enter,leave
- (void)enterAleave {
    dispatch_group_t groud = dispatch_group_create();
    dispatch_queue_t global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_enter(groud);
    dispatch_async(global, ^{
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"1---%@",[NSThread currentThread]);
        }
        dispatch_group_leave(groud);
    });
    dispatch_group_enter(groud);
    dispatch_async(global, ^{
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"2---%@",[NSThread currentThread]);
        }
        dispatch_group_leave(groud);
    });
    dispatch_group_wait(groud, DISPATCH_TIME_FOREVER);
    NSLog(@"lalala");
}
//信号量
- (void)semaphoreSync {
    dispatch_queue_t global =  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    dispatch_async(global, ^{
        for (int i = 0; i < 3; ++i) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"1");
        }
    });
    dispatch_async(global, ^{
        for (int i = 0; i < 3; ++i) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"2");
            if (i == 2) {
                dispatch_semaphore_signal(sem);
            }
        }
    });
    dispatch_semaphore_wait(sem,DISPATCH_TIME_FOREVER);
    NSLog(@"收到信号,执行同步操作");
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
