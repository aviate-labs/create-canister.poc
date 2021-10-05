module {
    public type Interface = actor {
        getCycleBalance : query (p : Principal) -> async (query () -> async Nat);
    };
};
