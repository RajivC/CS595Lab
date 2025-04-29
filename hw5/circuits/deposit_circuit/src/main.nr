use std::hash::pedersen_hash;

global DEPTH: u32 = 8;
global EMPTY_LEAF: Field =
    11237804666762892337261927141475050497255385386905029870942060923073236745571;

fn main(
    id: Field,
    r: Field,
    oldPath: [Field; DEPTH],

    oldRoot: pub Field,
    newRoot: pub Field,
    commitment: pub Field,
    index: pub Field
) {
 
    assert(pedersen_hash([id, r]) == commitment);

   
    let mut cur = EMPTY_LEAF;
    for i in 0..DEPTH {
        cur = pedersen_hash([cur, oldPath[i]]);
    }
    assert(cur == oldRoot);

   
    let mut cur2 = commitment;
    for i in 0..DEPTH {
        cur2 = pedersen_hash([cur2, oldPath[i]]);
    }
    assert(cur2 == newRoot);
}