https://stackoverflow.com/questions/2687392/is-it-possible-to-declare-two-variables-of-different-types-in-a-for-loop

https://stackoverflow.com/questions/38950008/using-string-literals-without-using-namespace-std

> ### Use the vector<T> func() Notation to Return Vector From a Function
> The return by value is the preferred method if we return a vector variable declared in the function. 
> The efficiency of this method comes from its move-semantics. 
> It means that returning a vector does not copy the object, thus avoiding wasting extra speed/space. 
> Under the hood, it points the pointer to the returned vector object, thus providing faster program execution time than copying the whole structure or class would have taken.

https://en.cppreference.com/w/cpp/language/transactional_memory

https://www.mersenneforum.org/showthread.php?t=18076

https://stackoverflow.com/questions/31064749/what-is-the-difference-between-stdtransform-and-stdfor-each/36060261

https://stackoverflow.com/questions/15017065/whats-the-difference-between-stdadvance-and-stdnext

https://www.doxygen.nl/manual/docblocks.html

https://codereview.stackexchange.com/questions/201534/merge-sort-implemented-using-iterators

https://en.cppreference.com/w/cpp/iterator

https://stackoverflow.com/questions/69541092/is-there-a-reason-to-use-stddistance-over-iteratoroperator

https://www.codeproject.com/articles/854127/top-beautiful-cplusplus-std-algorithms-examples

https://stackoverflow.com/questions/45487135/what-advantage-does-the-new-feature-synchronized-block-in-c-provide

https://stackoverflow.com/questions/41649381/atomic-execution-of-a-statement-block

> aotomic 原子的 即不能分割的，最小单位。\
> 举个例子，\
> int num; \
> num = num +1; \
> 我们都知道对于 num=num+1 这条程序语句需要分解为三步，\
> 1、把变量 num 读取到某一个寄存器 R 存储，\
> 2、CPU 对寄存器 R 的值进行计算，\
> 3、计算完成后将值存回内存 \
> 在多线程执行 num++ 的时候, 当前 num 为 1.
> 线程 A 执行完第二步, 此时 num 为 2 但是还没有存入内存，然后线程B开始执行第一步，从内存中取出 num，num 依旧是1.
> 这样就出现问题了，相当于 A 线程和 B 线程一共执行了连词 num=num+1，但是 num 却只增加了 1

> Atomic一词跟原子有点关系，后者曾被人认为是最小物质的单位。
> 计算机中的Atomic是指不能分割成若干部分的意思。
> 如果一段代码被认为是Atomic，则表示这段代码在执行过程中，是不能被中断的。
> 通常来说，原子指令由硬件提供，供软件来实现原子方法（某个线程进入该方法后，就不会被中断，直到其执行完成）

https://stackoverflow.com/questions/34288513/how-to-automatically-generate-function-headers-for-h-file-in-clion

["undefined reference to XXX" 问题总结](https://zhuanlan.zhihu.com/p/81681440)

[c++ 模板编程应该把实现放在头文件中吗，这样写会不会让头文件变得很难看？](https://www.zhihu.com/question/444534843)

https://stackoverflow.com/questions/495021/why-can-templates-only-be-implemented-in-the-header-file

> 有经验的程序猿知道我们 debug 时头文件中函数实现部分的修改会导致包含头文件的所有文件重新编译, 编译会耗时更长.
> 分开写的画就算在 debug 时我们改变函数内容, 也只会影响很少一部分.
