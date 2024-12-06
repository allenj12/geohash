#!chezscheme
(library (rpn-extended-base)
  (export split
          rsplit
          2dup
          3dup
          4dup
          dup2
          dup3
          dup4
          4rot
          5rot
          6rot
          7rot
          8rot
          9rot
          4rrot
          5rrot
          6rrot
          7rrot
          8rrot
          9rrot
          nip
          2nip
          nip3
          nip4
          nip5
          trim
          1rif
          2rif
          3rif
          4rif
          5rif
          6rif
          1pand
          2pand
          3pand
          4pand
          1por
          2por
          3por
          4por
          1u1
          1u2
          1u3
          1u4
          2u1
          2u2
          2u3
          2u4
          3u1
          3u2
          3u3
          3u4
          4u1
          4u2
          4u3
          4u4
          1k1
          1k2
          1k3
          1k4
          2k1
          2k2
          2k3
          2k4
          3k1
          3k2
          3k3
          3k4
          4k1
          4k2
          4k3
          4k4)
  (import (chezscheme)
          (rpn))

(: split dup {1 cdr} swap {1 car})
(: rsplit dup {1 car} swap {1 cdr})

(: 2dup over over)
(: 3dup {3 6} double)
(: 4dup {4 8} double)

(: 4rot {4 4 rot})
(: 5rot {5 5 rot})
(: 6rot {6 6 rot})
(: 7rot {7 7 rot})
(: 8rot {8 8 rot})
(: 9rot {9 9 rot})

(: 4rrot {4 4 rrot})
(: 5rrot {5 5 rrot})
(: 6rrot {6 6 rrot})
(: 7rrot {7 7 rrot})
(: 8rrot {8 8 rrot})
(: 9rrot {9 9 rrot})

(: dup2 over swap)
(: dup3 rot dup 4rrot 4rrot)
(: dup4 4rot dup 5rrot 5rrot)

(: nip swap drop)
(: 2nip rot drop rot drop)
(: nip3 rot drop)
(: nip4 {4 4 rot} drop)
(: nip5 {5 5 rot} drop)

(: trim drop swap drop)

(: 1rif {4 rif})
(: 2rif {5 rif})
(: 3rif {6 rif})
(: 4rif {7 rif})
(: 5rif {8 rif})
(: 6rif {9 rif})

(: 1pand
    ({1 1} drop #f)
    1rif)

(: 2pand
    ({2 1} #f skim)
    2rif)

(: 3pand
    ({3 1} #f skim)
    3rif)
    
(: 4pand
    ({4 1} #f skim)
    4rif)

(: 1por swap dup
    ({2 1} swap skim) curry
    rot
    1rif)

(: 2por swap dup
    ({3 1} rot skim) curry
    rot
    2rif)
    
(: 3por swap dup
    ({4 1} 4rot skim) curry
    rot
    3rif)

(: 4por swap dup
    ({5 1} 5rot skim) curry
    rot
    4rif)
    
(: 1u1 {3 2} swap to-bot {2 ev} to-top)
(: 1u2 {3 3} swap to-bot {2 2 ev} to-top)
(: 1u3 {3 4} swap to-bot {2 3 ev} to-top)
(: 1u4 {3 5} swap to-bot {2 4 ev} to-top)

(: 2u1 {4 2} swap to-bot {3 ev} to-top)
(: 2u2 {4 3} swap to-bot {3 2 ev} to-top)
(: 2u3 {4 4} swap to-bot {3 3 ev} to-top)
(: 2u4 {4 5} swap to-bot {3 4 ev} to-top)

(: 3u1 {5 2} swap to-bot {4 ev} to-top)
(: 3u2 {5 3} swap to-bot {4 2 ev} to-top)
(: 3u3 {5 4} swap to-bot {4 3 ev} to-top)
(: 3u4 {5 5} swap to-bot {4 4 ev} to-top)

(: 4u1 {6 2} swap to-bot {5 ev} to-top)
(: 4u2 {6 3} swap to-bot {5 2 ev} to-top)
(: 4u3 {6 4} swap to-bot {5 3 ev} to-top)
(: 4u4 {6 5} swap to-bot {5 4 ev} to-top)

(: 1k1 {2 2} over to-bot {2 ev} to-top)
(: 1k2 {2 3} over to-bot {2 2 ev} to-top)
(: 1k3 {2 4} over to-bot {2 3 ev} to-top)
(: 1k4 {2 5} over to-bot {2 4 ev} to-top)

(: 2k1 {3 2} over to-bot {3 ev} to-top)
(: 2k2 {3 3} over to-bot {3 2 ev} to-top)
(: 2k3 {3 4} over to-bot {3 3 ev} to-top)
(: 2k4 {3 5} over to-bot {3 4 ev} to-top)

(: 3k1 {4 2} over to-bot {4 ev} to-top)
(: 3k2 {4 3} over to-bot {4 2 ev} to-top)
(: 3k3 {4 4} over to-bot {4 3 ev} to-top)
(: 3k4 {4 5} over to-bot {4 4 ev} to-top)

(: 4k1 {5 2} over to-bot {5 ev} to-top)
(: 4k2 {5 3} over to-bot {5 2 ev} to-top)
(: 4k3 {5 4} over to-bot {5 3 ev} to-top)
(: 4k4 {5 5} over to-bot {5 4 ev} to-top))
