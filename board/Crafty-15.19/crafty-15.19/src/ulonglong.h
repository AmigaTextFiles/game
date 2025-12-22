/* Experimental class for compiling Crafty without the long long support */
/* The idea was to allow compilation with SAS/C and also to see if
 * if the log2N algorithm would make Crafty play faster
 */
/* Author: Dominique Lorre */

class ULONGLONG
{
public:
    unsigned long hi ;
    unsigned long lo ;
    ULONGLONG() { hi = lo = 0 ; }
    ULONGLONG(int n) { hi = 0 ; lo = n ; }
    ULONGLONG(unsigned long h, unsigned long l) : hi(h), lo(l) {}
    ULONGLONG operator<<(int n)
    {ULONGLONG r = *this ;
    unsigned long mask ;
        if (n > 31) {
            r.hi = r.lo ;
            r.lo = 0 ;
            r.hi <<= (n - 32) ;
        }
        else {
            r.hi <<= n ;
            mask = r.lo >> (32 - n );
            r.lo <<= n ;
            r.hi |= mask ;
        }
        return r ;
    }
    ULONGLONG operator>>(int n)
    {ULONGLONG r = *this ;
    unsigned long mask ;
        if (n > 31) {
            r.lo = r.hi ;
            r.hi = 0 ;
            r.lo >>= (n - 32) ;
        }
        else {
            r.lo >>= n ;
            mask = r.hi << (32 - n );
            r.hi >>= n ;
            r.lo |= mask ;
        }
        return r ;
    }
    friend ULONGLONG operator- (ULONGLONG a) {return ULONGLONG(-a.hi, -a.lo) ; }
    friend ULONGLONG operator- (ULONGLONG a, ULONGLONG b)
    {
        if (b > a)
            return ULONGLONG(0) ; // underflow
        else {
            if (b.lo <= a.lo)   // a.hi >= b.hi
                return (ULONGLONG(a.hi-b.hi, a.lo-b.lo)) ; // a>b => a.hi >= b.hi
            else  // a.hi > b.hi
                return (ULONGLONG(a.hi-b.hi-1, (0xFFFFFFFF - b.lo) + a.lo + 1)) ;

        }
    }
    friend ULONGLONG operator- (ULONGLONG a, int b)
    {
        return a - ULONGLONG(b) ;
    }

    friend ULONGLONG operator+ (ULONGLONG a, ULONGLONG b)
    {
        if ((a.lo & 0x80000000) || (b.lo & 0x80000000)) {
        unsigned long hisum, losum ;
            hisum = a.hi+b.hi ;
            losum = a.lo+b.lo ;
            if (a.lo & 0x80000000 && b.lo & 0x80000000) { // simple case
                return ULONGLONG(hisum+1, losum) ;
            }
            else  if (losum & 0x80000000) { // no carry
                return ULONGLONG(hisum, losum) ;
            }
            else {
                return ULONGLONG(hisum+1, losum) ;
            }
    }
    else
        return ULONGLONG(a.hi+b.hi, a.lo+b.lo) ;
    }
    friend ULONGLONG operator+ (ULONGLONG a, int b)
    {
        return a+ULONGLONG(b) ;
    }

    /* log2 N algorithm */

    friend ULONGLONG operator* (ULONGLONG a, ULONGLONG b)
    {
    ULONGLONG r = ULONGLONG(0,0) ;

        if (a == 0 || b == 0)
            return ULONGLONG(0) ;
        else {
            while (b != 0) {
                if (b.lo & 1) {
                    r = r + a ;
                }
                b = b >> 1 ;
                if (b != 0) a = a << 1 ;
            }
        }
        return r ;
    }
    friend ULONGLONG operator* (ULONGLONG a, int b)
    {
        return a * ULONGLONG(b) ;
    }

    /* This algorithm is slow but I do not remember the faster one */

    friend ULONGLONG operator/ (ULONGLONG a, ULONGLONG b)
    {
    ULONGLONG r = ULONGLONG(0,0) ;

        if (b == 0) return ULONGLONG(1 / 0) ;  // divide error
        while (a >= b) {
            a = a-b ;
            r++ ;
       }
        return r ;
    }
    friend ULONGLONG operator/ (ULONGLONG a, int b)
    {
        return a / ULONGLONG(b) ;
    }

    friend ULONGLONG operator& (ULONGLONG a, ULONGLONG b) {return ULONGLONG(a.hi&b.hi,a.lo&b.lo) ; }
    friend ULONGLONG operator& (ULONGLONG a, int n) {return ULONGLONG(0,a.lo&n) ; }

    friend ULONGLONG operator| (ULONGLONG a, ULONGLONG b) { return ULONGLONG(a.hi|b.hi, a.lo|b.lo) ;}

    friend ULONGLONG operator^ (ULONGLONG a, ULONGLONG b) { return ULONGLONG(a.hi^b.hi, a.lo^b.lo) ; }

    friend ULONGLONG operator~(ULONGLONG a) {return ULONGLONG(~a.hi,~a.lo) ;}

    void operator=(int n) { hi = 0 ; lo = n ; }

    friend int operator==(ULONGLONG a, int n) { return ((!a.hi) && (a.lo == n))  ; }
    friend int operator==(ULONGLONG a, ULONGLONG b) { return ((a.hi == b.hi)  && (a.lo == b.lo))  ; }
    friend int operator>(ULONGLONG a, ULONGLONG b) { return ((a.hi > b.hi)  || ((a.hi == b.hi) && (a.lo > b.lo)))  ; }
    friend int operator>=(ULONGLONG a, ULONGLONG b) { return ((a.hi > b.hi)  || ((a.hi == b.hi) && (a.lo >= b.lo)))  ; }
    friend int operator<(ULONGLONG a, ULONGLONG b) { return ((a.hi < b.hi)  || ((a.hi == b.hi) && (a.lo < b.lo)))  ; }

    friend int operator!=(ULONGLONG a, int n) { return (a.hi || a.lo != n)  ; }

    friend int operator!(ULONGLONG a) { return !(a.lo || a.hi) ; }

    friend int operator && (int n, ULONGLONG a) { return (n && (a.hi || a.lo)) ; }
    friend int operator && (ULONGLONG a, int n) { return (n && (a.hi || a.lo)) ; }
    friend int operator && (ULONGLONG a, ULONGLONG b) { return ((a.hi || a.lo) && (b.hi || b.lo)) ; }
    friend int operator || (int n, ULONGLONG a) { return (n || (a.hi || a.lo)) ; }
    friend int operator || (ULONGLONG a, ULONGLONG b) { return (b.hi || b.lo || (a.hi || a.lo)) ; }

    ULONGLONG operator++() { if (lo < 0xFFFFFFFF) lo++ ; else {hi++ ; lo = 0 ; } return *this ;  }
    ULONGLONG operator++(int) { ULONGLONG r = *this ; if (lo < 0xFFFFFFFF) lo++ ; else {hi++ ; lo = 0 ; } return r ;  }

    ULONGLONG operator--() { if (lo > 0) lo-- ; else {hi-- ; lo = 0xFFFFFFFF ; } return *this ;  }
    ULONGLONG operator--(int) { ULONGLONG r = *this ; if (lo > 0) lo-- ; else {hi-- ; lo = 0xFFFFFFFF ; } return r ;  }

    void operator &=(ULONGLONG a) {lo &= a.lo ; hi &= a.hi ;}
    void operator &=(int n) { lo &= n ; }

    void operator |=(ULONGLONG a) { hi |= a.hi ; lo |= a.lo ; }
    void operator |=(int n) { lo |= n ; }
    friend int cvint(ULONGLONG a) { return a.lo ; }
}  ;
