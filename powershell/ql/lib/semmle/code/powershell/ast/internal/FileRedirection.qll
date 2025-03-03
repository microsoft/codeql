private import TAst
private import Redirection
private import Raw.Raw as Raw

class FileRedirection extends Redirection {
  FileRedirection() { this = TRedirection(any(Raw::FileRedirection r)) }

  override string toString() { result = "FileRedirection" }
}
