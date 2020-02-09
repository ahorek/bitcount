#include <limits.h>
#include <stdint.h>

#ifndef GCC_VERSION_SINCE
# if defined(__GNUC__) && !defined(__INTEL_COMPILER) && !defined(__clang__)
#  define GCC_VERSION_SINCE(major, minor, patchlevel) \
    ((__GNUC__ > (major)) ||  \
     ((__GNUC__ == (major) && \
       ((__GNUC_MINOR__ > (minor)) || \
        (__GNUC_MINOR__ == (minor) && __GNUC_PATCHLEVEL__ >= (patchlevel))))))
# else
#  define GCC_VERSION_SINCE(major, minor, patchlevel) 0
# endif
#endif

#ifndef __has_builtin
  #if GCC_VERSION_SINCE(4, 8, 0)
    # define __has_builtin(x) 1
  # else
    # define __has_builtin(x) 0
  #endif
#endif

size_t ext_layout();
size_t ext_popcount(size_t x);
size_t ext_nlz(size_t x);
size_t ext_ntz(size_t x);