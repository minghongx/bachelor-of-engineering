#ifndef LAB8_SORTING_ALGORITHMS_HPP
#define LAB8_SORTING_ALGORITHMS_HPP

#include <algorithm>
#include <ranges>  // todo: constraint template

namespace sort {

    template<typename FwdIter, typename Compare = std::less<>>
    void
    quicksort(FwdIter first, FwdIter last, Compare cmp = Compare{}) {
        auto const N = std::distance(first, last);
        if (N <= 1)
            return;
        auto const pivot = std::next(first, N/2);
        std::nth_element(first, pivot, last, cmp);
        quicksort(first, pivot, cmp);
        quicksort(pivot, last, cmp);
    }

    template<typename Iter>
    void
    inplace_merge(Iter first, Iter middle, Iter last) {
        while (first != middle && middle != last) {
            if (*middle <= *first) {
                std::rotate(first, middle, std::next(middle));
                std::advance(middle, 1);
            }
            std::advance(first, 1);
        }
    }

    //! ForwardIterators would technically work for merge sort, but RandomAccessIterators are preferred.
    //! highly parallelizable using the Hungarian method
    template<typename Iter>  // todo: shrink the arg list by one std::ranges::range
    void
    merge_sort(Iter first, Iter last) {
        // recursive case
        if (auto size = std::distance(first, last); size > 1) {
            Iter middle = first + size/2;
            // divide and conquer (work toward base case)
            merge_sort(first, middle);
            merge_sort(middle, last);
            // merge (combine the left sorted list with the middle sorted list as per a sorting rule)
            std::inplace_merge(first, middle, last);  // if there is enough cache space, then use the space to calculate. If not, calculate on the existing space
        }
        // base case: A list of zero or one element is sorted
    }

    void
    introsort() {}

    void
    heapsort() {}

    template <typename Iter>
    void
    insertion_sort(Iter first, Iter last) {
        for (auto i = first; i != last ; ++i)
            std::rotate(std::upper_bound(first, i, *i), i, std::next(i));
    }

    void
    bubble_sort() {}
}

#endif //LAB8_SORTING_ALGORITHMS_HPP
