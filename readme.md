电子蒙特卡洛模拟，争取早日完成！

1 对抛物线型能带的修正存在问题，主要体现在：
（1）虽然从Gamma到X方向的能带计算值偏大，但对其他方向的结果是合理的，体现了该方法的优势；

2 根据能量选择波矢存在问题，主要体现在：


3 电子或声子波矢超出布里渊区后的修正存在问题，主要体现在：
（1）电子波矢的修正主要是由电场引起，思考有什么更好的方法实现？
（2）声子波矢的修正是很有必要的，因为是将色散曲线看作是各向同性的；

4 非抛物性参数应该对散射率有影响，暂时还没有考虑该问题？
（1）非抛物性能带计算的散射率要乘上一个系数；

5 程序本身的问题：
（1）电子或声子有一些参数（如波数）是自动计算的，在利用波数更改波矢时要注意添加（波数的）临时存储变量；
