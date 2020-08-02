# 经典游戏复现 打砖块 2020年新工科联盟-Xilinx暑期学校(Summer School)项目
本项目是对经典游戏打砖块(Breakout)的复现，用户将开发板连接至显示器后，即可通过开发板自带按键操作游戏界面。
游戏共有三个操作按键——发射键(Launch)，即重置键FPGA_RST，I/O引脚为D14；左移键，即用户自定义按键USER1，I/O引脚为C3；右移键，即用户自定义按键USER2，I/O引脚为M4. 
游戏界面共有四种物体——左右边界的墙面、复数的砖块、可反弹的球、受按键控制的板。
游戏画面为彩色，用简单色块描述物体，分辨率为1920*1080，刷新率为60Hz。
	本项目的技术难点在于HDMI实时视频流输出的配置与调试：对于本项目的视频输出，FPGA在每帧需扫描行总长度*场总长度（总长度=有效长度+同步长度+同步前肩长度+同步后肩长度）个像素点，即时钟的频率应为2200*1125*60=148.5MHz；对扫描后的TMDS输出，则需148.5*5=742.5MHz的时钟，这样的时钟给调试带来了一定的困难，现有的时序设计无法与系统综合结果相吻合。
	我组实现本设计的目的是，通过开发基于FPGA的经典游戏，感受FPGA强大的可定制能力与迅猛的性能，了解FPGA外设与拓展之丰富，理解硬件描述语言与程序设计语言的异同；
  本设计的应用场景是是让广大玩家了解FPGA、认识FPGA开发的无限前景，同时本设计具有一定的娱乐效果。
工具版本、板卡型号与外设列表：
  1. 开发软件 Vivado 2018.3 
  2. 开发语言 Verilog
  3. 板卡型号 Spartan-7 XC7S15
  4. 项目设备 xc7s15ftgb196-1
  5. ip核 RGB to DVI Video Encoder, Clocking Wizard
  6. 外设：带有HDMI-IN的显示器、电视即可。分辨率1920*1080*60Hz
  
  
 项目开发人员：
  西南交通大学A3班 2018112787 - Team leader & coding
  
  西南交通大学A3班 2018112739 - Team manager & debugging
  
 仓库目录介绍：
 
    1. 源代码(Sourcecode\breakout.srcs\sources_1\new)
       1.1 ball_control.v   ball
       1.2 board_control.v   board
       1.3 brick_control.v   brick
       1.4 Driver_HDMI.v    Vga_R,Vga_G,Vga_B to [23:0]RGB_data
       1.5 game_control.v   top entity
       1.6 turn2rgb.v  R,G,B generator
       
    2. 约束文件(Sourcecode\breakout.srcs\constrs_1\imports\vivadoprojects\system.xdc)
        适用于xc7s15ftgb196-1
	
    3. ip核(Sourcecode\breakout.srcs\new\sources_1\ip)
       3.1 clk_wiz_0 100MHz in   148.5MHz & 742.5MHz out
       3.2 rgb2dvi_0 1080P-60Hz [23:0] RGB_data in
       
    4. bit文件(ExecutableFiles\game_control.bit)
    
    5. 工程(breakout.zip)
