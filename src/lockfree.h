// Copyright 2022 The Forgotten Server Authors. All rights reserved.
// Use of this source code is governed by the GPL-2.0 License that can be found in the LICENSE file.

#ifndef FS_LOCKFREE_H
#define FS_LOCKFREE_H

#if _MSC_FULL_VER >= 190023918 // Workaround for VS2015 Update 2. Boost.Lockfree is a header-only library, so this should be safe to do.
#define _ENABLE_ATOMIC_ALIGNMENT_FIX
#endif

/*
 * we use this to avoid instantiating multiple free lists for objects of the
 * same size and it can be replaced by a variable template in C++14
 *
 * template <std::size_t TSize, size_t CAPACITY>
 * boost::lockfree::stack<void*, boost::lockfree::capacity<CAPACITY> lockfreeFreeList;
 */
template <std::size_t TSize, size_t CAPACITY>
struct LockfreeFreeList
{
	using FreeList = boost::lockfree::stack<void*, boost::lockfree::capacity<CAPACITY>>;
	static FreeList& get()
	{
		static FreeList freeList;
		return freeList;
	}
};

template <typename T, size_t CAPACITY>
class LockfreePoolingAllocator : public std::allocator<T>
{
	public:
		LockfreePoolingAllocator() = default;

		template <typename U, class = typename std::enable_if<!std::is_same<U, T>::value>::type>
		explicit constexpr LockfreePoolingAllocator(const U&) {}
		using value_type = T;

		T* allocate(size_t) const {
			auto& inst = LockfreeFreeList<sizeof(T), CAPACITY>::get();
			void* p; // NOTE: p doesn't have to be initialized
			if (!inst.pop(p)) {
				//Acquire memory without calling the constructor of T
				p = operator new (sizeof(T));
			}
			return static_cast<T*>(p);
		}

		void deallocate(T* p, size_t) const {
			auto& inst = LockfreeFreeList<sizeof(T), CAPACITY>::get();
			if (!inst.bounded_push(p)) {
				//Release memory without calling the destructor of T
				//(it has already been called at this point)
				operator delete(p);
			}
		}
};

#endif
