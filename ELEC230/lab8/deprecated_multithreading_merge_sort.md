# a compilation-failed and bad-designed multithreading merge sort 
compilation error: Attempt to use a deleted function
```c++
template<typename Iter, typename Int>
requires std::is_integral_v<Int>
void
merge_sort(Iter first, Iter last, Int&& max_threads) {
    // base case: A list of zero or one element is sorted
    if (last - first <= 1)
        return;

    static std::mutex merge_sort_mutex;
    std::vector<thread> threads;
    Iter right = first + (last - first)/2;

    std::unique_lock<std::mutex> mutex(merge_sort_mutex);
    // divide and conquer (work toward base case)
    if (max_threads > 0)
        threads.push_back(thread(merge_sort<Iter, Int>, first, right, std::ref(--max_threads)));
    else
        merge_sort(first, right);
    if (max_threads > 0)
        threads.push_back(thread(merge_sort<Iter, Int>, right, last, std::ref(--max_threads)));
    else
        merge_sort(right, last);
    mutex.unlock();
    for (auto & thread : threads)
        thread.join();
OR
    synchronized {
        if (max_threads > 0)
            threads.push_back(thread(merge_sort, first, right, --max_threads));
        else
            merge_sort(first, right);
        if (max_threads > 0)
            threads.push_back(thread(merge_sort, right, last, --max_threads));
        else
            merge_sort(right, last);
    }
    for (auto & thread : threads)
        thread.join();

    // merge (combine the left sorted list with the right sorted list as per a sorting rule)
    while (first != right && right != last) {
        if (*right <= *first) {
            std::rotate(first, right, std::next(right));
            std::advance(right, 1);
        }
        std::advance(first, 1);
    }
}
```

### Answers on stackoverflow:
https://stackoverflow.com/questions/32560290/c-thread-with-a-recursive-function

https://stackoverflow.com/questions/28038859/multihreading-recursive-program-c

https://stackoverflow.com/questions/167018/should-i-use-threading-and-recursion-together

https://stackoverflow.com/questions/15047929/how-to-use-threads-with-a-recursive-template-function