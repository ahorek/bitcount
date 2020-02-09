#include "bitcount_ext.h"
#include "helpers.c"

unsigned int ext_layout()
{
    return sizeof(uintptr_t) * CHAR_BIT;
}

unsigned int ext_popcount(uintptr_t x)
{
    if (sizeof(uintptr_t) * CHAR_BIT == 64) {
        return ext_popcount64((uint64_t)x);
    }
    else if (sizeof(uintptr_t) * CHAR_BIT == 32) {
        return ext_popcount32((uint32_t)x);
    }
    else {
        __builtin_unreachable();
    }
}

unsigned int ext_nlz(uintptr_t x)
{
    if (sizeof(uintptr_t) * CHAR_BIT == 32) {
        return nlz_int32((uint32_t)x);
    }
    else if (sizeof(uintptr_t) * CHAR_BIT == 64) {
        return nlz_int64((uint64_t)x);
    }
    else {
        __builtin_unreachable();
    }
}

unsigned int ext_ntz(uintptr_t x)
{
    if (sizeof(uintptr_t) * CHAR_BIT == 64) {
        return ntz_int64((uint64_t)x);
    }
    else if (sizeof(uintptr_t) * CHAR_BIT == 32) {
        return ntz_int32((uint32_t)x);
    }
    else {
        __builtin_unreachable();
    }
}