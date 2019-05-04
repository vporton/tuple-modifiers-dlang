module tuple_modifiers;

import std.meta : staticMap;

/**
Add modifiers `modifiers` to each element of tuple `T`.

Example:
```
alias t = AliasSeq!(int, float);
alias tc = addTupleModifiers!("const shared", t);
static assert(is(tc[1] == const shared float));```
*/
template addTupleModifiers(string modifiers, T...) {
    private template addModifier(T1) {
        mixin("alias addModifier = " ~ modifiers ~ ' ' ~ T1.stringof ~ ';');
    }

    alias addTupleModifiers = staticMap!(addModifier, T);
}

unittest {
    import std.meta;

    alias t = AliasSeq!(int, float);
    //alias tc = const(t); // does not work in DMD v2.085.1
    alias tc = addTupleModifiers!("const", t);
    static assert(is(tc[1] == const float));
}
