MINI版matlab，无须安装，解压即用。MINI版matlab.exe启动时不检查C盘序列号. 在启动时不加载java窗口框架，去掉了不常用的toolbox和用不到的dll. 所以这个版本是个最小依赖度的Matlab,没有simulink,也没有medit.但保留了plot和figure的zoom功能. 如果自己还有啥需要用的toolbox函数，就的自己往目录里加了。两个文件，共6M多，解压后大概20M多点。
由于不加载java窗口框架,没有simulink,也没有medit，大大减少了内存的消耗，但也带来了一些不便。
下面简单介绍MINI版matlab的使用。



没有medit，这时.m文件只能用记事本编辑，存到work目录下。
如work目录已有的test.m
可在命令窗口执行test命令调用已有的test函数。

可自己添加函数和工具箱，setpath不能用，如果要新添路径需要到\toolbox\local\pathdef.m中手动添加。

如果matlab.exe不能正常启动，请双击bin目录下的matlab.exe或matlab.bat。

MINI版在只需使用简单功能时可节省内存，提高速度。
如需解决复杂的问题，建议使用全功能版。


小提示：在使用全功能版时在开始-->运行输入matlab.exe -nojvm启动程序，将不加载java窗口框架，可以减少内存的消耗，加快速度。

可自己添加函数和工具箱，setpath不能用，如果要新添路径需要到\toolbox\local\pathdef.m中手动添加。
- 自定义函数放在myfun目录中。
- 数字结尾的m文件，都为学习示例。
