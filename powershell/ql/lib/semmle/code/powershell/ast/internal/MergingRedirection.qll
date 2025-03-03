private import TAst
private import Redirection
private import Raw.Raw as Raw

class MergingRedirection extends Redirection {
  MergingRedirection() { this = TRedirection(any(Raw::MergingRedirection r)) }

  override string toString() { result = "MergingRedirection" }
}
