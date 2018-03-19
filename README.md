GCD总结<br/>
参考博客:https://www.jianshu.com/p/2d57c72016c6<br/>
包括以下内容:<br/>
一.队列与任务的创建.<br/>
二.六种组合:<br/>
![image](https://github.com/ChenYangGitfun/GCD/raw/master/GCD/6.png)<br/>
三.线程间的通信.<br/>
四.常用方法:<br/>
  1.栅栏 dispatch_barrier_async<br/>
  2.延迟 dispatch_after<br/>
  3.一次性代码 dispatch_once<br/>
  4.快速迭代 dispatch_apply<br/>
  5.队列组:<br/>
    1>dispatch_group_async 追加任务到队列,并添加该队列到队列组 <br/>
    2>dispatch_group_notify 监听队列组状态,当队列组中所有任务完成后追加该任务 <br/>
    3>dispatch_group_wait  与dispatch_group_notify类似<br/>
    4>dispatch_group_enter(队列组中未完成任务数+1)、dispatch_group_leave(队列组中未完成任务数-1),组合使用等同于dispatch_group_async<br/>
五:信号量(线程安全).<br/>
  1.dispatch_semaphore_t semaphore = dispatch_semaphore_create(0) 创建并初始化信号总量<br/>
  2.dispatch_semaphore_signal：发送一个信号，让信号总量加1<br/>
  3.dispatch_semaphore_wait：可以使总信号量减1，当信号总量为0时就会一直等待（阻塞所在线程），否则就可以正常执行。<br/>
