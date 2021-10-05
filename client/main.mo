import Principal "mo:base/Principal";

import Index "../index/Interface";

actor class Client(indexCanister : Principal) = {
    let index : Index.Interface = actor(Principal.toText(indexCanister));

    public func getCycleBalance(p : Principal) : async Nat {
        let f = await index.getCycleBalance(p);
        await f();
    };
};
