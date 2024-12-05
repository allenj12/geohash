#!chezscheme
(library (geohash)
  (export encode-int-prec
          neighbors
          decode
          bin-hash
          shift-right)
  (import (chezscheme) 
          (rpn)
          (rpn-extended-base)
          (rpn-iter))

(: shift-right (2 / {1 floor}) swap repeat1)

(: squash #x5555555555555555 {2 logand} dup
          1  shift-right {2 logor} #x3333333333333333 {2 logand} dup
          2  shift-right {2 logor} #x0f0f0f0f0f0f0f0f {2 logand} dup
          4  shift-right {2 logor} #x00ff00ff00ff00ff {2 logand} dup
          8  shift-right {2 logor} #x0000ffff0000ffff {2 logand} dup
          16 shift-right {2 logor} #x00000000ffffffff {2 logand})

(: spread dup 16 {2 ash} {2 logor} #x0000ffff0000ffff {2 logand} dup
          8 {2 ash} {2 logor} #x00ff00ff00ff00ff {2 logand} dup
          4 {2 ash} {2 logor} #x0f0f0f0f0f0f0f0f {2 logand} dup
          2 {2 ash} {2 logor} #x3333333333333333 {2 logand} dup
          1 {2 ash} {2 logor} #x5555555555555555 {2 logand})

(: interleave (spread) 1u1 spread 1 {2 ash} {2 logor})

(: deinterleave (squash) 1k1 1 shift-right squash)

(: encode-range (+) 2k1 2 * / 2 32 expt * {1 flonum->fixnum})

(: decode-range (swap {1 fixnum->flonum} 2 32 expt / 2 {3 *}) 2k1 -)

(: encode-int-prec ((90 encode-range) 1u1 180 encode-range interleave) 2u1 64 swap - shift-right)

(: decode deinterleave (90 decode-range) 1u1 180 decode-range)

(: ldexp 2 swap expt *)

(: errorwithbit dup / 2 tuck ((180.0 swap -1 * ldexp) 1u1) 2u2 360.0 rot - -1 * ldexp)

(: center + 2 / (+ 2 /) 2u1)

(: bbox (64 swap - {2 ash} decode) 2k2 errorwithbit rot (+) 2k1 swap ((swap (+) 2k1 swap) 2u2) 3u3)

(: bin-hash encode-int-prec {1 exact->inexact} {1 exact} 2 {2 number->string})

(define neighbors
  (lambda (hash bits)
    (let-values ([(lat-delta lng-delta lat lng) 
                  (rpnv hash bits bbox
                        4dup center 6rrot 6rrot
                        swap - 5rrot
                        swap - 4rrot)])
           (rpn hash
                lat lat-delta + lng             bits encode-int-prec
                lat lat-delta + lng lng-delta + bits encode-int-prec
                lat             lng lng-delta + bits encode-int-prec
                lat lat-delta - lng lng-delta + bits encode-int-prec
                lat lat-delta - lng             bits encode-int-prec
                lat lat-delta - lng lng-delta - bits encode-int-prec
                lat             lng lng-delta - bits encode-int-prec
                lat lat-delta + lng lng-delta - bits encode-int-prec
                {9 list})))))