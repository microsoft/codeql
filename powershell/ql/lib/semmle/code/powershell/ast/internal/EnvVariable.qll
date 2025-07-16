private import AstImport

class EnvVariable extends Expr, TEnvVariable {
  final override string toString() { result = this.getName() }

  string getName() { any(Synthesis s).envVariableName(this, result) }
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
}

class Username extends EnvVariable {
  Username() { this.getName() = "username" }
}

class UserDomain extends EnvVariable {
  UserDomain() { this.getName() = "userdomain" }
}

class UserProfile extends EnvVariable {
  UserProfile() { this.getName() = "userprofile" }
}

class HomePath extends EnvVariable {
  HomePath() { this.getName() = "homepath" }
}

class ProgramFiles extends EnvVariable {
  ProgramFiles() { this.getName() = "programfiles" }
}

class PSExecutionPolicyPreference extends EnvVariable {
  PSExecutionPolicyPreference() { this.getName() = "psexecutionpolicypreference" }
}

class ComputerName extends EnvVariable {
  ComputerName() { this.getName() = "computername" }
}

class OS extends EnvVariable {
  OS() { this.getName() = "os" }
}

class SystemRoot extends EnvVariable {
  SystemRoot() { this.getName() = "systemroot" }
}

class ProcessorArchitecture extends EnvVariable {
  ProcessorArchitecture() { this.getName() = "processor_architecture" }
}

class NumberOfProcessors extends EnvVariable {
  NumberOfProcessors() { this.getName() = "number_of_processors" }
}

class SystemDrive extends EnvVariable {
  SystemDrive() { this.getName() = "systemdrive" }
}

class Windir extends EnvVariable {
  Windir() { this.getName() = "windir" }
}

class LogonServer extends EnvVariable {
  LogonServer() { this.getName() = "logonserver" }
}

class SessionName extends EnvVariable {
  SessionName() { this.getName() = "sessionname" }
}
