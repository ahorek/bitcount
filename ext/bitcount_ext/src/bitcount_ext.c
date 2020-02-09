#include "bitcount_ext.h"
#include "helpers.c"

size_t ext_layout()
{
    return sizeof(size_t) * CHAR_BIT;
}

size_t ext_popcount(size_t x)
{
    if (sizeof(size_t) * CHAR_BIT == 64) {
        return ext_popcount64((uint64_t)x);
    }
    else if (sizeof(size_t) * CHAR_BIT == 32) {
        return ext_popcount32((uint32_t)x);
    }
    else {
        __builtin_unreachable();
    }
}

size_t ext_nlz(size_t x)
{
    if (sizeof(size_t) * CHAR_BIT == 32) {
        return nlz_int32((uint32_t)x);
    }
    else if (sizeof(size_t) * CHAR_BIT == 64) {
        return nlz_int64((uint64_t)x);
    }
    else {
        __builtin_unreachable();
    }
}

size_t ext_ntz(size_t x)
{
    if (sizeof(size_t) * CHAR_BIT == 64) {
        return ntz_int64((uint64_t)x);
    }
    else if (sizeof(size_t) * CHAR_BIT == 32) {
        return ntz_int32((uint32_t)x);
    }
    else {
        __builtin_unreachable();
    }
}