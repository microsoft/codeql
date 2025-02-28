private import Ast
private import Synthesis
private import VariableExpression
private import Location
private import semmle.code.powershell.controlflow.internal.Scope

cached
private module Cached {
  cached
  newtype TVariable =
    TLocalVariableReal(Scope scope, string name) {
      not name = "this" and
      exists(VarAccess va | va.getName() = name and scope = va.getEnclosingScope())
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
  Scope scope;
  string name;

  LocalVariableReal() { this = TLocalVariableReal(scope, name) }

  override string getNameImpl() { result = name }

  override Location getLocationImpl() { result = this.getLocationImpl() } // TODO: Location
}
