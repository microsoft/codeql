private import TAst
private import Ast
private import Location
private import Variable

newtype SynthKind =
  ParameterSynthKind() or
  LocalVariableAccessRealKind(LocalVariableReal v) or
  LocalVariableAccessSynthKind(TLocalVariableSynth v)

newtype Child =
  SynthChild(SynthKind kind) or
  RealChildRef(TAstReal n) or
  SynthChildRef(TAstSynth n)

pragma[inline]
private Child childRef(TAst n) {
  result = RealChildRef(n)
  or
  result = SynthChildRef(n)
}

private newtype TSynthesis = MkSynthesis()

class Synthesis extends TSynthesis {
  predicate child(Ast parent, int i, Child child) { none() }

  predicate location(Ast n, Location l) { none() }

  predicate localVariable(Ast n, int i) { none() }

  final string toString() { none() }
}

private module ParameterSynth {
  private import Raw.ScriptBlock

  private class ParameterSynth extends Synthesis {
    final override predicate child(Ast parent, int i, Child child) {
      child = SynthChild(LocalVariableAccessSynthKind(TLocalVariableSynth(parent, i)))
    }

    final override predicate localVariable(Ast n, int i) {
      exists(toRaw(n).(ScriptBlock).getParamBlock().getParameter(i))
    }
  }
}
