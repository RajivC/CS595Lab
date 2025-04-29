use std::hash::pedersen_hash;

global DEPTH: u32 = 8;

fn main(
    r: Field,
    index: Field,
    hashpath: [Field; DEPTH],

    root: pub Field,
    id:   pub Field
) {
    // 1) Recompute the commitment
    let commitment = pedersen_hash([id, r]);

    // 2) Walk the Merkle path assuming all pathIndices == false
    let mut cur = commitment;
    for i in 0..DEPTH {
        cur = pedersen_hash([cur, hashpath[i]]);
    }
    assert(cur == root);
}