import Cycles "mo:base/ExperimentalCycles";
import HashMap "mo:base/HashMap";
import Principal "mo:base/Principal";

import Canister "Canister";

import Management "../src/Management"

shared ({caller = owner}) actor class Index() = this {
    private let managementCanister : Management.Interface = actor("aaaaa-aa");

    private let GB1 = 1073741824;
    private let GB2 = 2 * GB1;
    private let T1  = 1_000_000_000_000;

    private let canisterMap = HashMap.HashMap<Principal, Nat>(
        10, Principal.equal, Principal.hash,
    );

    public shared({caller}) func createCanister() : async Principal {
        let can = await newCanister();
        Principal.fromActor(can);
    };

    private func newCanister() : async Canister.Canister {
        Cycles.add(T1);
        let can   = await Canister.Canister();
        let canId = Principal.fromActor(can);
        await managementCanister.update_settings({
            canister_id = canId;
            settings    = {
                freezing_threshold = null;
                controllers        = ?[
                    owner,
                    Principal.fromActor(this),
                ];
                memory_allocation  = null;
                compute_allocation = null;
            };
        });
        let size = await can.getSize();
        canisterMap.put(Principal.fromActor(can), GB2 - size : Nat);
        can;
    };
};
