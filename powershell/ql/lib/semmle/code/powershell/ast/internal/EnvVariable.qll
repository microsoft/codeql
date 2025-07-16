private import AstImport

class EnvVariable extends Expr, TEnvVariable {
  final override string toString() { result = this.getName() }

  string getName() { any(Synthesis s).envVariableName(this, result) }

  /**
   * Holds if this environment variabler should be considered as a source of
   * user-input.
   *
   * By default, any environment variable is considered to be a source of user-
   * input. However, certain environment variables, for example
   * `$Env:number_of_processors`, are known to not be user-controlled.
   */
  predicate isUserControlled() { any() }
}

class Path extends EnvVariable {
  Path() { this.getName() = "path" }
}

class Temp extends EnvVariable {
  Temp() { this.getName() = ["temp", "tmp"] }
}

class AppData extends EnvVariable {
  AppData() { this.getName() = "appdata" }
}

class LocalAppData extends EnvVariable {
  LocalAppData() { this.getName() = "localappdata" }
}

class ProgramData extends EnvVariable {
  ProgramData() { this.getName() = "programdata" }
}

class PSModulePath extends EnvVariable {
  PSModulePath() { this.getName() = "psmodulepath" }

  final override predicate isUserControlled() { none() }
}

class Username extends EnvVariable {
  Username() { this.getName() = "username" }

  final override predicate isUserControlled() { none() }
}

class UserDomain extends EnvVariable {
  UserDomain() { this.getName() = "userdomain" }

  final override predicate isUserControlled() { none() }
}

class UserProfile extends EnvVariable {
  UserProfile() { this.getName() = "userprofile" }

  final override predicate isUserControlled() { none() }
}

class HomePath extends EnvVariable {
  HomePath() { this.getName() = "homepath" }

  final override predicate isUserControlled() { none() }
}

class ProgramFiles extends EnvVariable {
  ProgramFiles() { this.getName() = "programfiles" }

  final override predicate isUserControlled() { none() }
}

class PSExecutionPolicyPreference extends EnvVariable {
  PSExecutionPolicyPreference() { this.getName() = "psexecutionpolicypreference" }

  final override predicate isUserControlled() { none() }
}

class ComputerName extends EnvVariable {
  ComputerName() { this.getName() = "computername" }

  final override predicate isUserControlled() { none() }
}

class OS extends EnvVariable {
  OS() { this.getName() = "os" }

  final override predicate isUserControlled() { none() }
}

class SystemRoot extends EnvVariable {
  SystemRoot() { this.getName() = "systemroot" }

  final override predicate isUserControlled() { none() }
}

class ProcessorArchitecture extends EnvVariable {
  ProcessorArchitecture() { this.getName() = "processor_architecture" }

  final override predicate isUserControlled() { none() }
}

class NumberOfProcessors extends EnvVariable {
  NumberOfProcessors() { this.getName() = "number_of_processors" }

  final override predicate isUserControlled() { none() }
}

class SystemDrive extends EnvVariable {
  SystemDrive() { this.getName() = "systemdrive" }

  final override predicate isUserControlled() { none() }
}

class Windir extends EnvVariable {
  Windir() { this.getName() = "windir" }

  final override predicate isUserControlled() { none() }
}

class LogonServer extends EnvVariable {
  LogonServer() { this.getName() = "logonserver" }

  final override predicate isUserControlled() { none() }
}

class SessionName extends EnvVariable {
  SessionName() { this.getName() = "sessionname" }

  final override predicate isUserControlled() { none() }
}
