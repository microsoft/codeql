private import Ast
private import Synthesis
private import Location

cached
private module Cached {
  cached
  newtype TVariable =
    TLocalVariableReal(string name) {
      none() // TODO
    } or
    TLocalVariableSynth(Ast n, int i) { any(Synthesis s).localVariable(n, i) }
}

import Cached

private class VariableImpl extends TVariable {
  abstract string getNameImpl();

  final string toString() { result = this.getNameImpl() }

  abstract Location getLocationImpl();
}

class TVariableReal = TLocalVariableReal;

class TLocalVariable = TLocalVariableReal or TLocalVariableSynth;

class LocalVariableReal extends VariableImpl, TLocalVariableReal {
  override string getNameImpl() { result = this.getNameImpl() }

  override Location getLocationImpl() { result = this.getLocationImpl() }
}