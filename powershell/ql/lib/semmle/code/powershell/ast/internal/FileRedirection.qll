private import TAst
private import Redirection
private import Raw.Raw as Raw

class FileRediction extends Rediction {
  FileRediction() { this = TRedirection(any(Raw::FileRedirection r)) }

  override string toString() { result = "FileRedirection" }
}
