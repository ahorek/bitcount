unsigned int ext_popcount64(uint64_t x)
{
#if __has_builtin(__builtin_popcount)
    if (sizeof(long) * CHAR_BIT == 64) {
        return (unsigned int)__builtin_popcountl((unsigned long)x);
    }
    else if (sizeof(long long) * CHAR_BIT == 64) {
        return (unsigned int)__builtin_popcountll((unsigned long long)x);
    }
    else {
        __builtin_unreachable();
    }
#else
    x = (x & 0x5555555555555555) + (x >> 1 & 0x5555555555555555);
    x = (x & 0x3333333333333333) + (x >> 2 & 0x3333333333333333);
    x = (x & 0x0707070707070707) + (x >> 4 & 0x0707070707070707);
    x = (x & 0x001f001f001f001f) + (x >> 8 & 0x001f001f001f001f);
    x = (x & 0x0000003f0000003f) + (x >>16 & 0x0000003f0000003f);
    x = (x & 0x000000000000007f) + (x >>32 & 0x000000000000007f);
    return (unsigned int)x;

#endif
}

unsigned int ext_popcount32(uint32_t x)
{
#if __has_builtin(__builtin_popcount)
    return (unsigned int)__builtin_popcount(x);

#else
    x = (x & 0x55555555) + (x >> 1 & 0x55555555);
    x = (x & 0x33333333) + (x >> 2 & 0x33333333);
    x = (x & 0x0f0f0f0f) + (x >> 4 & 0x0f0f0f0f);
    x = (x & 0x001f001f) + (x >> 8 & 0x001f001f);
    x = (x & 0x0000003f) + (x >>16 & 0x0000003f);
    return (unsigned int)x;
#endif
}

unsigned int nlz_int32(uint32_t x)
{
#if __has_builtin(__builtin_clz)
    return (unsigned int)__builtin_clz(x);

#else
    uint32_t y;
    unsigned n = 32;
    y = x >> 16; if (y) {n -= 16; x = y;}
    y = x >>  8; if (y) {n -=  8; x = y;}
    y = x >>  4; if (y) {n -=  4; x = y;}
    y = x >>  2; if (y) {n -=  2; x = y;}
    y = x >>  1; if (y) {return n - 2;}
    return (unsigned int)(n - x);
#endif
}

unsigned int nlz_int64(uint64_t x)
{
#if __has_builtin(__builtin_clzl)
    if (x == 0) {
        return 64;
    }
    else if (sizeof(long) * CHAR_BIT == 64) {
        return (unsigned int)__builtin_clzl((unsigned long)x);
    }
    else if (sizeof(long long) * CHAR_BIT == 64) {
        return (unsigned int)__builtin_clzll((unsigned long long)x);
    }
    else {
        __builtin_unreachable();
    }

#else
    uint64_t y;
    unsigned int n = 64;
    y = x >> 32; if (y) {n -= 32; x = y;}
    y = x >> 16; if (y) {n -= 16; x = y;}
    y = x >>  8; if (y) {n -=  8; x = y;}
    y = x >>  4; if (y) {n -=  4; x = y;}
    y = x >>  2; if (y) {n -=  2; x = y;}
    y = x >>  1; if (y) {return n - 2;}
    return (unsigned int)(n - x);

#endif
}

unsigned int ntz_int32(uint32_t x)
{
#if __has_builtin(__builtin_ctz)
    return (unsigned)__builtin_ctz(x);
#else
    return ext_popcount32((~x) & (x-1));
#endif
}

unsigned int ntz_int64(uint64_t x)
{
#if __has_builtin(__builtin_ctzl)
    if (x == 0) {
        return 64;
    }
    else if (sizeof(long) * CHAR_BIT == 64) {
        return (unsigned)__builtin_ctzl((unsigned long)x);
    }
    else if (sizeof(long long) * CHAR_BIT == 64) {
        return (unsigned)__builtin_ctzll((unsigned long long)x);
    }
    else {
        __builtin_unreachable();
    }
#else
    return ext_popcount64((~x) & (x-1));
#endif
}
