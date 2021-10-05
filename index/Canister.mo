import Cycles "mo:base/ExperimentalCycles";
import Prim "mo:⛔";

actor class Canister() = this {
    public query func getSize() : async Nat {
        Prim.rts_memory_size();
    };

    public query func getCycleBalance() : async Nat {
        Cycles.balance();
    };

    public query func wallet_balance() : async Nat {
        Cycles.balance();
    };

    public shared func wallet_receive() : async Nat {
        Cycles.accept(Cycles.available());
    };
};
